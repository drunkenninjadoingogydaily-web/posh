#!/bin/bash
# ═══════════════════════════════════════════════════════
#  POSH — Netlify Build Script
#  Injects Firebase config from environment variables
#  into index.html before deployment
# ═══════════════════════════════════════════════════════

echo "🔧 POSH Build: Injecting Firebase config..."

# Check required environment variables
required=(
  "FIREBASE_API_KEY"
  "FIREBASE_AUTH_DOMAIN"
  "FIREBASE_PROJECT_ID"
  "FIREBASE_STORAGE_BUCKET"
  "FIREBASE_MESSAGING_SENDER_ID"
  "FIREBASE_APP_ID"
)

for var in "${required[@]}"; do
  if [ -z "${!var}" ]; then
    echo "❌ ERROR: Missing environment variable: $var"
    echo "   Set it in Netlify: Site Settings → Environment Variables"
    exit 1
  fi
done

# Inject values into index.html
sed -i "s|__FIREBASE_API_KEY__|${FIREBASE_API_KEY}|g" index.html
sed -i "s|__FIREBASE_AUTH_DOMAIN__|${FIREBASE_AUTH_DOMAIN}|g" index.html
sed -i "s|__FIREBASE_PROJECT_ID__|${FIREBASE_PROJECT_ID}|g" index.html
sed -i "s|__FIREBASE_STORAGE_BUCKET__|${FIREBASE_STORAGE_BUCKET}|g" index.html
sed -i "s|__FIREBASE_MESSAGING_SENDER_ID__|${FIREBASE_MESSAGING_SENDER_ID}|g" index.html
sed -i "s|__FIREBASE_APP_ID__|${FIREBASE_APP_ID}|g" index.html

echo "✅ Firebase config injected successfully!"
echo "🚀 POSH is ready to deploy!"
