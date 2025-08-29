# windsurf-ollama-integration

Several ways to run Ollama as an MCP server in Windsurf.

## Setups

### Ollama as Basic MCP Server

Windsurf is the main orchestrator ("the brain").  
Most tasks are handled by Windsurf; only a few are sent to Ollama.

- Option A: Direct integration
- Option B: Integration with a proxy (see what is sent to Ollama)

## Setup Instructions

### Option A: Basic MCP Server

1. Copy `mcp-ollama/mcp_config.json` to `~/.codeium/windsurf/`
2. Start Windsurf

### Option B: Basic MCP Server with Proxy

1. Copy `mcp-ollama-with-proxy/mcp-ollama-with-proxy.sh` to `~/.codeium/windsurf/`
2. Copy `mcp-ollama-with-proxy/mcp_config.json` to `~/.codeium/windsurf/`
3. Start Windsurf
4. Wait for Docker containers: `ollama-server` and `ollama-proxy`
5. Go to [http://localhost:11435](http://localhost:11435)  
   Use the password from the JSON file (`CHANGE_ME` by default)

> **Important:** Change the password in the JSON file!

### Option C: Coming Soon

More configurations will be added.