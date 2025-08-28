FROM python:3.11-slim

WORKDIR /app

# Install requirements
RUN --mount=type=bind,source=requirements.txt,target=/app/requirements.txt \
    pip install --no-cache-dir -r requirements.txt

# Set the command to run the server directly
CMD ["python", "/usr/local/lib/python3.11/site-packages/mcp_ollama/server.py"]
