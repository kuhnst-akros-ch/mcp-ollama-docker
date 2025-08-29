#!/usr/bin/env bash
set -euo pipefail

LOG="/home/kuhnst/.codeium/windsurf/mcp.log"
exec > >(tee -a "$LOG") 2>&1
echo "=== $(date -Is) :: start mcp-ollama-with-proxy.sh ==="

echo "whoami: $(whoami)"
echo "id: $(id)"
echo "groups: $(groups || true)"
echo "PATH: $PATH"
echo "which docker: $(command -v docker || echo 'not found')"
echo "docker.sock perms: $(ls -l /var/run/docker.sock || true)"

# Be explicit about docker path if PATH resolution fails
DOCKER_BIN="$(command -v docker || true)"
if [[ -z "$DOCKER_BIN" ]]; then
  for c in /usr/bin/docker /usr/local/bin/docker; do
    [[ -x "$c" ]] && DOCKER_BIN="$c" && break
  done
fi
if [[ -z "$DOCKER_BIN" ]]; then
  echo "ERROR: docker not found in PATH; aborting"
  exit 127
fi
"$DOCKER_BIN" version || { echo "ERROR: docker unusable"; exit 1; }

PROXY_NAME="mcp-ollama-proxy"
MCP_NAME="mcp-ollama"

cleanup() {
  echo "cleanup: stopping $PROXY_NAME"
  "$DOCKER_BIN" rm -f "$PROXY_NAME" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

echo "starting proxy (detached)…"
"$DOCKER_BIN" run -d --rm \
  --name "$PROXY_NAME" \
  --network host \
  mitmproxy/mitmproxy:latest \
  mitmweb \
    --mode "reverse:http://10.7.2.100:11434" \
    --listen-port "11434" \
    --web-host "0.0.0.0" \
    --web-port "11435" \
    --set "web_password=todo_change_me"

echo "proxy started. container list:"
"$DOCKER_BIN" ps --format 'table {{.Names}}\t{{.Status}}\t{{.Image}}'

# Keep a background log follower (non-fatal if it exits)
("$DOCKER_BIN" logs -f "$PROXY_NAME" & ) || true

echo "starting MCP container (attached to stdio)…"
exec "$DOCKER_BIN" run -i --rm \
  --name "$MCP_NAME" \
  --add-host host.docker.internal:host-gateway \
  -e OLLAMA_HOST="http://host.docker.internal:11434" \
  stefankuhnakros/windsurf-ollama-integration:mcp-ollama
