# MCP-Ollama Server for IDEs

MCP server configuration for IDEs to connect to Ollama instances. Pre-configured for Akros' Marvin server by default.

## Quick Start

### Standard Setup
```bash
cp mcp-ollama/mcp_config.json ~/.codeium/windsurf/
# Edit ~/.codeium/windsurf/mcp_config.json if needed
```

### With Proxy (Recommended)
See exactly how your IDE uses the Ollama models. Great for optimizing model usage and understanding what's happening under the hood:
```bash
cp mcp-ollama-with-proxy/mcp-ollama-with-proxy.sh ~/.codeium/windsurf/
cp mcp-ollama-with-proxy/mcp_config.json ~/.codeium/windsurf/
# Access proxy at http://localhost:11435 (password in config)
```

## Configuration

Edit `mcp_config.json` to customize:
- `OLLAMA_HOST`: Points to your Ollama server (default: Akros' Marvin)
- Web interface port: 11435 (change if needed)
- Default password: `CHANGE_ME` (seriously, change this!)
