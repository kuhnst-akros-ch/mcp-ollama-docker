# windsurf-ollama-integration

This project provides several setup options for running Ollama as an MCP server in Windsurf.

## Setups

### Ollama as "Basic MCP server"

Windsurf is still the brain and sees Ollama as a tool.<br/>
Thus few tasks are delegated to Ollama and Windsurf handles most by itself.

Use "Option A" below.<br/>
Use Option B to see what is actually sent to Ollama.

## Setup Options

### Option A: Basic MCP Server
1. Copy `mcp-ollama/mcp_config.json` to `~/.codeium/windsurf/`
2. Start Windsurf

### Option B: Basic MCP Server with Proxy
1. Copy `mcp-ollama-with-proxy/mcp-ollama-with-proxy.sh` to `~/.codeium/windsurf/`
2. Copy `mcp-ollama-with-proxy/mcp_config.json` to `~/.codeium/windsurf/`
3. Start Windsurf
4. Wait for 2 docker containers to start (`ollama-server` and `ollama-proxy`)
5. Open http://localhost:11435 and use the password `CHANGE_ME` from the JSON file.

> Change the password in the JSON file!

### Option C: (Work in Progress)
* Additional configurations coming soon
