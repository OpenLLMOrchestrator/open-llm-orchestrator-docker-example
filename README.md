# Open LLM Orchestrator – Docker Example

Ready-to-run Docker Compose setup for **Open LLM Orchestrator**, suitable for **Open Source Society** and local use. One-click install brings up the full stack and default OSS models.

---

## One-Click Install (Recommended)

**Windows:** Double-click **`install.bat`** in the project root.

- Checks Docker is installed and running.
- Starts the stack and downloads default OSS models (Mistral, Llama 3.2) on first run.
- See **[SETUP.md](SETUP.md)** for full step-by-step instructions.

**Linux / macOS:** From the project root run `./scripts/start.sh`.

---

## What This Stack Includes

| Component        | Purpose              |
|------------------|----------------------|
| Temporal Server  | Workflow engine      |
| Temporal UI      | Workflow dashboard   |
| Qdrant           | Vector database      |
| Ollama           | OSS LLM runtime      |
| PostgreSQL       | Temporal DB           |
| Elasticsearch    | Search / indexing     |
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
