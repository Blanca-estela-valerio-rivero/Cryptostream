#!/bin/bash

# ============================================
# SCRIPT DE DEPLOYMENT AUTOMÁTICO - NETLIFY
# ============================================
# Este script automatiza el deployment de CryptoStream en Netlify

echo "🚀 CryptoStream - Deployment Automático en Netlify"
echo "=================================================="

# Variables
REPO_URL="https://github.com/Blanca-estela-valerio-rivero/Cryptostream"
BRANCH="Blanca"
NETLIFY_SITE_NAME="cryptostream-app"

# Credenciales Pinata
PINATA_API_KEY="25038791f137b293b9e8"
PINATA_SECRET_KEY="25038791f137b293b9e8"

# MongoDB
MONGODB_URI="mongodb://localhost:27017/cryptostream"

# Stellar
STELLAR_NETWORK="TESTNET"

echo ""
echo "📋 Configuración:"
echo "   Repositorio: $REPO_URL"
echo "   Rama: $BRANCH"
echo "   Pinata API Key: ${PINATA_API_KEY:0:10}****"
echo ""

# Verificar que Git está disponible
if ! command -v git &> /dev/null; then
    echo "❌ Git no está instalado"
    exit 1
fi

# Verificar estado de Git
echo "🔍 Verificando repositorio..."
if [ -d ".git" ]; then
    echo "   ✅ Repositorio Git encontrado"
    git status
else
    echo "   ❌ No es un repositorio Git"
    exit 1
fi

# Verificar que está en rama Blanca
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
if [ "$CURRENT_BRANCH" != "$BRANCH" ]; then
    echo "   ⚠️  Rama actual: $CURRENT_BRANCH (esperada: $BRANCH)"
    echo "   Cambiando a rama $BRANCH..."
    git checkout $BRANCH
fi

echo ""
echo "✅ El repositorio está listo para Netlify"
echo ""
echo "Próximos pasos:"
echo "1. Ve a https://app.netlify.com"
echo "2. Selecciona 'Add new site' → 'Import an existing project'"
echo "3. Conecta con GitHub"
echo "4. Selecciona el repositorio 'Cryptostream'"
echo "5. Configura:"
echo "   Build command: cd backend && npm install"
echo "   Publish directory: frontend/public"
echo "   Functions directory: functions"
echo "6. Agrega las variables de entorno:"
echo "   PINATA_API_KEY=$PINATA_API_KEY"
echo "   PINATA_SECRET_KEY=$PINATA_SECRET_KEY"
echo "   MONGODB_URI=$MONGODB_URI"
echo "   STELLAR_NETWORK=$STELLAR_NETWORK"
echo "7. Click en 'Deploy site'"
echo ""
echo "🎉 ¡Tu app estará en vivo en 5-10 minutos!"
