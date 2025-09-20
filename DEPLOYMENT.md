# Deployment Guide for Personal Portfolio

## Quick Start - Deploy to Render

### Step 1: Prepare Your Repository
1. Initialize Git repository (if not already done):
   ```bash
   git init
   git add .
   git commit -m "Initial commit with deployment files"
   ```

2. Push to GitHub/GitLab/Bitbucket:
   ```bash
   git remote add origin <your-repository-url>
   git push -u origin main
   ```

### Step 2: Deploy on Render

#### Option A: Automatic Deployment (Recommended)
1. Go to [render.com](https://render.com) and sign up/login
2. Click "New +" → "Web Service"
3. Connect your Git repository
4. Render will automatically detect the `render.yaml` file
5. Click "Create Web Service"
6. Wait for deployment to complete

#### Option B: Manual Configuration
1. Go to [render.com](https://render.com) and sign up/login
2. Click "New +" → "Web Service"
3. Connect your Git repository
4. Configure manually:
   - **Name**: personal-portfolio
   - **Environment**: Java
   - **Build Command**: `./mvnw clean package -DskipTests`
   - **Start Command**: `java -jar target/portfolio.jar`
   - **Plan**: Free
5. Click "Create Web Service"

### Step 3: Environment Variables (Optional)
If you need to customize the deployment, add these environment variables in Render dashboard:
- `PORT`: Server port (default: 5000)
- `JAVA_OPTS`: JVM options (default: -Xmx512m -Xms256m)

## Files Created for Deployment

The following files have been created to enable deployment:

### Core Deployment Files
- `render.yaml` - Render configuration for automatic deployment
- `Dockerfile` - Docker container configuration
- `Procfile` - Heroku-style process file
- `.dockerignore` - Docker ignore file

### Build Scripts
- `build.sh` - Linux/Mac build script
- `build.bat` - Windows build script

### Configuration
- Updated `application.properties` - Production-ready configuration
- `.gitignore` - Git ignore file for clean repository

### Documentation
- `README.md` - Complete project documentation
- `DEPLOYMENT.md` - This deployment guide

## Testing Your Deployment

### Local Testing
1. Build the application:
   ```bash
   # Linux/Mac
   ./build.sh
   
   # Windows
   build.bat
   ```

2. Run the application:
   ```bash
   java -jar target/portfolio.jar
   ```

3. Visit `http://localhost:5000` to test

### Production Testing
1. After deployment, visit your Render URL
2. Test all pages and functionality
3. Check that static resources (CSS, images, JS) load correctly

## Troubleshooting

### Common Issues

1. **Build Fails on Render**
   - Check that Java 21 is available
   - Verify Maven wrapper has execute permissions
   - Check build logs for specific errors

2. **Application Won't Start**
   - Verify the start command is correct
   - Check that the JAR file exists in target/
   - Ensure PORT environment variable is set

3. **Static Resources Not Loading**
   - Verify files are in `src/main/resources/static/`
   - Check that Thymeleaf templates reference resources correctly

4. **Memory Issues**
   - Adjust `JAVA_OPTS` environment variable
   - Consider upgrading to a paid plan

### Render-Specific Issues

1. **Build Timeout**
   - Free plan has limited build time
   - Optimize dependencies in pom.xml
   - Consider upgrading plan

2. **Cold Start Issues**
   - First request may be slow
   - Consider using a paid plan for better performance

## Monitoring and Maintenance

### Health Checks
- Render automatically monitors your application
- Health check endpoint: `/` (root path)
- Check Render dashboard for uptime and logs

### Logs
- View logs in Render dashboard
- Logs include application output and errors
- Use for debugging production issues

### Updates
- Push changes to your Git repository
- Render will automatically redeploy
- Monitor deployment status in dashboard

## Security Considerations

1. **Environment Variables**
   - Never commit sensitive data to Git
   - Use Render's environment variable feature

2. **Dependencies**
   - Keep dependencies updated
   - Review security advisories

3. **HTTPS**
   - Render provides HTTPS by default
   - No additional configuration needed

## Performance Optimization

1. **Static Resources**
   - Images are already optimized
   - CSS and JS are minified in production

2. **Database** (if added later)
   - Consider using Render's managed database services
   - Use connection pooling

3. **Caching**
   - Implement caching for better performance
   - Use Spring Boot's caching features

## Support

- Render Documentation: https://render.com/docs
- Spring Boot Documentation: https://spring.io/projects/spring-boot
- Project Issues: Create an issue in your repository
