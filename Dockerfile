FROM python:3-alpine AS builder

# Install git and build dependencies
RUN apk add --no-cache git

# Clone the specific branch from your fork
RUN git clone --branch feature/dependency_bumps https://github.com/Wuodan/mcp-ollama.git /tmp/mcp-ollama \
    && cd /tmp/mcp-ollama \
    && python3 -m venv /tmp/venv \
    && source /tmp/venv/bin/activate \
    && pip install build hatchling \
    && python -m build --wheel --no-isolation

FROM python:3-alpine

WORKDIR /app

# Copy the built wheel from builder stage
COPY --from=builder /tmp/mcp-ollama/dist/*.whl /tmp/

# Install the wheel and clean up
RUN pip install --no-cache-dir /tmp/*.whl \
    && rm /tmp/*.whl \
    && adduser -D -u 10001 appuser

USER appuser

# Set the command to run the MCP server with stdio transport
CMD ["python", "-m", "mcp_ollama"]
