#!/bin/bash
# Verificar configuración local de CryptoStream

echo "════════════════════════════════════════════════════════════════"
echo "🔍 VERIFICADOR DE CONFIGURACIÓN CRYPTOSTREAM"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Contador de checks
passed=0
failed=0

echo "📋 VERIFICANDO ESTRUCTURA..."
echo ""

# Check 1: functions/api.js
if [ -f "functions/api.js" ]; then
    echo -e "${GREEN}✓${NC} functions/api.js existe"
    ((passed++))
else
    echo -e "${RED}✗${NC} functions/api.js NO existe"
    ((failed++))
fi

# Check 2: netlify.toml
if [ -f "netlify.toml" ]; then
    echo -e "${GREEN}✓${NC} netlify.toml existe"
    ((passed++))
else
    echo -e "${RED}✗${NC} netlify.toml NO existe"
    ((failed++))
fi

# Check 3: backend/package.json
if [ -f "backend/package.json" ]; then
    echo -e "${GREEN}✓${NC} backend/package.json existe"
    ((passed++))
else
    echo -e "${RED}✗${NC} backend/package.json NO existe"
    ((failed++))
fi

# Check 4: backend/index.js
if [ -f "backend/index.js" ]; then
    echo -e "${GREEN}✓${NC} backend/index.js existe"
    ((passed++))
else
    echo -e "${RED}✗${NC} backend/index.js NO existe"
    ((failed++))
fi

# Check 5: frontend/public/index.html
if [ -f "frontend/public/index.html" ]; then
    echo -e "${GREEN}✓${NC} frontend/public/index.html existe"
    ((passed++))
else
    echo -e "${RED}✗${NC} frontend/public/index.html NO existe"
    ((failed++))
fi

# Check 6: .env existe
if [ -f ".env" ]; then
    echo -e "${GREEN}✓${NC} .env existe (local)"
    ((passed++))
else
    echo -e "${YELLOW}⚠${NC} .env NO existe (local, pero es normal)"
fi

echo ""
echo "📦 VERIFICANDO DEPENDENCIAS..."
echo ""

# Check 7: serverless-http en package.json
if grep -q "serverless-http" backend/package.json; then
    echo -e "${GREEN}✓${NC} serverless-http está en package.json"
    ((passed++))
else
    echo -e "${RED}✗${NC} serverless-http NO está en package.json"
    ((failed++))
fi

# Check 8: dotenv en package.json
if grep -q "dotenv" backend/package.json; then
    echo -e "${GREEN}✓${NC} dotenv está en package.json"
    ((passed++))
else
    echo -e "${RED}✗${NC} dotenv NO está en package.json"
    ((failed++))
fi

echo ""
echo "🔐 VERIFICANDO CONFIGURACIÓN..."
echo ""

# Check 9: API key redirección en netlify.toml
if grep -q "/api/\*" netlify.toml; then
    echo -e "${GREEN}✓${NC} Redirección /api/* está en netlify.toml"
    ((passed++))
else
    echo -e "${RED}✗${NC} Redirección /api/* NO está en netlify.toml"
    ((failed++))
fi

# Check 10: SPA routing en netlify.toml
if grep -q 'from = "/\*"' netlify.toml; then
    echo -e "${GREEN}✓${NC} SPA routing /* está en netlify.toml"
    ((passed++))
else
    echo -e "${RED}✗${NC} SPA routing /* NO está en netlify.toml"
    ((failed++))
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "📊 RESULTADOS"
echo "════════════════════════════════════════════════════════════════"
echo -e "${GREEN}✓ Pasadas: $passed${NC}"
echo -e "${RED}✗ Fallidas: $failed${NC}"
echo ""

if [ $failed -eq 0 ]; then
    echo -e "${GREEN}✅ TODO ESTÁ CONFIGURADO CORRECTAMENTE${NC}"
    echo ""
    echo "🚀 Próximos pasos:"
    echo "1. Asegúrate de haber pusheado todo a GitHub (rama Blanca)"
    echo "2. Ve a Netlify Dashboard"
    echo "3. Agrega las 5 variables de entorno"
    echo "4. Haz redeploy"
else
    echo -e "${RED}❌ HAY PROBLEMAS QUE SOLUCIONAR${NC}"
    echo ""
    echo "Revisa los errores arriba y soluciónalos."
fi

echo ""
echo "════════════════════════════════════════════════════════════════"
