# 🚀 Automated Deployment Setup

This document explains how the automated deployment system works for the Restaurant Graph Agent.

## 📋 Overview

The project uses GitHub Actions to automatically deploy:
- **Backend** → Railway (Python/FastAPI)
- **Frontend** → Vercel (Next.js/React)

## 🔧 Setup Requirements

### GitHub Secrets Required

Add these secrets in your GitHub repository (Settings → Secrets and variables → Actions):

| Secret Name | Description | How to Get |
|-------------|-------------|------------|
| `RAILWAY_TOKEN` | Railway authentication token | Run `cat ~/.railway/config.json` and copy the `token` value |
| `VERCEL_TOKEN` | Vercel authentication token | Vercel Dashboard → Settings → Tokens |
| `VERCEL_ORG_ID` | Vercel organization ID | Vercel Dashboard → Settings → General → Team ID |
| `VERCEL_PROJECT_ID` | Vercel project ID | Vercel Dashboard → Project Settings → General → Project ID |

### Workflow File

The automated deployment is configured in `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Railway and Vercel

on:
  push:
    branches: [main]

jobs:
  deploy-backend:
    runs-on: ubuntu-latest
    name: Deploy Backend to Railway
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Deploy to Railway
        run: |
          npm install -g @railway/cli
          cd backend
          railway up --service restaurant-ai-4
        env:
          RAILWAY_TOKEN: ${{ secrets.RAILWAY_TOKEN }}

  deploy-frontend:
    runs-on: ubuntu-latest
    name: Deploy Frontend to Vercel
    steps:
      - name: Checkout code
        uses: actions/checkout@v4
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '18'
      - name: Deploy to Vercel
        run: |
          npm install -g vercel
          cd frontend
          vercel --prod --token ${{ secrets.VERCEL_TOKEN }}
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
          VERCEL_ORG_ID: ${{ secrets.VERCEL_ORG_ID }}
          VERCEL_PROJECT_ID: ${{ secrets.VERCEL_PROJECT_ID }}
```

## 🚀 How It Works

1. **Trigger**: Push to `main` branch
2. **Backend Job**: 
   - Installs Railway CLI
   - Deploys backend code to Railway
   - Uses `restaurant-ai-4` service
3. **Frontend Job**:
   - Installs Vercel CLI
   - Deploys frontend code to Vercel
   - Uses production deployment

## 📊 Monitoring

### GitHub Actions
- Go to your repository → Actions tab
- View deployment progress and logs
- Check for any errors or failures

### Railway Dashboard
- Monitor backend deployments
- View logs and performance
- Check service status

### Vercel Dashboard
- Monitor frontend deployments
- View build logs
- Check deployment status

## 🔍 Troubleshooting

### Common Issues

1. **Railway Token Invalid**
   - Regenerate token: `npx @railway/cli logout && npx @railway/cli login`
   - Update GitHub secret with new token

2. **Vercel Token Invalid**
   - Generate new token in Vercel dashboard
   - Update GitHub secret

3. **Deployment Fails**
   - Check GitHub Actions logs
   - Verify all secrets are set correctly
   - Ensure code changes are valid

### Testing Deployment

Run the test script to verify setup:
```bash
./scripts/deployment/test-deployment.sh
```

## 🎯 Best Practices

1. **Always test locally** before pushing to main
2. **Review GitHub Actions logs** after each deployment
3. **Monitor both services** for any issues
4. **Keep secrets secure** and rotate them regularly
5. **Use meaningful commit messages** for easier tracking

## 📈 Performance

- **Backend deployment**: ~2-3 minutes
- **Frontend deployment**: ~1-2 minutes
- **Total deployment time**: ~3-5 minutes

## 🔄 Rollback

If a deployment fails or causes issues:

1. **Railway**: Use Railway dashboard to rollback to previous version
2. **Vercel**: Use Vercel dashboard to rollback to previous deployment
3. **GitHub**: Revert the commit and push again

## 📞 Support

For issues with:
- **GitHub Actions**: Check GitHub documentation
- **Railway**: Check Railway documentation
- **Vercel**: Check Vercel documentation
- **Project-specific**: Check project README 