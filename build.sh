#!/bin/bash

# Build script for personal portfolio
echo "Building personal portfolio application..."

# Make sure we're in the right directory
cd "$(dirname "$0")"

# Clean and package the application
echo "Running Maven clean package..."
./mvnw clean package -DskipTests

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "Build successful! JAR file created at target/portfolio.jar"
    ls -la target/portfolio.jar
else
    echo "Build failed!"
    exit 1
fi
