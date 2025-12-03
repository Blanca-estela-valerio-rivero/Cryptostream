# ✅ CHECKLIST FINAL - Deployment CryptoStream en Netlify

## 📋 Antes de Comenzar

### Requisitos de Sistema

- [ ] Node.js 18.17.0 instalado: `node --version`
- [ ] Git instalado: `git --version`
- [ ] Cuenta en GitHub creada
- [ ] Cuenta en Netlify creada (https://netlify.com)
- [ ] Terminal/PowerShell disponible

### Servicios de Terceros (Obtener Credenciales)

- [ ] **Pinata** (IPFS): https://www.pinata.cloud/
  - [ ] Cuenta creada
  - [ ] API Key copiada
  - [ ] Secret Key copiada
  
- [ ] **MongoDB Atlas** (Base de datos, opcional):
  - [ ] Cuenta creada
  - [ ] Cluster creado
  - [ ] Connection URI copiada
  - [ ] User/password creados
  
- [ ] **Stellar Testnet** (Blockchain):
  - [ ] Cuenta creada: https://laboratory.stellar.org/#account-creator?network=test
  - [ ] Public Key copiada (G...)
  - [ ] Secret Key guardada segura (S...)

---

## 🔧 Configuración Local

### Paso 1: Preparar Archivos

```bash
# En c:\Users\Estela\Desktop\CRYPTOSTREAM\

# ✅ Verificar que existan estos archivos:
# - netlify.toml (ya configurado)
# - .gitignore (ya configurado)
# - .env.example (ya configurado)
# - NETLIFY_DEPLOYMENT.md (guía completa)
# - ARQUITECTURA_NETLIFY.md (arquitectura técnica)
```

**Checklist:**
- [ ] `netlify.toml` existe y tiene redirecciones correctas
- [ ] `.env.example` documenta todas las variables
- [ ] `.gitignore` incluye `.env`

### Paso 2: Crear Archivo .env

```bash
# En la raíz del proyecto
cp .env.example .env

# Luego editar con tus valores
```

**Contenido de `.env`:**
```env
PINATA_API_KEY=tu_key_aqui
PINATA_SECRET_KEY=tu_secret_aqui
MONGODB_URI=mongodb://localhost:27017/cryptostream
PORT=3000
STELLAR_NETWORK=TESTNET
```

**Checklist:**
- [ ] `.env` creado en la raíz
- [ ] `PINATA_API_KEY` agregada
- [ ] `PINATA_SECRET_KEY` agregada
- [ ] `MONGODB_URI` configurada (local o cloud)
- [ ] `.env` NO está en git (`git status` no lo muestra)

### Paso 3: Instalar Dependencias

```bash
# Backend
cd backend
npm install
# Debe instalar: express, cors, multer, serverless-http, etc.

# Verificar que incluya serverless-http
npm list serverless-http
```

**Checklist:**
- [ ] `npm install` completó sin errores
- [ ] `serverless-http` está en node_modules
- [ ] Archivo `backend/package-lock.json` creado

### Paso 4: Testear Localmente

**Terminal 1 - Backend:**
```bash
cd backend
npm start
# Debe mostrar:
# ✅ Pinata configurado correctamente
# 🚀 Servidor corriendo en puerto 3000
```

**Terminal 2 - Frontend:**
```bash
cd frontend/public
# Opción A: Python
python -m http.server 5500

# Opción B: Live Server (VS Code)
# Clic derecho en index.html → Open with Live Server
```

**Verificar en navegador:**
```
1. Abre http://localhost:5500
2. Console (F12) no debe tener errores rojos
3. Intenta crear cuenta (puede fallar si no hay BD, pero sin errores JS)
```

**Checklist:**
- [ ] Backend inicia sin errores
- [ ] Frontend se ve correctamente
- [ ] Console (F12) sin errores críticos
- [ ] Request a `/api/health` devuelve JSON

---

## 📤 Subir a GitHub

### Paso 1: Inicializar Git

```bash
# En la raíz del proyecto
cd c:\Users\Estela\Desktop\CRYPTOSTREAM

# Ver estado
git status
# Debe mostrar archivos sin .env

# Agregar todo (excepto .env por .gitignore)
git add .

# Hacer commit
git commit -m "Initial commit: CryptoStream ready for Netlify"

# Crear rama main
git branch -M main
```

**Checklist:**
- [ ] `git status` NO muestra `.env`
- [ ] `git status` muestra archivos del proyecto
- [ ] Commit hecho exitosamente

### Paso 2: Crear Repositorio en GitHub

```
1. Ve a https://github.com/new
2. Nombre: Cryptostream
3. Descripción: dApp de videos con Stellar
4. Privado o Público (tu elección)
5. NO inicialices con README (ya tenemos uno)
6. Click "Create repository"
7. Copia la URL (HTTPS o SSH)
```

**Checklist:**
- [ ] Repositorio creado en GitHub
- [ ] URL del repo copiada

### Paso 3: Conectar y Push

```bash
# Reemplazar <REPO_URL> con tu URL de GitHub
git remote add origin <REPO_URL>

# Verificar
git remote -v
# Debe mostrar origin con tu URL

# Hacer Push
git push -u origin main

# Verificar en GitHub
# Abre tu repo en GitHub, debe ver todos los archivos
```

**Checklist:**
- [ ] Git remote configurado
- [ ] `git push` completó exitosamente
- [ ] Archivos visibles en GitHub (sin .env)
- [ ] Rama main es la default

---

## 🌐 Configurar Netlify

### Paso 1: Conectar GitHub

```
1. Ve a https://app.netlify.com
2. Haz login (si no estás ya)
3. Click en "Add new site"
4. Selecciona "Import an existing project"
5. Selecciona "GitHub"
6. Autoriza Netlify en GitHub (si pide)
7. Busca "Cryptostream" en tu lista de repos
8. Click en el repo
```

**Checklist:**
- [ ] Conectado con GitHub
- [ ] Repo Cryptostream visible en Netlify
- [ ] Netlify pide configurar build settings

### Paso 2: Configurar Build

En el formulario de Deploy, configura:

```
Build command:         cd backend && npm install
Publish directory:     frontend/public
Functions directory:   functions
Base directory:        (dejar vacío)
```

**Importante**: 
- NO hagas deploy aún
- Primero hay que agregar variables de entorno

**Checklist:**
- [ ] Build command es: `cd backend && npm install`
- [ ] Publish directory es: `frontend/public`
- [ ] Functions directory es: `functions`

### Paso 3: Agregar Variables de Entorno

```
1. En el formulario de deploy, haz click en "Advanced"
2. O después de crear el sitio: Site settings → Build & deploy → Environment
3. Click "Edit variables"
4. Agregar cada variable (una a una):
```

**Variables a Agregar:**

| Variable | Valor | Ejemplo |
|----------|-------|---------|
| `PINATA_API_KEY` | Tu API Key de Pinata | `abc123def456` |
| `PINATA_SECRET_KEY` | Tu Secret Key de Pinata | `xyz789uvw012` |
| `MONGODB_URI` | Connection string MongoDB | `mongodb+srv://user:pass@cluster.mongodb.net/db` |
| `PORT` | Puerto (Netlify lo asigna) | `3000` |
| `STELLAR_NETWORK` | Red a usar | `TESTNET` |

```
Pasos:
1. Click "New variable"
2. Key: PINATA_API_KEY
3. Value: <tu_api_key>
4. Click "Save"
5. Repetir para cada variable
```

**Checklist:**
- [ ] PINATA_API_KEY agregada
- [ ] PINATA_SECRET_KEY agregada
- [ ] MONGODB_URI agregada (si usas MongoDB cloud)
- [ ] PORT agregada
- [ ] STELLAR_NETWORK agregada

### Paso 4: Deploy Inicial

```
1. Click en "Deploy site"
2. Netlify comenzará a construir
3. Verás progreso en tiempo real
4. Debe completar en 2-5 minutos
5. Recibirás URL: https://algo-aleatorio.netlify.app
```

**Qué hace Netlify:**
```
1. Clona tu repo de GitHub
2. Ejecuta: cd backend && npm install
3. Copia frontend/public a CDN
4. Crea función serverless de functions/api.js
5. Configura redirects de netlify.toml
```

**Checklist:**
- [ ] Deploy iniciado
- [ ] Deploy completó (verde)
- [ ] URL de Netlify generada: https://xxxxx.netlify.app
- [ ] NO hay errores rojos

### Paso 5: Customizar Dominio (Opcional)

```
1. Site settings → Domain management
2. Click en "Edit site name"
3. Nombre personalizado (ej: cryptostream-app)
4. Nueva URL: https://cryptostream-app.netlify.app
```

**Checklist:**
- [ ] Dominio personalizado configurado (opcional)
- [ ] URL accesible en navegador

---

## ✅ Verificaciones Finales

### Test 1: Página se Carga

```
1. Abre https://tuapp.netlify.app
2. Debe ver interfaz de CryptoStream
3. Console (F12) sin errores rojos críticos
```

**Checklist:**
- [ ] Página se carga en Netlify
- [ ] No hay error "Cannot GET /"
- [ ] HTML/CSS se ve correctamente

### Test 2: API está Activa

```bash
# En terminal o navegador:
curl https://tuapp.netlify.app/api/health

# Debe devolver:
# {"status":"ok","message":"Server is running 🚀"}
```

**O en navegador:**
```
1. Abre https://tuapp.netlify.app/api/health
2. Debe devolver JSON
3. No debe devolver HTML de error
```

**Checklist:**
- [ ] Endpoint `/api/health` funciona
- [ ] Devuelve JSON válido
- [ ] No hay redirección a /index.html

### Test 3: Videos API Funciona

```bash
curl https://tuapp.netlify.app/api/videos

# Debe devolver un array (vacío o con videos)
# Ejemplo: []
# O: [{"id":1,"title":"..."}]
```

**Checklist:**
- [ ] Endpoint `/api/videos` funciona
- [ ] Devuelve array JSON
- [ ] Sin errores de conexión a BD

### Test 4: Logs de Netlify

```
1. Ve a https://app.netlify.com
2. Selecciona tu sitio
3. Click en último "Deploy" (verde)
4. Abre pestaña "Functions"
5. Debe ver logs de requests a /api
6. Sin errores rojos
```

**Checklist:**
- [ ] Logs accesibles en Netlify
- [ ] Requests a /api aparecen en logs
- [ ] Sin errores de MODULE_NOT_FOUND

### Test 5: Funcionalidad Base

```
1. Crear cuenta (click en Register)
2. Ingresar Public Key de Stellar
3. Ingresar nombre
4. No debería haber errores JS
5. (Puede fallar sin BD configurada, pero sin errores JS)
```

**Checklist:**
- [ ] Formulario de registro se ve
- [ ] Console sin errores de API
- [ ] Requests a /api aparecen en network (F12)

---

## 🐛 Troubleshooting

### Error: "Cannot GET /api/health" (404)

**Posible causa:** netlify.toml no está bien configurado

**Solución:**
```
1. Ve a Site settings → Build & deploy → Continuous Deployment
2. Triggea redeploy (Deploy site)
3. Espera a que complete
4. Intenta de nuevo
```

### Error: "Cannot find module 'serverless-http'"

**Posible causa:** Falta instalar la dependencia

**Solución:**
```bash
# En backend/package.json, verificar que tiene:
"serverless-http": "^3.2.0"

# Luego hacer push
git add backend/package.json
git commit -m "Fix serverless-http dependency"
git push

# Redeploy en Netlify
```

### Error: "PINATA_API_KEY is undefined"

**Posible causa:** Variables no guardadas en Netlify

**Solución:**
```
1. Netlify Dashboard → Site settings → Environment
2. Verificar que PINATA_API_KEY está listada
3. Si no está, agregarla
4. Redeploy: Deploys → Trigger deploy
```

### MongoDB Connection Error

**Posible causa:** URI incorrecta o sin IP whitelist

**Solución:**
```
1. Verificar MONGODB_URI en variables
2. Si es MongoDB Atlas:
   - Va a Atlas Dashboard
   - Network Access
   - Agregar IP 0.0.0.0/0 (permite todos)
3. Redeploy
```

### Página en Blank/Blanca

**Posible causa:** Frontend no se publicó correctamente

**Solución:**
```
1. Netlify → Site settings → Build & deploy
2. Verificar: Publish directory = frontend/public
3. Redeploy
```

---

## 📊 Resumen de URLs

Después de desplegar exitosamente:

```
✅ Frontend:         https://tuapp.netlify.app
✅ API Health:      https://tuapp.netlify.app/api/health
✅ Videos API:      https://tuapp.netlify.app/api/videos
✅ Upload Endpoint: https://tuapp.netlify.app/api/upload
✅ Dashboard:       https://app.netlify.com (tu sitio)
✅ GitHub:          https://github.com/tuuser/Cryptostream
```

---

## 🎉 ¡Éxito!

Si todos los checks pasaron:

1. **Compartir la URL** con otros usuarios
2. **Testear funcionalidad** (crear cuenta, subir videos)
3. **Monitorear** los logs de Netlify regularmente
4. **Mantener actualizado** el código en GitHub

### Próximos Pasos (Cuando estés listo):

- [ ] Migrar a Stellar Mainnet (producción real)
- [ ] Configurar dominio personalizado (ej: cryptostream.app)
- [ ] Mejorar base de datos (reducir tamaño uploads)
- [ ] Agregar más funcionalidades (comentarios, likes, etc.)
- [ ] Implementar CI/CD mejorado

---

## 📚 Documentos Relacionados

- **NETLIFY_DEPLOYMENT.md** - Guía detallada paso a paso
- **ARQUITECTURA_NETLIFY.md** - Explicación técnica de cómo funciona
- **.env.example** - Template de variables de entorno
- **netlify.toml** - Configuración de Netlify
- **README.md** - Descripción general del proyecto

---

**Última actualización:** 3 de diciembre de 2025
**Estado:** ✅ Listo para desplegar

Buena suerte! 🚀

