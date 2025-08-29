# windsurf-ollama-integration

Several ways to run Ollama as an MCP server in Windsurf.

## Setups

### Ollama as Basic MCP Server

Windsurf is the main orchestrator ("the brain").  
Most tasks are handled by Windsurf; only a few are sent to Ollama.

- [Option A: Basic MCP Server](#option-a-basic-mcp-server)
- [Option B: Basic MCP Server with Proxy](#option-b-basic-mcp-server-with-proxy)  
  See what is sent to Ollama 📡 
- [Option C: Coming Soon](#option-c-coming-soon)

## Setup Instructions

### Option A: Basic MCP Server

1. Copy `mcp-ollama/mcp_config.json` to `~/.codeium/windsurf/`
2. Start Windsurf

### Option B: Basic MCP Server with Proxy

This lets you see what is sent to Ollama.

1. Copy `mcp-ollama-with-proxy/mcp-ollama-with-proxy.sh` to `~/.codeium/windsurf/`
2. Copy `mcp-ollama-with-proxy/mcp_config.json` to `~/.codeium/windsurf/`
3. Start Windsurf
4. Wait for Docker containers: `ollama-server` and `ollama-proxy`
5. Go to [http://localhost:11435](http://localhost:11435)  
   Use the password from the JSON file (`CHANGE_ME` by default)

> **Important:** Change the password in the JSON file!

### Option C: Coming Soon

More configurations will be added.