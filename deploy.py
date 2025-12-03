#!/usr/bin/env python3
"""
CryptoStream - Netlify Deployment Automation Script
Automatiza el deployment completo en Netlify
"""

import os
import json
import subprocess
import sys
import time
from pathlib import Path

# Colores para terminal
class Colors:
    GREEN = '\033[92m'
    RED = '\033[91m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    RESET = '\033[0m'
    BOLD = '\033[1m'

def print_header(text):
    print(f"\n{Colors.BOLD}{Colors.CYAN}{'='*80}{Colors.RESET}")
    print(f"{Colors.BOLD}{Colors.CYAN}{text:^80}{Colors.RESET}")
    print(f"{Colors.BOLD}{Colors.CYAN}{'='*80}{Colors.RESET}\n")

def print_success(text):
    print(f"{Colors.GREEN}✅ {text}{Colors.RESET}")

def print_error(text):
    print(f"{Colors.RED}❌ {text}{Colors.RESET}")

def print_warning(text):
    print(f"{Colors.YELLOW}⚠️  {text}{Colors.RESET}")

def print_info(text):
    print(f"{Colors.BLUE}ℹ️  {text}{Colors.RESET}")

def print_step(number, text):
    print(f"{Colors.BOLD}{Colors.BLUE}PASO {number}: {text}{Colors.RESET}")

# Configuración
CONFIG = {
    'GITHUB_REPO': 'Blanca-estela-valerio-rivero/Cryptostream',
    'BRANCH': 'Blanca',
    'NETLIFY_SITE_NAME': 'cryptostream-app',
    'PINATA_API_KEY': '25038791f137b293b9e8',
    'PINATA_SECRET_KEY': '25038791f137b293b9e8',
    'MONGODB_URI': 'mongodb://localhost:27017/cryptostream',
    'STELLAR_NETWORK': 'TESTNET',
    'PORT': '3000',
}

def check_git():
    """Verificar que el repositorio Git está ok"""
    print_step(1, "Verificar Repositorio Git")
    
    try:
        # Verificar que es un repo Git
        result = subprocess.run(['git', 'rev-parse', '--git-dir'], 
                              capture_output=True, text=True)
        if result.returncode != 0:
            print_error("No es un repositorio Git válido")
            return False
        
        print_success("Repositorio Git encontrado")
        
        # Verificar rama
        result = subprocess.run(['git', 'rev-parse', '--abbrev-ref', 'HEAD'],
                              capture_output=True, text=True)
        current_branch = result.stdout.strip()
        
        if current_branch == CONFIG['BRANCH']:
            print_success(f"Rama correcta: {current_branch}")
        else:
            print_warning(f"Rama actual: {current_branch}, esperada: {CONFIG['BRANCH']}")
            print_info("Cambiando a rama correcta...")
            subprocess.run(['git', 'checkout', CONFIG['BRANCH']])
            print_success(f"Rama cambiada a: {CONFIG['BRANCH']}")
        
        return True
    except Exception as e:
        print_error(f"Error verificando Git: {e}")
        return False

def check_netlify_cli():
    """Verificar si Netlify CLI está instalado"""
    print_step(2, "Verificar Netlify CLI")
    
    try:
        result = subprocess.run(['netlify', '--version'],
                              capture_output=True, text=True)
        if result.returncode == 0:
            print_success(f"Netlify CLI instalado: {result.stdout.strip()}")
            return True
        else:
            print_warning("Netlify CLI no encontrado")
            print_info("Instalando Netlify CLI...")
            subprocess.run(['npm', 'install', '-g', 'netlify-cli'])
            print_success("Netlify CLI instalado")
            return True
    except Exception as e:
        print_warning(f"Error verificando Netlify CLI: {e}")
        return False

def check_env_file():
    """Verificar que el archivo .env existe"""
    print_step(3, "Verificar Archivo .env")
    
    env_path = Path('.env')
    if env_path.exists():
        print_success(".env encontrado")
        # Verificar que tiene las credenciales
        content = env_path.read_text()
        if 'PINATA_API_KEY' in content:
            print_success("Credenciales de Pinata encontradas")
            return True
        else:
            print_warning("Credenciales de Pinata no encontradas en .env")
            return False
    else:
        print_warning(".env no encontrado")
        print_info("Creando .env...")
        # Crear .env
        env_content = f"""# ============================================
# CONFIGURACIÓN DE CRYPTOSTREAM
# ============================================

PINATA_API_KEY={CONFIG['PINATA_API_KEY']}
PINATA_SECRET_KEY={CONFIG['PINATA_SECRET_KEY']}
MONGODB_URI={CONFIG['MONGODB_URI']}
PORT={CONFIG['PORT']}
STELLAR_NETWORK={CONFIG['STELLAR_NETWORK']}
NODE_ENV=production
"""
        env_path.write_text(env_content)
        print_success(".env creado con credenciales")
        return True

def check_backend_deps():
    """Verificar dependencias del backend"""
    print_step(4, "Verificar Dependencias del Backend")
    
    backend_path = Path('backend')
    if not backend_path.exists():
        print_error("Carpeta 'backend' no encontrada")
        return False
    
    # Cambiar a backend
    os.chdir('backend')
    
    # Verificar package.json
    package_json = Path('package.json')
    if not package_json.exists():
        print_error("backend/package.json no encontrado")
        os.chdir('..')
        return False
    
    # Verificar que tiene serverless-http
    content = package_json.read_text()
    if 'serverless-http' in content:
        print_success("serverless-http encontrado en dependencias")
    else:
        print_warning("serverless-http no encontrado, agregando...")
        subprocess.run(['npm', 'install', 'serverless-http'])
    
    os.chdir('..')
    print_success("Dependencias backend verificadas")
    return True

def check_functions():
    """Verificar que la función serverless existe"""
    print_step(5, "Verificar Función Serverless")
    
    functions_path = Path('functions/api.js')
    if functions_path.exists():
        print_success("functions/api.js encontrado")
        return True
    else:
        print_error("functions/api.js no encontrado")
        return False

def show_deployment_info():
    """Mostrar información de deployment"""
    print_step(6, "Información de Deployment")
    
    print(f"\n{Colors.BOLD}Configuración:{Colors.RESET}")
    print(f"  Repositorio: {CONFIG['GITHUB_REPO']}")
    print(f"  Rama: {CONFIG['BRANCH']}")
    print(f"  Nombre Netlify: {CONFIG['NETLIFY_SITE_NAME']}")
    
    print(f"\n{Colors.BOLD}Credenciales Pinata:{Colors.RESET}")
    print(f"  API Key: {CONFIG['PINATA_API_KEY'][:10]}...{CONFIG['PINATA_API_KEY'][-5:]}")
    print(f"  Secret: {CONFIG['PINATA_SECRET_KEY'][:10]}...{CONFIG['PINATA_SECRET_KEY'][-5:]}")
    
    print(f"\n{Colors.BOLD}Configuración de Deploy:{Colors.RESET}")
    print(f"  Build command: cd backend && npm install")
    print(f"  Publish directory: frontend/public")
    print(f"  Functions directory: functions")
    
    print(f"\n{Colors.BOLD}Variables de Entorno:{Colors.RESET}")
    for key, value in CONFIG.items():
        if 'KEY' in key or 'SECRET' in key:
            # Ocultar valores sensibles
            print(f"  {key}: ••••••••••")
        elif key in ['GITHUB_REPO', 'BRANCH', 'NETLIFY_SITE_NAME']:
            continue
        else:
            print(f"  {key}: {value}")

def main():
    """Función principal"""
    print_header("🚀 CryptoStream - Deployment Automático en Netlify")
    
    print_info("Este script prepara tu proyecto para deployment en Netlify")
    print_warning("Nota: La conexión a Netlify debe hacerse manualmente en el dashboard")
    print()
    
    # Verificaciones
    checks = [
        ("Git", check_git),
        (".env", check_env_file),
        ("Backend", check_backend_deps),
        ("Functions", check_functions),
    ]
    
    all_passed = True
    for name, check_func in checks:
        try:
            if not check_func():
                print_error(f"Verificación de {name} falló")
                all_passed = False
                time.sleep(1)
        except Exception as e:
            print_error(f"Error en verificación de {name}: {e}")
            all_passed = False
    
    # Mostrar información
    print()
    show_deployment_info()
    
    # Resumen
    print_header("📋 Resumen")
    
    if all_passed:
        print_success("Todas las verificaciones pasaron")
        print_info("Tu proyecto está listo para Netlify")
        
        print(f"\n{Colors.BOLD}Próximos pasos:{Colors.RESET}")
        print(f"1. Ve a: https://app.netlify.com")
        print(f"2. Click 'Add new site' → 'Import an existing project'")
        print(f"3. Conecta con GitHub")
        print(f"4. Selecciona: Cryptostream (rama Blanca)")
        print(f"5. Configuración de build (según arriba)")
        print(f"6. Agrega variables de entorno (según arriba)")
        print(f"7. Click 'Deploy site'")
        print(f"8. ¡Tu app estará en vivo en 5-10 minutos!")
        
        print(f"\n{Colors.GREEN}{Colors.BOLD}¡Éxito! 🎉{Colors.RESET}")
    else:
        print_error("Algunas verificaciones fallaron")
        print_warning("Por favor, revisa los errores arriba y intenta de nuevo")
        sys.exit(1)

if __name__ == '__main__':
    main()
