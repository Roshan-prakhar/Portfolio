#!/bin/bash

# Docker build script for personal portfolio
echo "Building Docker image for personal portfolio..."

# Build the Docker image
docker build -t personal-portfolio:latest .

# Check if build was successful
if [ $? -eq 0 ]; then
    echo "✅ Docker image built successfully!"
    echo "Image: personal-portfolio:latest"
    echo ""
    echo "To run the container:"
    echo "  docker run -p 5000:5000 personal-portfolio:latest"
    echo ""
    echo "Or use Docker Compose:"
    echo "  docker-compose up"
else
    echo "❌ Docker build failed!"
    exit 1
fi
