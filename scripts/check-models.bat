@echo off
echo Checking OSS models (Ollama)...
echo.
docker exec olo-ollama ollama list 2>nul
if %errorlevel% neq 0 (
    echo Ollama container "olo-ollama" is not running or not found.
    echo Start the stack with: docker compose up -d
    echo Then pull a model with: docker exec olo-ollama ollama pull mistral
    exit /b 1
)
echo.
echo To pull a model: docker exec olo-ollama ollama pull ^<model^>
echo   e.g. docker exec olo-ollama ollama pull mistral
exit /b 0
