@echo off
REM Docker build script for personal portfolio (Windows)

echo Building Docker image for personal portfolio...

REM Build the Docker image
docker build -t personal-portfolio:latest .

REM Check if build was successful
if %ERRORLEVEL% EQU 0 (
    echo ✅ Docker image built successfully!
    echo Image: personal-portfolio:latest
    echo.
    echo To run the container:
    echo   docker run -p 5000:5000 personal-portfolio:latest
    echo.
    echo Or use Docker Compose:
    echo   docker-compose up
) else (
    echo ❌ Docker build failed!
    exit /b 1
)
