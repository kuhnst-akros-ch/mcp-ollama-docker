#!/usr/bin/env bash

set -euo pipefail

# Somehow this helps to shut down the proxy when Windsurf exits
exec > >(tee -a /dev/null) 2>&1

PROXY_NAME="mcp-ollama-proxy"
MCP_NAME="mcp-ollama"
created_proxy=0

cleanup() {
  if [[ "$created_proxy" -eq 1 ]]; then
    docker rm -f "$PROXY_NAME" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT INT TERM

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
status=$?

exit $status
