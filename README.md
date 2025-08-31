# Ollama as MC Server in Windsurf

MCP server configuration for IDEs to connect to Ollama instances.<br/>
(Pre-configured for Akros Marvin server.)

## Requirements
- Docker installed and running
- Ollama server (local or remote)

## Quick Start

> **Note for first-time setup:** The Docker image will be downloaded automatically when you first start the service. This may take a few minutes depending on your internet connection.

### Standard Setup
Just one config file is all you need to use Ollama as an MCP server:
```bash
mkdir -p ~/.codeium/windsurf
curl -L -o ~/.codeium/windsurf/mcp_config.json \
  https://raw.githubusercontent.com/kuhnst-akros-ch/mcp-ollama-docker/refs/heads/main/mcp-ollama/mcp_config.json
```

### With Proxy (Recommended)
See exactly how your IDE uses the Ollama models. Great for optimizing model usage and understanding what's happening under the hood:
```bash
mkdir -p ~/.codeium/windsurf
curl -L -o ~/.codeium/windsurf/mcp_config.json \
  https://raw.githubusercontent.com/kuhnst-akros-ch/mcp-ollama-docker/refs/heads/main/mcp-ollama-with-proxy/mcp_config.json

curl -L -o ~/.codeium/windsurf/mcp-ollama-with-proxy.sh \
  https://raw.githubusercontent.com/kuhnst-akros-ch/mcp-ollama-docker/refs/heads/main/mcp-ollama-with-proxy/mcp-ollama-with-proxy.sh
chmod +x ~/.codeium/windsurf/mcp-ollama-with-proxy.sh
```
Access proxy at http://localhost:11436 (password in the json, default=CHANGE_ME)

> **For Windows:**<br/>
> If `bash` is inside WSL, then replace this in the json:<br/>
> `"~/.codeium/windsurf/` -> `"/mnt/c/Users/USERNAME/.codeium/windsurf/`<br/>
> and use your username for `USERNAME`.

## Configuration

Edit `mcp_config.json` to customize:
- `OLLAMA_HOST`: Points to your Ollama server (default: Akros' Marvin)
- Web interface port: 11436 (change if needed)
- Default password: `CHANGE_ME` (seriously, change this!)
