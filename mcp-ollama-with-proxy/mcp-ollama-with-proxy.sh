#!/usr/bin/env bash

set -euo pipefail

PROXY_NAME="mcp-ollama-proxy"
MCP_NAME="mcp-ollama"
created_proxy=0

cleanup() {
  docker rm -f "$PROXY_NAME" >/dev/null 2>&1 || true
}

trap cleanup EXIT INT TERM HUP QUIT ERR

if [[ "$created_proxy" -ne 1 ]]; then
  docker run -d --rm \
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

docker run -i --rm \
  --name "$MCP_NAME" \
  --add-host host.docker.internal:host-gateway \
  -e OLLAMA_HOST="http://host.docker.internal:11434" \
  stefankuhnakros/windsurf-ollama-integration:mcp-ollama
