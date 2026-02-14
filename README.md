# Open LLM Orchestrator – Docker Example

Ready-to-run Docker Compose setup for **Open LLM Orchestrator**, suitable for **Open Source Society** and local use. One-click install brings up the full stack and default OSS models.

---

## One-Click Install (Recommended)

**Windows:** Double-click **`install.bat`** in the project root.

- Checks Docker is installed and running.
- Starts the stack and downloads multiple default OSS models (Mistral, Llama 3.2, Phi-3, Gemma 2, Qwen2) on first run.
- See **[SETUP.md](SETUP.md)** for full step-by-step instructions.

**Linux / macOS:** From the project root run `./scripts/start.sh`.

---

## What This Stack Includes

| Component        | Purpose              |
|------------------|----------------------|
| Temporal Server  | Workflow engine      |
| Temporal UI      | Workflow dashboard   |
| Qdrant           | Vector database      |
| Redis            | Cache / store         |
| Redis Insight    | Redis GUI & CLI       |
| Ollama           | OSS LLM runtime       |
| **OpenAI OSS**   | OpenAI-compatible API (LiteLLM → Ollama) |
| PostgreSQL       | Temporal DB          |
| Elasticsearch    | Search / indexing    |
| Kibana           | Elasticsearch UI     |

*(Control Plane and Chat UI are optional; uncomment in `docker-compose.yml` when needed.)*

---

## Architecture Overview

Chat UI → Control Plane (Spring Boot + Temporal) → RAG Workflow → Qdrant (Vector Search) + Ollama (Mistral / Llama) → Response  

Inference is orchestrated via Temporal workflows.

---

## Quick Start (Manual)

```bash
# Start everything (and pull default models on first run)
docker compose up -d
# Windows: scripts\start.bat   |   Linux/macOS: ./scripts/start.sh

# Stop
docker compose down
# Windows: scripts\stop.bat   |   Linux/macOS: ./scripts/stop.sh
```

---

## Documentation

- **[SETUP.md](SETUP.md)** – Step-by-step setup for every environment (prerequisites, install, verify, daily use, troubleshooting).
- **Ollama models (list):** http://localhost:11434/api/tags  
- **Temporal UI:** http://localhost:8080  
- **Qdrant dashboard:** http://localhost:6333/dashboard  
- **Redis Insight:** http://localhost:5540 (add Redis: host `redis`, port `6379`)  
- **OpenAI OSS (LiteLLM):** http://localhost:4000 – OpenAI-compatible API; no authentication. See **Available models** below.

---

## Available models (OpenAI OSS)

These models are available at **http://localhost:4000** (from `GET /v1/models`):

| Model ID     | Description        |
|--------------|--------------------|
| `mistral`    | Mistral 7B         |
| `llama3.2`   | Meta Llama 3.2     |
| `phi3`       | Microsoft Phi-3    |
| `gemma2:2b`  | Google Gemma 2 2B  |
| `qwen2:1.5b` | Alibaba Qwen2 1.5B |

Use the **model ID** in the `model` field when calling `/chat/completions` or any OpenAI-compatible client.

---

## OpenAI OSS – Quick check

The OpenAI OSS endpoint (LiteLLM) runs with **no authentication**. After the stack is up:

**List models:**
```bash
curl -s http://localhost:4000/v1/models
```

**Chat (example):**
```bash
curl -s -X POST http://localhost:4000/chat/completions \
  -H "Content-Type: application/json" \
  -d '{"model":"mistral","messages":[{"role":"user","content":"Hello!"}]}'
```

Use base URL **http://localhost:4000** with any OpenAI-compatible client (SDK, LangChain, etc.); `api_key` can be omitted or set to any value.