# Script de Verificacion Pre-Deployment
# Ejecuta este script antes de desplegar en Vercel

Write-Host ""
Write-Host "VERIFICACION PRE-DEPLOYMENT EN VERCEL" -ForegroundColor Cyan
Write-Host ""

# Verificar archivos necesarios
Write-Host "Verificando archivos necesarios..." -ForegroundColor Yellow

$files = @(
    "vercel.json",
    "package.json",
    ".vercelignore",
    "api/index.js",
    "api/videos.js",
    "api/upload.js",
    "api/health.js",
    "backend/index.js",
    "frontend/public/index.html"
)

$allFilesExist = $true
foreach ($file in $files) {
    if (Test-Path $file) {
        Write-Host "  OK: $file" -ForegroundColor Green
    } else {
        Write-Host "  FALTA: $file" -ForegroundColor Red
        $allFilesExist = $false
    }
}

Write-Host ""

# Verificar .env
Write-Host "Verificando variables de entorno..." -ForegroundColor Yellow

if (Test-Path ".env") {
    $envContent = Get-Content ".env" -Raw
    
    $requiredVars = @("MONGODB_URI", "PINATA_API_KEY", "PINATA_SECRET_KEY")
    foreach ($var in $requiredVars) {
        if ($envContent -match $var) {
            Write-Host "  OK: $var encontrado" -ForegroundColor Green
        } else {
            Write-Host "  ADVERTENCIA: $var NO encontrado en .env" -ForegroundColor Yellow
        }
    }
} else {
    Write-Host "  ADVERTENCIA: Archivo .env no encontrado" -ForegroundColor Yellow
    Write-Host "  Asegurate de configurar las variables en Vercel" -ForegroundColor Yellow
}

Write-Host ""

# Verificar node_modules
Write-Host "Verificando dependencias..." -ForegroundColor Yellow

if (Test-Path "backend/node_modules") {
    Write-Host "  OK: Dependencias del backend instaladas" -ForegroundColor Green
} else {
    Write-Host "  INFO: Dependencias se instalaran en Vercel" -ForegroundColor Yellow
}

Write-Host ""

# Verificar Git
Write-Host "Verificando Git..." -ForegroundColor Yellow

if (Test-Path ".git") {
    $gitStatus = git status --short
    if ($gitStatus) {
        Write-Host "  ADVERTENCIA: Hay cambios sin commit" -ForegroundColor Yellow
        Write-Host "  Ejecuta: git add . && git commit -m 'Deploy' && git push" -ForegroundColor Cyan
    } else {
        Write-Host "  OK: Todos los cambios estan committed" -ForegroundColor Green
    }
} else {
    Write-Host "  ERROR: No es un repositorio Git" -ForegroundColor Red
}

Write-Host ""

# Resumen
Write-Host "RESUMEN" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

if ($allFilesExist) {
    Write-Host "OK: Todos los archivos necesarios presentes" -ForegroundColor Green
    Write-Host "OK: Configuracion de Vercel lista" -ForegroundColor Green
    Write-Host ""
    Write-Host "SIGUIENTE PASO:" -ForegroundColor Green
    Write-Host "  1. Sube tus cambios a GitHub" -ForegroundColor White
    Write-Host "  2. Ve a https://vercel.com/new" -ForegroundColor White
    Write-Host "  3. Importa tu repositorio" -ForegroundColor White
    Write-Host "  4. Configura las variables de entorno" -ForegroundColor White
    Write-Host "  5. Haz clic en Deploy" -ForegroundColor White
    Write-Host ""
    Write-Host "Documentacion completa: VERCEL_DEPLOY.md" -ForegroundColor Cyan
} else {
    Write-Host "ERROR: Faltan archivos necesarios" -ForegroundColor Red
}

Write-Host ""
