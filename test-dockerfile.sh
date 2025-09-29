#!/bin/bash

echo "Testing Dockerfile syntax and build process..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed or not in PATH"
    echo "Please install Docker Desktop or Docker Engine first"
    exit 1
fi

echo "✅ Docker is available"

# Test the main Dockerfile
echo "Building with main Dockerfile (Eclipse Temurin)..."
if docker build -t personal-portfolio:test .; then
    echo "✅ Main Dockerfile build successful!"
    echo "Image: personal-portfolio:test"
    
    # Test running the container
    echo "Testing container startup..."
    if docker run -d --name portfolio-test -p 5000:5000 personal-portfolio:test; then
        echo "✅ Container started successfully!"
        echo "Application should be running at: http://localhost:5000"
        
        # Wait a moment and check health
        sleep 5
        if curl -f http://localhost:5000/ > /dev/null 2>&1; then
            echo "✅ Health check passed!"
        else
            echo "⚠️  Health check failed, but container is running"
        fi
        
        # Cleanup
        echo "Cleaning up test container..."
        docker stop portfolio-test
        docker rm portfolio-test
    else
        echo "❌ Failed to start container"
    fi
else
    echo "❌ Main Dockerfile build failed, trying alternative..."
    
    # Try alternative Dockerfile
    if docker build -f Dockerfile.alternative -t personal-portfolio:test .; then
        echo "✅ Alternative Dockerfile build successful!"
        echo "Image: personal-portfolio:test"
    else
        echo "❌ Both Dockerfiles failed to build"
        exit 1
    fi
fi

echo "Docker test completed!"

