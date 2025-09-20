#!/bin/bash

# Docker run script for personal portfolio
echo "Starting personal portfolio container..."

# Check if image exists
if ! docker image inspect personal-portfolio:latest >/dev/null 2>&1; then
    echo "Image not found. Building first..."
    ./docker-build.sh
fi

# Run the container
docker run -d \
  --name personal-portfolio \
  -p 5000:5000 \
  -e PORT=5000 \
  -e JAVA_OPTS="-Xmx512m -Xms256m" \
  --restart unless-stopped \
  personal-portfolio:latest

# Check if container started successfully
if [ $? -eq 0 ]; then
    echo "✅ Container started successfully!"
    echo "Application is running at: http://localhost:5000"
    echo ""
    echo "To view logs: docker logs personal-portfolio"
    echo "To stop: docker stop personal-portfolio"
    echo "To remove: docker rm personal-portfolio"
else
    echo "❌ Failed to start container!"
    exit 1
fi
