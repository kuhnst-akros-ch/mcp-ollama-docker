FROM python:3-alpine

WORKDIR /app

# Install requirements
RUN --mount=type=bind,source=requirements.txt,target=/app/requirements.txt \
    pip install --no-cache-dir -r requirements.txt

# Set the command to run the MCP server with stdio transport
CMD ["python", "-m", "mcp_ollama.server"]
