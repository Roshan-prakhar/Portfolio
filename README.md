# Personal Portfolio

A Spring Boot web application showcasing personal portfolio with Thymeleaf templates.

## Features

- Responsive design
- Modern UI with CSS animations
- Project showcase
- Contact form
- Experience timeline
- Achievements section

## Technology Stack

- **Backend**: Spring Boot 3.5.0
- **Frontend**: Thymeleaf, HTML5, CSS3, JavaScript
- **Java Version**: 21
- **Build Tool**: Maven

## Local Development

### Prerequisites

- Java 21 or higher
- Maven (or use the included Maven wrapper)

### Running Locally

1. Clone the repository
2. Navigate to the project directory
3. Run the application:
   ```bash
   ./mvnw spring-boot:run
   ```
   Or on Windows:
   ```cmd
   mvnw.cmd spring-boot:run
   ```
4. Open your browser and go to `http://localhost:5000`

### Building the Application

To build the JAR file:

**Linux/Mac:**
```bash
./build.sh
```

**Windows:**
```cmd
build.bat
```

Or manually:
```bash
./mvnw clean package -DskipTests
```

## Deployment Options

This project supports multiple deployment methods:

### 1. Render.com Deployment (Recommended)

#### Option A: Using render.yaml (Automatic)
1. Push your code to a Git repository (GitHub, GitLab, or Bitbucket)
2. Connect your repository to Render
3. Render will automatically detect the `render.yaml` file and deploy your application

#### Option B: Manual Configuration
1. Create a new Web Service on Render
2. Connect your Git repository
3. Use these settings:
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -jar target/portfolio.jar`
   - **Environment**: Java
   - **Plan**: Free

### 2. Docker Deployment

#### Quick Start with Docker
```bash
# Build the image
docker build -t personal-portfolio .

# Run the container
docker run -p 5000:5000 personal-portfolio
```

#### Using Docker Compose (Recommended)
```bash
# Start the application
docker-compose up -d

# View logs
docker-compose logs -f

# Stop the application
docker-compose down
```

#### Using Build Scripts
**Linux/Mac:**
```bash
# Build and run
./docker-build.sh
./docker-run.sh
```

**Windows:**
```cmd
# Build and run
docker-build.bat
docker-run.bat
```

### 3. Traditional Server Deployment

1. Build the JAR file:
   ```bash
   ./mvnw clean package -DskipTests
   ```

2. Run on server:
   ```bash
   java -jar target/portfolio.jar
   ```

### Environment Variables

The application uses the following environment variables:

- `PORT`: Server port (default: 5000)
- `JAVA_OPTS`: JVM options (default: -Xmx512m -Xms256m)

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── in/ROSHAN/personalportfolio/
│   │       ├── PersonalportfolioApplication.java
│   │       └── controller/
│   │           └── HomeController.java
│   └── resources/
│       ├── application.properties
│       ├── static/
│       │   ├── css/
│       │   ├── images/
│       │   └── js/
│       └── templates/
│           ├── home.html
│           └── fragments/
└── test/
```

## Configuration

The application configuration is in `src/main/resources/application.properties`:

- Server port is configurable via `PORT` environment variable
- Default port is 5000
- Logging is configured for production

## Troubleshooting

### Common Issues

1. **Port already in use**: Change the port in `application.properties` or set the `PORT` environment variable
2. **Build failures**: Ensure Java 21 is installed and Maven wrapper has execute permissions
3. **Static resources not loading**: Check that files are in the correct `src/main/resources/static/` directory

### Render Deployment Issues

1. **Build timeout**: The free plan has build time limits. Consider upgrading or optimizing the build
2. **Memory issues**: Adjust `JAVA_OPTS` environment variable
3. **Port binding**: Ensure the application binds to `0.0.0.0` and uses the `PORT` environment variable

## License

This project is open source and available under the [MIT License](LICENSE).
