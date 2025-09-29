#!/usr/bin/env python3
"""
Dockerfile validation script
Checks for common issues in Dockerfile without requiring Docker
"""

import re
import sys
import os

def validate_dockerfile(filepath):
    """Validate Dockerfile for common issues"""
    issues = []
    
    if not os.path.exists(filepath):
        return [f"❌ Dockerfile not found: {filepath}"]
    
    with open(filepath, 'r') as f:
        content = f.read()
        lines = content.split('\n')
    
    # Check for problematic base images
    problematic_images = [
        'openjdk:21-jre-slim',
        'openjdk:21-jre',
        'openjdk:21-jre-alpine'
    ]
    
    for i, line in enumerate(lines, 1):
        if line.strip().startswith('FROM '):
            for img in problematic_images:
                if img in line:
                    issues.append(f"❌ Line {i}: Problematic base image '{img}' - may not exist")
    
    # Check for proper multi-stage build
    from_lines = [line for line in lines if line.strip().startswith('FROM ')]
    if len(from_lines) < 2:
        issues.append("⚠️  Single-stage build detected - consider multi-stage for optimization")
    
    # Check for security best practices
    if 'USER root' in content:
        issues.append("⚠️  Running as root user - security risk")
    
    if 'RUN apt-get update' in content and 'RUN apt-get clean' not in content:
        issues.append("⚠️  Missing apt-get clean - may increase image size")
    
    # Check for health checks
    if 'HEALTHCHECK' not in content:
        issues.append("ℹ️  No health check defined - consider adding one")
    
    # Check for proper port exposure
    if 'EXPOSE' not in content:
        issues.append("ℹ️  No EXPOSE directive - consider adding port exposure")
    
    return issues

def main():
    """Main validation function"""
    print("🔍 Validating Dockerfile...")
    
    # Check main Dockerfile
    main_issues = validate_dockerfile('Dockerfile')
    
    if main_issues:
        print("\n📋 Main Dockerfile Issues:")
        for issue in main_issues:
            print(f"  {issue}")
    else:
        print("✅ Main Dockerfile looks good!")
    
    # Check alternative Dockerfile
    alt_issues = validate_dockerfile('Dockerfile.alternative')
    
    if alt_issues:
        print("\n📋 Alternative Dockerfile Issues:")
        for issue in alt_issues:
            print(f"  {issue}")
    else:
        print("✅ Alternative Dockerfile looks good!")
    
    # Overall assessment
    total_issues = len(main_issues) + len(alt_issues)
    critical_issues = len([i for i in main_issues + alt_issues if i.startswith('❌')])
    
    print(f"\n📊 Summary:")
    print(f"  Total issues: {total_issues}")
    print(f"  Critical issues: {critical_issues}")
    
    if critical_issues == 0:
        print("🎉 Dockerfiles are ready for deployment!")
        return 0
    else:
        print("⚠️  Please fix critical issues before deployment")
        return 1

if __name__ == "__main__":
    sys.exit(main())

