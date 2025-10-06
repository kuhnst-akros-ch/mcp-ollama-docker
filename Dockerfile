FROM python:3-alpine

WORKDIR /app

RUN pip install --no-cache-dir mcp-ollama \
    && adduser -D -u 10001 appuser

USER appuser

# Set the command to run the MCP server with stdio transport
CMD ["python", "-m", "mcp_ollama"]
