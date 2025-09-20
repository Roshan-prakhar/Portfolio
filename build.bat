@echo off
REM Build script for personal portfolio (Windows)

echo Building personal portfolio application...

REM Make sure we're in the right directory
cd /d "%~dp0"

REM Clean and package the application
echo Running Maven clean package...
mvnw.cmd clean package -DskipTests

REM Check if build was successful
if %ERRORLEVEL% EQU 0 (
    echo Build successful! JAR file created at target\portfolio.jar
    dir target\portfolio.jar
) else (
    echo Build failed!
    exit /b 1
)
