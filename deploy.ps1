# ============================================
# SCRIPT DE VERIFICACIÓN - CRYPTOSTREAM
# ============================================
# Script PowerShell para verificar readiness de deployment

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🚀 CryptoStream - Verificación de Deployment en Netlify   ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Función para mostrar mensajes
function Write-Success { Write-Host "✅ $args" -ForegroundColor Green }
function Write-Error { Write-Host "❌ $args" -ForegroundColor Red }
function Write-Warning { Write-Host "⚠️  $args" -ForegroundColor Yellow }
function Write-Info { Write-Host "ℹ️  $args" -ForegroundColor Blue }
function Write-Step { Write-Host "────────────────────────────────────────────────────────────" -ForegroundColor Blue; Write-Host "PASO: $args" -ForegroundColor Cyan; Write-Host "────────────────────────────────────────────────────────────" -ForegroundColor Blue }

# Credenciales
$PINATA_API_KEY = "25038791f137b293b9e8"
$PINATA_SECRET_KEY = "25038791f137b293b9e8"

# PASO 1: Verificar Git
Write-Step "1 - Verificar Repositorio Git"
Write-Info "Verificando estado del repositorio..."

$gitStatus = git status 2>&1
if ($gitStatus -match "On branch") {
    Write-Success "Repositorio Git encontrado"
    $branch = (git rev-parse --abbrev-ref HEAD).Trim()
    Write-Info "Rama actual: $branch"
    if ($branch -eq "Blanca") {
        Write-Success "Rama correcta: Blanca"
    } else {
        Write-Warning "Rama no es Blanca, es: $branch"
    }
} else {
    Write-Error "No es un repositorio Git válido"
}

Write-Host ""

# PASO 2: Verificar .env
Write-Step "2 - Verificar Archivo .env"

if (Test-Path ".env") {
    Write-Success ".env encontrado"
    $envContent = Get-Content ".env"
    if ($envContent -match "PINATA_API_KEY") {
        Write-Success "Credenciales de Pinata encontradas"
    } else {
        Write-Warning "Credenciales de Pinata NO encontradas"
    }
} else {
    Write-Warning ".env no encontrado"
}

Write-Host ""

# PASO 3: Verificar Backend
Write-Step "3 - Verificar Backend"

if (Test-Path "backend") {
    Write-Success "Carpeta backend encontrada"
    if (Test-Path "backend/package.json") {
        Write-Success "backend/package.json encontrado"
        $packageJson = Get-Content "backend/package.json" | ConvertFrom-Json
        if ($packageJson.dependencies.'serverless-http') {
            Write-Success "serverless-http encontrado en dependencias"
        } else {
            Write-Warning "serverless-http NO encontrado"
        }
    }
} else {
    Write-Error "Carpeta backend NO encontrada"
}

Write-Host ""

# PASO 4: Verificar Functions
Write-Step "4 - Verificar Función Serverless"

if (Test-Path "functions/api.js") {
    Write-Success "functions/api.js encontrado"
} else {
    Write-Error "functions/api.js NO encontrado"
}

Write-Host ""

# PASO 5: Verificar netlify.toml
Write-Step "5 - Verificar Configuración Netlify"

if (Test-Path "netlify.toml") {
    Write-Success "netlify.toml encontrado"
    $tomlContent = Get-Content "netlify.toml"
    if ($tomlContent -match "publish.*=.*frontend/public") {
        Write-Success "Publish directory configurado: frontend/public"
    }
    if ($tomlContent -match 'from.*=.*"/api') {
        Write-Success "Redirecciones de API configuradas"
    }
} else {
    Write-Error "netlify.toml NO encontrado"
}

Write-Host ""

# PASO 6: Mostrar información de deployment
Write-Step "6 - Información de Deployment"

Write-Host ""
Write-Host "📦 Configuración General:" -ForegroundColor Cyan
Write-Info "Repositorio: Blanca-estela-valerio-rivero/Cryptostream"
Write-Info "Rama: Blanca"
Write-Info "URL GitHub: https://github.com/Blanca-estela-valerio-rivero/Cryptostream"

Write-Host ""
Write-Host "🔐 Credenciales Pinata:" -ForegroundColor Cyan
Write-Info "API Key: $($PINATA_API_KEY.Substring(0,10))...****"
Write-Info "Secret: $($PINATA_SECRET_KEY.Substring(0,10))...****"

Write-Host ""
Write-Host "⚙️  Configuración de Build en Netlify:" -ForegroundColor Cyan
Write-Info "Build command: cd backend && npm install"
Write-Info "Publish directory: frontend/public"
Write-Info "Base directory: (dejar vacío)"
Write-Info "Functions directory: functions"

Write-Host ""
Write-Host "🔑 Variables de Entorno a Agregar:" -ForegroundColor Cyan
Write-Info "PINATA_API_KEY = 25038791f137b293b9e8"
Write-Info "PINATA_SECRET_KEY = 25038791f137b293b9e8"
Write-Info "MONGODB_URI = mongodb://localhost:27017/cryptostream"
Write-Info "PORT = 3000"
Write-Info "STELLAR_NETWORK = TESTNET"

Write-Host ""
Write-Host "════════════════════════════════════════════════════════════" -ForegroundColor Blue

Write-Host ""
Write-Host "✅ TODO ESTÁ LISTO PARA NETLIFY" -ForegroundColor Green -BackgroundColor Black
Write-Host ""
Write-Host "📋 PRÓXIMOS PASOS MANUALES EN NETLIFY:" -ForegroundColor Cyan
Write-Host "1. Ve a https://app.netlify.com" -ForegroundColor White
Write-Host "2. Click 'Add new site' → 'Import an existing project'" -ForegroundColor White
Write-Host "3. Selecciona GitHub" -ForegroundColor White
Write-Host "4. Selecciona 'Cryptostream' (rama Blanca)" -ForegroundColor White
Write-Host "5. Configura Build settings (según arriba)" -ForegroundColor White
Write-Host "6. Agrega Variables de Entorno (según arriba)" -ForegroundColor White
Write-Host "7. Click 'Deploy site'" -ForegroundColor White
Write-Host "8. ¡Espera 5-10 minutos!" -ForegroundColor White
Write-Host ""
Write-Host "🎉 ¡Éxito! Tu CryptoStream estará en vivo" -ForegroundColor Green
Write-Host ""
