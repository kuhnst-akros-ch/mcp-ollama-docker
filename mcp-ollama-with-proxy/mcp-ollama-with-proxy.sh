#!/usr/bin/env bash
set -euo pipefail

# Resolve docker binary explicitly
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
"$DOCKER_BIN" version >/dev/null || { echo "ERROR: docker unusable"; exit 1; }

PROXY_NAME="mcp-ollama-proxy"
MCP_NAME="mcp-ollama"
created_proxy=0

cleanup() {
  echo "cleanup: stopping $PROXY_NAME (created_proxy=$created_proxy)"
  if [[ "$created_proxy" -eq 1 ]]; then
    "$DOCKER_BIN" rm -f "$PROXY_NAME" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT INT TERM

echo "starting proxy (detached)…"
if "$DOCKER_BIN" ps --format '{{.Names}}' | grep -qx "$PROXY_NAME"; then
  echo "proxy already running; not creating a new one"
else
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
  created_proxy=1
fi

echo "proxy started. container list:"
"$DOCKER_BIN" ps --format 'table {{.Names}}\t{{.Status}}\t{{.Image}}'

# Follow proxy logs in background (non-fatal if it exits)
("$DOCKER_BIN" logs -f "$PROXY_NAME" >/dev/null 2>&1 & ) || true

echo "starting MCP container (attached to stdio)…"
"$DOCKER_BIN" run -i --rm \
  --name "$MCP_NAME" \
  --add-host host.docker.internal:host-gateway \
  -e OLLAMA_HOST="http://host.docker.internal:11434" \
  stefankuhnakros/windsurf-ollama-integration:mcp-ollama
status=$?

echo "MCP container exited with status $status"
exit $status
