@echo off
setlocal enabledelayedexpansion
REM Multiple OSS models: Llama, Mistral, Phi, Gemma, Qwen (edit to add/remove)
set "OSS_MODELS=mistral llama3.2 phi3 gemma2:2b qwen2:1.5b"
echo 🚀 Starting Open LLM Orchestrator stack...

docker compose up -d

echo ⏳ Waiting for Ollama to be ready...

:waitloop
docker exec olo-ollama ollama list >nul 2>&1
if %errorlevel% neq 0 (
    timeout /t 2 >nul
    goto waitloop
)
timeout /t 2 >nul

echo Checking OSS models (default: %OSS_MODELS%)...
for %%m in (%OSS_MODELS%) do (
    docker exec olo-ollama ollama list 2>nul | findstr /i "%%m" >nul 2>&1
    if errorlevel 1 (
        echo 📦 Pulling %%m - this runs automatically on first start...
        docker exec olo-ollama ollama pull %%m
        if !errorlevel! equ 0 (echo ✅ %%m installed.) else (echo ⚠️  %%m pull failed. Retry: docker exec olo-ollama ollama pull %%m)
    ) else (
        echo ✅ %%m already downloaded.
    )
)

echo.
echo ✅ Stack is ready!
echo.
echo 🌐 Chat UI      : http://localhost:3000
echo 🧠 Temporal UI  : http://localhost:8080
echo 🧠 Ollama/Models: http://localhost:11434/api/tags
echo ⚙️  Control API : http://localhost:8080
pause
