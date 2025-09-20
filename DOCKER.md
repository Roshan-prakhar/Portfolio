# Docker Deployment Guide

This guide covers deploying the Personal Portfolio application using Docker.

## Prerequisites

- Docker installed on your system
- Docker Compose (optional, for easier management)

## Quick Start

### 1. Build and Run with Docker

```bash
# Build the Docker image
docker build -t personal-portfolio .

# Run the container
docker run -p 5000:5000 personal-portfolio
```

### 2. Using Docker Compose (Recommended)

```bash
# Start the application
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the application
docker-compose down
```

### 3. Using Build Scripts

**Linux/Mac:**
```bash
# Build the image
./docker-build.sh

# Run the container
./docker-run.sh
```

**Windows:**
```cmd
# Build the image
docker-build.bat

# Run the container
docker-run.bat
```

## Docker Image Details

### Multi-Stage Build
The Dockerfile uses a multi-stage build process:

1. **Builder Stage**: Uses `openjdk:21-jdk-slim` to compile the application
2. **Runtime Stage**: Uses `openjdk:21-jre-slim` for a smaller production image

### Security Features
- Non-root user execution
- Minimal runtime image
- Health checks included
- Optimized JVM settings for containers

### Image Optimization
- Multi-stage build reduces final image size
- Only runtime dependencies included
- JVM optimized for container environments
- Health checks for container orchestration

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | 5000 | Server port |
| `JAVA_OPTS` | `-Xmx512m -Xms256m -XX:+UseContainerSupport -XX:MaxRAMPercentage=75.0` | JVM options |

## Container Management

### Basic Commands

```bash
# Build image
docker build -t personal-portfolio .

# Run container
docker run -d --name portfolio -p 5000:5000 personal-portfolio

# View logs
docker logs portfolio

# Stop container
docker stop portfolio

# Remove container
docker rm portfolio

# Remove image
docker rmi personal-portfolio
```

### Docker Compose Commands

```bash
# Start services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down

# Rebuild and start
docker-compose up --build -d

# View service status
docker-compose ps
```

## Health Checks

The container includes built-in health checks:

- **Endpoint**: `http://localhost:5000/`
- **Interval**: 30 seconds
- **Timeout**: 3 seconds
- **Retries**: 3
- **Start Period**: 5 seconds

## Production Deployment

### 1. Cloud Platforms

#### AWS ECS
```yaml
# task-definition.json
{
  "family": "personal-portfolio",
  "networkMode": "awsvpc",
  "requiresCompatibilities": ["FARGATE"],
  "cpu": "256",
  "memory": "512",
  "executionRoleArn": "arn:aws:iam::account:role/ecsTaskExecutionRole",
  "containerDefinitions": [
    {
      "name": "portfolio",
      "image": "your-registry/personal-portfolio:latest",
      "portMappings": [
        {
          "containerPort": 5000,
          "protocol": "tcp"
        }
      ],
      "environment": [
        {
          "name": "PORT",
          "value": "5000"
        }
      ]
    }
  ]
}
```

#### Google Cloud Run
```bash
# Build and push to Google Container Registry
docker build -t gcr.io/PROJECT_ID/personal-portfolio .
docker push gcr.io/PROJECT_ID/personal-portfolio

# Deploy to Cloud Run
gcloud run deploy personal-portfolio \
  --image gcr.io/PROJECT_ID/personal-portfolio \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated
```

#### Azure Container Instances
```bash
# Create resource group
az group create --name portfolio-rg --location eastus

# Deploy container
az container create \
  --resource-group portfolio-rg \
  --name personal-portfolio \
  --image personal-portfolio:latest \
  --ports 5000 \
  --environment-variables PORT=5000
```

### 2. Kubernetes Deployment

```yaml
# k8s-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: personal-portfolio
spec:
  replicas: 3
  selector:
    matchLabels:
      app: personal-portfolio
  template:
    metadata:
      labels:
        app: personal-portfolio
    spec:
      containers:
      - name: portfolio
        image: personal-portfolio:latest
        ports:
        - containerPort: 5000
        env:
        - name: PORT
          value: "5000"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
---
apiVersion: v1
kind: Service
metadata:
  name: personal-portfolio-service
spec:
  selector:
    app: personal-portfolio
  ports:
  - port: 80
    targetPort: 5000
  type: LoadBalancer
```

## Monitoring and Logging

### View Logs
```bash
# Container logs
docker logs personal-portfolio

# Follow logs
docker logs -f personal-portfolio

# Docker Compose logs
docker-compose logs -f
```

### Health Check
```bash
# Check container health
docker inspect personal-portfolio --format='{{.State.Health.Status}}'

# Manual health check
curl http://localhost:5000/
```

## Troubleshooting

### Common Issues

1. **Port Already in Use**
   ```bash
   # Check what's using port 5000
   netstat -tulpn | grep :5000
   
   # Use different port
   docker run -p 8080:5000 personal-portfolio
   ```

2. **Out of Memory**
   ```bash
   # Increase memory limit
   docker run -m 1g -p 5000:5000 personal-portfolio
   ```

3. **Build Failures**
   ```bash
   # Clean build
   docker build --no-cache -t personal-portfolio .
   ```

4. **Container Won't Start**
   ```bash
   # Check logs
   docker logs personal-portfolio
   
   # Run interactively for debugging
   docker run -it personal-portfolio /bin/bash
   ```

### Performance Optimization

1. **Resource Limits**
   ```bash
   docker run -m 512m --cpus="0.5" -p 5000:5000 personal-portfolio
   ```

2. **JVM Tuning**
   ```bash
   docker run -e JAVA_OPTS="-Xmx256m -Xms128m" -p 5000:5000 personal-portfolio
   ```

## Security Best Practices

1. **Use Non-Root User**: Already configured in Dockerfile
2. **Scan Images**: Regularly scan for vulnerabilities
3. **Update Base Images**: Keep base images updated
4. **Limit Resources**: Set memory and CPU limits
5. **Use Secrets**: Store sensitive data in Docker secrets

## Backup and Recovery

### Backup Container Data
```bash
# Export container
docker export personal-portfolio > portfolio-backup.tar

# Import container
docker import portfolio-backup.tar personal-portfolio:backup
```

### Backup Application Data
```bash
# Copy files from container
docker cp personal-portfolio:/app/logs ./backup/logs
```

## Support

For Docker-related issues:
- Check container logs: `docker logs personal-portfolio`
- Verify image: `docker images personal-portfolio`
- Test locally: `docker run -it personal-portfolio /bin/bash`
