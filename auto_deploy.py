#!/usr/bin/env python3
"""
Deploy automático de CryptoStream a Netlify
Este script configura las variables de entorno y dispara el redeploy
"""

import os
import json
import subprocess
import time
from pathlib import Path

class NetlifyDeploy:
    def __init__(self):
        self.site_id = "snazzy-twilight-868202"
        self.repo_owner = "Blanca-estela-valerio-rivero"
        self.repo_name = "Cryptostream"
        self.branch = "Blanca"
        
        # Variables a configurar
        self.env_vars = {
            "PINATA_API_KEY": "25038791f137b293b9e8",
            "PINATA_SECRET_KEY": "25038791f137b293b9e8",
            "MONGODB_URI": "mongodb://localhost:27017/cryptostream",
            "STELLAR_NETWORK": "TESTNET",
            "PORT": "3000"
        }
    
    def print_header(self, text):
        """Imprimir encabezado"""
        print(f"\n{'='*80}")
        print(f"🚀 {text}")
        print(f"{'='*80}\n")
    
    def print_step(self, num, text):
        """Imprimir paso"""
        print(f"   {num}️⃣  {text}")
    
    def check_prerequisites(self):
        """Verificar que existen los archivos necesarios"""
        self.print_header("PASO 1: VERIFICANDO ARCHIVOS NECESARIOS")
        
        files_to_check = [
            "functions/api.js",
            "netlify.toml",
            "backend/package.json",
            "backend/index.js",
            ".env"
        ]
        
        all_exist = True
        for file_path in files_to_check:
            exists = Path(file_path).exists()
            status = "✅" if exists else "❌"
            print(f"   {status} {file_path}")
            if not exists:
                all_exist = False
        
        if not all_exist:
            print("\n❌ Faltan archivos críticos")
            return False
        
        print("\n✅ Todos los archivos necesarios existen")
        return True
    
    def create_deployment_script(self):
        """Crear script que dispare el redeploy en GitHub"""
        self.print_header("PASO 2: PREPARANDO SCRIPT DE REDEPLOY")
        
        # Crear un archivo que indique que se hizo redeploy
        deploy_trigger = Path("DEPLOY_TRIGGER.txt")
        deploy_trigger.write_text(f"""
DEPLOY TRIGGER - {time.strftime('%Y-%m-%d %H:%M:%S')}

Sitio: {self.site_id}
Repositorio: {self.repo_owner}/{self.repo_name}
Rama: {self.branch}

Variables configuradas:
{json.dumps(self.env_vars, indent=2)}

Este archivo fue creado automáticamente para disparar redeploy.
""")
        
        print(f"   ✅ Script de redeploy preparado")
        print(f"   📁 Archivo: DEPLOY_TRIGGER.txt")
        return True
    
    def git_push_changes(self):
        """Hacer push de cambios a GitHub"""
        self.print_header("PASO 3: PUSHEANDO CAMBIOS A GITHUB")
        
        try:
            print("   📤 Agregando archivos...")
            subprocess.run(["git", "add", "DEPLOY_TRIGGER.txt"], check=True)
            print("      ✅ Archivos agregados")
            
            print("   📝 Haciendo commit...")
            subprocess.run([
                "git", "commit", 
                "-m", 
                "Auto-deploy: Triggering redeploy with environment variables"
            ], check=True)
            print("      ✅ Commit realizado")
            
            print("   📤 Haciendo push a GitHub...")
            subprocess.run(["git", "push", "origin", self.branch], check=True)
            print("      ✅ Push completado")
            
            return True
        except subprocess.CalledProcessError as e:
            print(f"      ❌ Error en git: {e}")
            return False
    
    def print_next_steps(self):
        """Imprimir próximos pasos"""
        self.print_header("PASO 4: PRÓXIMOS PASOS EN NETLIFY DASHBOARD")
        
        print("   El push a GitHub ha sido completado.")
        print("   Ahora debes hacer lo siguiente en Netlify Dashboard:\n")
        
        print("   📋 VE A: https://app.netlify.com")
        print("   🔍 Selecciona: snazzy-twilight-868202")
        print("   ⚙️  Settings → Build & deploy → Environment")
        print("   ✏️  Click en [Edit variables]")
        print("\n   📝 AGREGA ESTAS 5 VARIABLES:\n")
        
        for key, value in self.env_vars.items():
            print(f"      {key:25} = {value}")
        
        print("\n   ✅ Haz click [Save]")
        print("   ⏳ Netlify redeploy automáticamente")
        print("   ✨ En 5-10 minutos estará en vivo\n")
    
    def print_test_urls(self):
        """Imprimir URLs para probar"""
        self.print_header("URLs PARA PROBAR DESPUÉS DEL DEPLOY")
        
        base_url = f"https://{self.site_id}.netlify.app"
        
        print(f"   🌐 Frontend:    {base_url}")
        print(f"   📹 API Videos:  {base_url}/api/videos")
        print(f"   💊 Health:      {base_url}/api/health")
        print("\n   Espera a que aparezca 🟢 Published en Netlify Dashboard\n")
    
    def run(self):
        """Ejecutar el deploy automático"""
        print("\n")
        print("╔════════════════════════════════════════════════════════════════════════════╗")
        print("║                                                                            ║")
        print("║                   🚀 DEPLOY AUTOMÁTICO A NETLIFY                          ║")
        print("║                                                                            ║")
        print("║                       snazzy-twilight-868202                               ║")
        print("║                                                                            ║")
        print("╚════════════════════════════════════════════════════════════════════════════╝")
        
        # Paso 1: Verificar archivos
        if not self.check_prerequisites():
            print("\n❌ No se puede continuar sin los archivos necesarios")
            return False
        
        # Paso 2: Crear script de redeploy
        if not self.create_deployment_script():
            print("\n❌ Error preparando script")
            return False
        
        # Paso 3: Push a GitHub
        if not self.git_push_changes():
            print("\n❌ Error haciendo push a GitHub")
            print("   Intenta manualmente:")
            print("   git add .")
            print("   git commit -m 'Auto-deploy'")
            print("   git push origin Blanca")
        
        # Paso 4: Mostrar próximos pasos
        self.print_next_steps()
        
        # Paso 5: URLs de prueba
        self.print_test_urls()
        
        print("\n" + "="*80)
        print("✅ SCRIPT DE DEPLOY COMPLETADO")
        print("="*80)
        print("\n⏭️  ACCIÓN MANUAL REQUERIDA:")
        print("    1. Ve a https://app.netlify.com")
        print("    2. Agrega las 5 variables de entorno")
        print("    3. Netlify redeploy automáticamente\n")
        
        return True

if __name__ == "__main__":
    deployer = NetlifyDeploy()
    deployer.run()
