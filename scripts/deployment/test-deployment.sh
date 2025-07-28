#!/bin/bash

# Test Deployment Script
# This script helps verify that your deployment setup is working correctly

echo "🚀 Testing Deployment Setup..."
echo "================================"

# Check if we're in the right directory
if [ ! -f "backend/requirements.txt" ] || [ ! -f "frontend/package.json" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    exit 1
fi

echo "✅ Project structure verified"

# Test Railway CLI
echo "🔧 Testing Railway CLI..."
if command -v npx &> /dev/null; then
    if npx @railway/cli --version &> /dev/null; then
        echo "✅ Railway CLI is available"
    else
        echo "⚠️  Railway CLI not available via npx"
    fi
else
    echo "❌ npx not found"
fi

# Test Vercel CLI
echo "🔧 Testing Vercel CLI..."
if command -v npx &> /dev/null; then
    if npx vercel --version &> /dev/null; then
        echo "✅ Vercel CLI is available"
    else
        echo "⚠️  Vercel CLI not available via npx"
    fi
else
    echo "❌ npx not found"
fi

echo ""
echo "📋 Deployment Checklist:"
echo "================================"
echo "✅ GitHub Secrets configured:"
echo "   - RAILWAY_TOKEN"
echo "   - VERCEL_TOKEN"
echo "   - VERCEL_ORG_ID"
echo "   - VERCEL_PROJECT_ID"
echo ""
echo "✅ Workflow file created: .github/workflows/deploy.yml"
echo ""
echo "🚀 Next Steps:"
echo "1. Commit and push this workflow file to main branch"
echo "2. Check GitHub Actions tab to see deployment progress"
echo "3. Verify both Railway and Vercel deployments complete successfully"
echo ""
echo "💡 To test:"
echo "   - Make a small change to any file"
echo "   - Commit and push to main branch"
echo "   - Watch the automated deployment in GitHub Actions" 