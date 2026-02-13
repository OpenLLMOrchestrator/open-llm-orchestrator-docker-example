#!/usr/bin/env bash
set -e
echo "Checking OSS models (Ollama)..."
echo ""
if ! docker exec olo-ollama ollama list 2>/dev/null; then
  echo "Ollama container 'olo-ollama' is not running or not found."
  echo "Start the stack with: docker compose up -d"
  echo "Then pull a model with: docker exec olo-ollama ollama pull mistral"
  exit 1
fi
echo ""
echo "To pull a model: docker exec olo-ollama ollama pull <model>"
echo "  e.g. docker exec olo-ollama ollama pull mistral"
