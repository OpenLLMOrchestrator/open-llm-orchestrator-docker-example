# Open LLM Orchestrator – Step-by-Step Setup Guide

This guide is for the **Open Source Society** and anyone who wants to run the stack locally. Every step is explained so you can follow along even if you are new to Docker.

---

## Table of Contents

1. [What You Will Get](#what-you-will-get)
2. [Prerequisites](#prerequisites)
3. [Step 1: Install Docker Desktop](#step-1-install-docker-desktop)
4. [Step 2: Get the Project](#step-2-get-the-project)
5. [Step 3: One-Click Install (First Run)](#step-3-one-click-install-first-run)
6. [Step 4: Verify Everything Is Running](#step-4-verify-everything-is-running)
7. [Step 5: Daily Use – Start and Stop](#step-5-daily-use--start-and-stop)
8. [Step 6: Check or Add OSS Models](#step-6-check-or-add-oss-models)
9. [Troubleshooting](#troubleshooting)

---

## What You Will Get

After setup you will have a local stack with:

| Component        | Purpose                    | URL (after start)              |
|-----------------|----------------------------|---------------------------------|
| **Temporal**    | Workflow engine            | Server: `localhost:7233`        |
| **Temporal UI** | View workflows             | http://localhost:8080           |
| **Ollama**      | Run open-source LLMs       | http://localhost:11434          |
| **OpenAI OSS**  | OpenAI-compatible API (LiteLLM) | http://localhost:4000     |
| **Qdrant**      | Vector database for RAG    | http://localhost:6333           |
| **Redis**       | In-memory cache / store    | `localhost:6379`                 |
| **Redis Insight** | Redis GUI & CLI           | http://localhost:5540           |
| **PostgreSQL**  | Database for Temporal      | Internal only                   |
| **Elasticsearch** | Search / indexing        | http://localhost:9200           |
| **Kibana**      | Elasticsearch UI           | http://localhost:5601           |

Default OSS models installed on first run: **Mistral**, **Llama 3.2**, **Phi-3**, **Gemma 2 (2B)**, **Qwen2 (1.5B)**. All are exposed via the OpenAI OSS endpoint (LiteLLM) at http://localhost:4000.

---

## Prerequisites

- **Windows 10/11** (64-bit) or **Linux** / **macOS**
- **At least 8 GB RAM** (16 GB recommended if you run multiple models)
- **Enough free disk space** (about 10 GB for Docker images + models)
- **Internet** for the first run (downloads images and models)

---

## Step 1: Install Docker Desktop

Docker runs the whole stack in containers. You only need to install it once.

### Windows

1. Download **Docker Desktop for Windows**:  
   https://docs.docker.com/desktop/install/windows-install/
2. Run the installer and follow the steps (WSL 2 is recommended if asked).
3. Restart the PC if prompted.
4. Open **Docker Desktop** from the Start menu and wait until it says “Docker Desktop is running”.

### Linux

- Install Docker Engine: https://docs.docker.com/engine/install/  
- Start the service: `sudo systemctl start docker`  
- Add your user to the `docker` group so you don’t need `sudo`:  
  `sudo usermod -aG docker $USER` (then log out and back in).

### macOS

- Download Docker Desktop for Mac: https://docs.docker.com/desktop/install/mac-install/  
- Install and open Docker Desktop; wait until it is running.

### Check Docker

Open a terminal (PowerShell on Windows, Terminal on Mac/Linux) and run:

```bash
docker --version
docker info
```

If both commands work, Docker is installed and running.

---

## Step 2: Get the Project

1. **Download or clone** this repository to your machine.
   - **Option A (Git):**  
     `git clone <repository-url>`  
     then `cd Open-LLM-Orchestrator-Docker-Example`
   - **Option B (ZIP):**  
     Download the ZIP, extract it, and open a terminal in the extracted folder (e.g. `Open-LLM-Orchestrator-Docker-Example`).

2. Confirm you are in the **project root** (you should see `docker-compose.yml`, `install.bat`, and a `scripts` folder).

---

## Step 3: One-Click Install (First Run)

This step starts the whole stack and downloads the default OSS models. Run it **once** from the project root.

### Windows

1. Double-click **`install.bat`** in the project root, **or**
2. Open PowerShell/CMD in the project folder and run:
   ```bat
   install.bat
   ```

The script will:

- Check that Docker is installed and running.
- Start all services with `docker compose up -d`.
- Wait until Ollama is ready.
- Download multiple OSS models (Mistral, Llama 3.2, Phi-3, Gemma 2, Qwen2) if not already present.

The first run can take **several minutes** (downloading images and models). Later runs are much faster.

### Linux / macOS

From the project root:

```bash
chmod +x scripts/start.sh
./scripts/start.sh
```

Or run the same steps manually (see README).

---

## Step 4: Verify Everything Is Running

After the install script finishes:

1. **Temporal UI**  
   Open in a browser: **http://localhost:8080**  
   You should see the Temporal dashboard.

2. **Ollama models**  
   Open: **http://localhost:11434/api/tags**  
   You should see a JSON list of installed models (e.g. mistral, llama3.2, phi3, gemma2:2b, qwen2:1.5b).

3. **Qdrant**  
   Open: **http://localhost:6333/dashboard**  
   You should see the Qdrant UI (may be empty until you use the app).

4. **Redis Insight**  
   Open: **http://localhost:5540**  
   Add Redis connection: host `redis`, port `6379` (no password by default).

5. **OpenAI OSS (LiteLLM)**  
   Use **http://localhost:4000** as the API base with any OpenAI-compatible client.  
   Models: `mistral`, `llama3.2`, `phi3`, `gemma2:2b`, `qwen2:1.5b`. No authentication required.

6. **Optional:**  
   - Kibana: http://localhost:5601  
   - Elasticsearch: http://localhost:9200  

If these URLs load, the stack is running correctly.

---

## Step 5: Daily Use – Start and Stop

- **Start again (after reboot or stop):**  
  - **Windows:** Double-click **`install.bat`** or run **`scripts\start.bat`**.  
  - **Linux/macOS:** Run **`./scripts/start.sh`**.  
  Models already downloaded will be skipped.

- **Stop the stack:**  
  - **Windows:** Run **`scripts\stop.bat`**.  
  - **Linux/macOS:** Run **`./scripts/stop.sh`**.  
  Or from the project root: `docker compose down`.

- **Start without pulling models again:**  
  From project root: `docker compose up -d`.  
  Then use the URLs above to verify.

---

## Step 6: Check or Add OSS Models

- **List models (browser):**  
  http://localhost:11434/api/tags  

- **List models (command line):**  
  ```bat
  docker exec olo-ollama ollama list
  ```

- **Add another model (e.g. Phi-3):**  
  ```bat
  docker exec olo-ollama ollama pull phi3
  ```

- **Change default models for the start script:**  
  Edit **`scripts\start.bat`** (Windows) or **`scripts\start.sh`** (Linux/macOS) and change the line that sets `OSS_MODELS` (e.g. add `phi3` or use `llama3` instead of `llama3.2`).

**Using the OpenAI OSS endpoint (LiteLLM):**  
Use base URL **http://localhost:4000** with the OpenAI SDK. Available models: `mistral`, `llama3.2`, `phi3`, `gemma2:2b`, `qwen2:1.5b`. Example (Python):

```python
from openai import OpenAI
client = OpenAI(base_url="http://localhost:4000", api_key="not-needed")
r = client.chat.completions.create(model="mistral", messages=[{"role": "user", "content": "Hello!"}])
print(r.choices[0].message.content)
```

To add more OSS models: (1) add the model name to `OSS_MODELS` in **`scripts\start.bat`** (or `start.sh`) so it is pulled on start, and (2) add a matching entry in **`litellm/config.yaml`**, then restart the `openai-oss` container.

---

## Troubleshooting

| Problem | What to do |
|--------|------------|
| “Docker is not installed” | Install Docker Desktop (Step 1) and restart the terminal. |
| “Docker is not running” | Start **Docker Desktop** and wait until it is fully up, then run `install.bat` again. |
| “No such container: olo-ollama” | The stack is not up. Run **`install.bat`** or **`scripts\start.bat`** from the project root. |
| Port already in use | Another app is using a port (e.g. 8080, 11434). Stop that app or change the port in `docker-compose.yml`. |
| Model pull failed | Check internet. For a specific model (e.g. llama3-oss), use the correct Ollama name (e.g. `llama3.2`). See Step 6. |
| Script closes too fast | Run the script from PowerShell/CMD so the window stays open, or add `pause` at the end (already in `start.bat`). |

### Reset and start over

To remove all containers and volumes and start clean:

```bat
docker compose down -v
install.bat
```

Warning: `-v` deletes data (including downloaded models). You will need to download models again.

---

## Quick Reference

| Action | Windows | Linux / macOS |
|--------|---------|----------------|
| First-time setup | `install.bat` | `./scripts/start.sh` |
| Start stack | `scripts\start.bat` or `install.bat` | `./scripts/start.sh` |
| Stop stack | `scripts\stop.bat` | `./scripts/stop.sh` |
| List Ollama models | http://localhost:11434/api/tags or `docker exec olo-ollama ollama list` | Same |

---

*This setup is intended for the Open Source Society and local development. For production, use proper security, secrets, and resource limits.*
