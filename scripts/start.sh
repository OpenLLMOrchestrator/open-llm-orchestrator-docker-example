#!/bin/bash

set -e

echo "🚀 Starting Open LLM Orchestrator stack..."

docker compose up -d

echo "⏳ Waiting for Ollama to be ready..."

until docker exec olo-ollama ollama list >/dev/null 2>&1; do
  sleep 2
done
sleep 2

OSS_MODELS="${OSS_MODELS:-mistral llama3.2}"
echo "Checking OSS models (default: $OSS_MODELS)..."
for model in $OSS_MODELS; do
  if ! docker exec olo-ollama ollama list 2>/dev/null | grep -qi "$model"; then
    echo "📦 Pulling $model - this runs automatically on first start..."
    if docker exec olo-ollama ollama pull "$model"; then
      echo "✅ $model installed."
    else
      echo "⚠️  $model pull failed. Retry: docker exec olo-ollama ollama pull $model"
    fi
  else
    echo "✅ $model already downloaded."
  fi
done

echo ""
echo "✅ Stack is ready!"
echo ""
echo "🌐 Chat UI      : http://localhost:3000"
echo "🧠 Temporal UI  : http://localhost:8080"
echo "🧠 Ollama/Models: http://localhost:11434/api/tags"
echo "⚙️  Control API : http://localhost:8080"
echo ""
