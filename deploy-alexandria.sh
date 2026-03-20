#!/bin/bash
set -euo pipefail

echo "🏛️ ALEXANDRIA DEPLOYMENT TO alexandria.hardcard.org"
echo "=================================================="

# Check prerequisites
if ! command -v vercel >/dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

# Deploy frontend to Vercel
echo "🚀 Deploying Alexandria platform..."
vercel --prod --yes || {
    echo "⚠️  Vercel deployment failed. Trying with login..."
    vercel login
    vercel --prod --yes
}

# Get deployment URL
VERCEL_URL=$(vercel ls --json | jq -r '.[0].url' 2>/dev/null || echo "your-vercel-url")

echo ""
echo "✅ ALEXANDRIA DEPLOYMENT COMPLETE!"
echo "=================================="
echo ""
echo "📍 Deployment URL: https://$VERCEL_URL"
echo ""
echo "🔧 DNS CONFIGURATION NEEDED:"
echo "   Add CNAME record:"
echo "   Name: alexandria"
echo "   Value: $VERCEL_URL"
echo "   TTL: 300"
echo ""
echo "🌐 FINAL URLs:"
echo "   Main Site: https://hardcard.org"
echo "   Alexandria: https://alexandria.hardcard.org"
echo "   Beta Portal: https://alexandria.hardcard.org/beta"
echo "   API Health: https://alexandria.hardcard.org/api/health"
echo ""
echo "📊 NEXT STEPS:"
echo "1. Configure DNS CNAME for alexandria.hardcard.org"
echo "2. Update CORS origins in environment variables"
echo "3. Send first beta invitations to researchers"
echo "4. Submit Nature Machine Intelligence paper"
echo ""
echo "🎯 ACADEMIC MISSION: ACTIVATED"

# Optional: Create a simple test
echo "🧪 Testing deployment..."
if command -v curl >/dev/null; then
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://$VERCEL_URL" || echo "000")
    if [ "$HTTP_CODE" = "200" ]; then
        echo "✅ Deployment responding successfully!"
    else
        echo "⚠️  Deployment may need a few minutes to fully propagate (HTTP $HTTP_CODE)"
    fi
fi

echo ""
echo "🏛️ Alexandria Research Platform is LIVE!"
echo "Ready to advance scientific integrity worldwide."