@echo off
setlocal
title Open LLM Orchestrator - One-Click Install
cd /d "%~dp0"

echo.
echo ============================================================
echo   Open LLM Orchestrator - One-Click Setup (Open Source)
echo ============================================================
echo.

REM Step 1: Check Docker is installed
echo [Step 1/2] Checking Docker...
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Docker is not installed or not in PATH.
    echo.
    echo Please install Docker Desktop for Windows first:
    echo   https://docs.docker.com/desktop/install/windows-install/
    echo.
    echo Then start Docker Desktop and run this script again.
    echo.
    pause
    exit /b 1
)
docker --version
echo.

REM Step 2: Check Docker daemon is running
echo [Step 2/2] Checking Docker is running...
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Docker is installed but not running.
    echo Please start "Docker Desktop" from the Start menu and try again.
    echo.
    pause
    exit /b 1
)
echo Docker is running.
echo.

echo ------------------------------------------------------------
echo Starting the stack and downloading OSS models...
echo This may take several minutes on first run.
echo ------------------------------------------------------------
echo.

call "%~dp0scripts\start.bat"

exit /b 0
