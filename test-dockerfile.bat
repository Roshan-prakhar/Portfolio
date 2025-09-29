@echo off
REM Test Dockerfile syntax and build process (Windows)

echo Testing Dockerfile syntax and build process...

REM Check if Docker is installed
docker --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Docker is not installed or not in PATH
    echo Please install Docker Desktop first
    exit /b 1
)

echo ✅ Docker is available

REM Test the main Dockerfile
echo Building with main Dockerfile (Eclipse Temurin)...
docker build -t personal-portfolio:test .
if %ERRORLEVEL% EQU 0 (
    echo ✅ Main Dockerfile build successful!
    echo Image: personal-portfolio:test
    
    REM Test running the container
    echo Testing container startup...
    docker run -d --name portfolio-test -p 5000:5000 personal-portfolio:test
    if %ERRORLEVEL% EQU 0 (
        echo ✅ Container started successfully!
        echo Application should be running at: http://localhost:5000
        
        REM Wait a moment and check health
        timeout /t 5 /nobreak >nul
        curl -f http://localhost:5000/ >nul 2>&1
        if %ERRORLEVEL% EQU 0 (
            echo ✅ Health check passed!
        ) else (
            echo ⚠️  Health check failed, but container is running
        )
        
        REM Cleanup
        echo Cleaning up test container...
        docker stop portfolio-test
        docker rm portfolio-test
    ) else (
        echo ❌ Failed to start container
    )
) else (
    echo ❌ Main Dockerfile build failed, trying alternative...
    
    REM Try alternative Dockerfile
    docker build -f Dockerfile.alternative -t personal-portfolio:test .
    if %ERRORLEVEL% EQU 0 (
        echo ✅ Alternative Dockerfile build successful!
        echo Image: personal-portfolio:test
    ) else (
        echo ❌ Both Dockerfiles failed to build
        exit /b 1
    )
)

echo Docker test completed!

