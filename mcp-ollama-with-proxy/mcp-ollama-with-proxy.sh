#!/usr/bin/env bash
set -euo pipefail

PROXY_NAME="mcp-ollama-proxy"
MCP_NAME="mcp-ollama"

cleanup() {
  # stop/remove proxy if it’s still around
  docker rm -f "$PROXY_NAME" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

# Start proxy detached; auto-remove on stop
docker run \
  -d \
  --rm \
  --name "$PROXY_NAME" \
  --network host \
  mitmproxy/mitmproxy:latest \
  mitmweb \
    --mode "reverse:http://10.7.2.100:11434" \
    --listen-port "11434" \
    --web-host "0.0.0.0" \
    --web-port "11435" \
    --set "web_password=todo_change_me" \
    >/dev/null

# Optional: show proxy logs (non-fatal if it fails)
#docker logs -f "$PROXY_NAME" >/dev/null 2>&1 &

# Run MCP container ATTACHED so Windsurf can connect via stdio
exec docker run \
  -i \
  --rm \
  --name "$MCP_NAME" \
  --add-host host.docker.internal:host-gateway \
  -e OLLAMA_HOST="http://host.docker.internal:11434" \
  stefankuhnakros/windsurf-ollama-integration:mcp-ollama
