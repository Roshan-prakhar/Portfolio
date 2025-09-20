@echo off
REM Docker run script for personal portfolio (Windows)

echo Starting personal portfolio container...

REM Check if image exists
docker image inspect personal-portfolio:latest >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Image not found. Building first...
    call docker-build.bat
)

REM Run the container
docker run -d ^
  --name personal-portfolio ^
  -p 5000:5000 ^
  -e PORT=5000 ^
  -e JAVA_OPTS="-Xmx512m -Xms256m" ^
  --restart unless-stopped ^
  personal-portfolio:latest

REM Check if container started successfully
if %ERRORLEVEL% EQU 0 (
    echo ✅ Container started successfully!
    echo Application is running at: http://localhost:5000
    echo.
    echo To view logs: docker logs personal-portfolio
    echo To stop: docker stop personal-portfolio
    echo To remove: docker rm personal-portfolio
) else (
    echo ❌ Failed to start container!
    exit /b 1
)
