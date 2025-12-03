# 🚀 Guía Completa de Deployment - CryptoStream en Netlify

## 📋 Contenidos
1. [Preparación Inicial](#preparación-inicial)
2. [Configuración Local](#configuración-local)
3. [Subir a GitHub](#subir-a-github)
4. [Configurar Backend en Netlify](#configurar-backend-en-netlify)
5. [Configurar Frontend en Netlify](#configurar-frontend-en-netlify)
6. [Variables de Entorno](#variables-de-entorno)
7. [Troubleshooting](#troubleshooting)

---

## 🔧 Preparación Inicial

### Requisitos Previos
- ✅ Node.js 18.17.0 o superior
- ✅ Git instalado
- ✅ Cuenta en GitHub
- ✅ Cuenta en Netlify (https://netlify.com)
- ✅ Cuenta en Pinata (https://www.pinata.cloud) - para IPFS
- ✅ Cuenta en MongoDB Atlas (https://www.mongodb.com/cloud/atlas) - opcional pero recomendado

### Obtener Credenciales Necesarias

#### 1. **Pinata API Keys** (Para almacenamiento de videos)
```
1. Ve a https://www.pinata.cloud/
2. Inicia sesión o crea cuenta
3. Ve a API Keys (panel izquierdo)
4. Click en "New Key"
5. Habilita "API Pinning Service"
6. Copia la API Key y Secret Key
7. Guarda en lugar seguro (necesitarás en Netlify)
```

#### 2. **MongoDB URI** (Base de datos en la nube - Opcional)
```
1. Ve a https://www.mongodb.com/cloud/atlas
2. Crea una cuenta o inicia sesión
3. Crea un nuevo proyecto
4. Crea un cluster (elige el tier Free)
5. Ve a "Database" y crea una conexión
6. Copia la connection string URI
7. Reemplaza <username> y <password> con tus credenciales
```

#### 3. **Stellar Testnet Account** (Para pagos)
```
1. Ve a https://laboratory.stellar.org/#account-creator?network=test
2. Click en "Generate keypair"
3. Guarda tu Public Key (G...)
4. Guarda tu Secret Key (S...) - ¡NO lo compartas nunca!
```

---

## 📁 Configuración Local

### 1. Clonar/Preparar el repositorio localmente

```bash
# Si es nuevo proyecto
cd tu-carpeta-cryptostream

# Si clonaste
git clone https://github.com/tu-usuario/Cryptostream.git
cd Cryptostream
```

### 2. Crear archivo `.env` local

```bash
# En la raíz del proyecto
cp .env.example .env
```

Edita `.env` con tus valores:

```env
# Pinata
PINATA_API_KEY=tu_pinata_api_key
PINATA_SECRET_KEY=tu_pinata_secret_key

# MongoDB (local o cloud)
MONGODB_URI=mongodb://localhost:27017/cryptostream
# O para MongoDB Atlas:
# MONGODB_URI=mongodb+srv://usuario:password@cluster.mongodb.net/cryptostream

# Server
PORT=3000

# Stellar
STELLAR_NETWORK=TESTNET
```

### 3. Instalar dependencias

```bash
# Backend
cd backend
npm install

# Frontend (si necesitas)
cd ../frontend
npm install
```

### 4. Probar localmente

**Terminal 1 - Backend:**
```bash
cd backend
npm start
# Debe mostrar: 🚀 Servidor corriendo en puerto 3000
```

**Terminal 2 - Frontend:**
```bash
cd frontend/public
# Opción 1: Con Live Server (VS Code extension)
# Clic derecho en index.html > "Open with Live Server"

# Opción 2: Con Python
python -m http.server 5500

# Abre: http://localhost:5500
```

---

## 📤 Subir a GitHub

### 1. Verificar .gitignore

Asegúrate de que `.env` está en `.gitignore`:

```bash
# Ver archivo .gitignore
cat .gitignore
```

Debe contener:
```
.env
.env.local
```

### 2. Inicializar Git (si no lo has hecho)

```bash
git init
git add .
git commit -m "Initial commit: CryptoStream dApp"
git branch -M main
```

### 3. Crear repositorio en GitHub

```
1. Ve a https://github.com/new
2. Nombre: Cryptostream
3. Descripción: dApp de videos con Stellar
4. Privado o Público (tu elección)
5. Click "Create repository"
6. Copia la URL (HTTPS o SSH)
```

### 4. Conectar y hacer Push

```bash
# Reemplaza <TU_REPO_URL> con la URL de GitHub
git remote add origin <TU_REPO_URL>
git push -u origin main
```

---

## 🔌 Configurar Backend en Netlify

### Opción A: Backend como Funciones Serverless (Recomendado)

Este proyecto ya está configurado para usar funciones serverless en Netlify.

#### ¿Cómo funciona?

```
Cliente (Frontend)
    ↓
    /api/* request
    ↓
netlify.toml (redirección)
    ↓
/.netlify/functions/api (función serverless)
    ↓
backend/index.js (Express app)
    ↓
Base de datos y servicios
```

#### Instalación Automática

Netlify instalará automáticamente las dependencias cuando detecte:
- `backend/package.json` con dependencias
- `functions/api.js` con la función serverless

---

## 🌐 Configurar Frontend en Netlify

### Paso 1: Conectar Netlify con GitHub

```
1. Ve a https://app.netlify.com
2. Click "Add new site" → "Import an existing project"
3. Selecciona "GitHub"
4. Autoriza Netlify en GitHub
5. Busca y selecciona "Cryptostream"
```

### Paso 2: Configurar opciones de Build

En el formulario de deploy, configura:

```
Build command:        cd backend && npm install
Publish directory:    frontend/public
Functions directory:  functions
Base directory:       (dejar vacío)
```

### Paso 3: Agregar Variables de Entorno

```
1. NO hagas click en Deploy aún
2. Click en "Advanced" o ve a Site settings después
3. Build & deploy → Environment
4. Click "Edit variables"
5. Agrega las siguientes variables:

PINATA_API_KEY=tu_api_key
PINATA_SECRET_KEY=tu_secret_key
MONGODB_URI=tu_mongodb_uri
PORT=3000
STELLAR_NETWORK=TESTNET
```

### Paso 4: Deploy

```
1. Click en "Deploy site"
2. Espera a que complete (2-5 minutos)
3. Netlify generará una URL: https://tuapp.netlify.app
4. Copia esta URL
```

---

## 📝 Variables de Entorno en Netlify

Las variables de entorno son **críticas** para que la app funcione en producción.

### Acceder al panel de variables

```
1. Ve a https://app.netlify.com
2. Selecciona tu sitio
3. Site settings (esquina superior derecha)
4. Build & deploy → Environment
5. Edit variables
```

### Variables Requeridas

| Variable | Valor | Ejemplo |
|----------|-------|---------|
| `PINATA_API_KEY` | Tu API Key de Pinata | `1234567890abcdef` |
| `PINATA_SECRET_KEY` | Tu Secret Key de Pinata | `abc123def456` |
| `MONGODB_URI` | Connection string de MongoDB | `mongodb+srv://user:pass@cluster.mongodb.net/db` |
| `PORT` | Puerto (Netlify lo asigna) | `3000` |
| `STELLAR_NETWORK` | Red de Stellar | `TESTNET` |

### Variables Opcionales

```env
# Para debugging
NODE_ENV=production
DEBUG=false

# Para monitoreo
SENTRY_DSN=tu_sentry_dsn_aqui
```

⚠️ **IMPORTANTE**: Después de agregar variables, debes **redeploy** el sitio:
```
Deploys → Trigger deploy → Deploy site
```

---

## 🔍 Verificar que Todo Funciona

### 1. Verificar Frontend

```
1. Abre https://tuapp.netlify.app
2. Debes ver la página principal de CryptoStream
3. Abre la consola del navegador (F12)
4. No debe haber errores críticos
```

### 2. Verificar API Backend

```bash
curl https://tuapp.netlify.app/api/health

# Debes obtener respuesta JSON:
# {"status":"ok","message":"Server is running 🚀"}
```

### 3. Verificar Logs de Netlify

```
1. Ve a https://app.netlify.com
2. Selecciona tu sitio
3. Deploys → último deploy
4. Click en "Functions" para ver logs
5. Busca errores o mensajes importantes
```

---

## 🆘 Troubleshooting

### Error: "Cannot find module 'serverless-http'"

**Solución:**
```bash
cd backend
npm install serverless-http
git add package.json package-lock.json
git commit -m "Add serverless-http dependency"
git push
# Redeploy en Netlify
```

### Error: "PINATA_API_KEY is undefined"

**Solución:**
1. Ve a Site settings → Environment
2. Verifica que `PINATA_API_KEY` está definida
3. Haz Redeploy (Deploys → Trigger deploy)

### Error: "/api/* returns 404"

**Solución:**
1. Verifica que `functions/api.js` existe
2. Verifica que `netlify.toml` tiene redirecciones correctas
3. Verifica el orden de redirecciones (API antes que SPA)
4. Redeploy

### Videos no se suben / CORS error

**Solución:**
1. Verifica `PINATA_API_KEY` en variables de entorno
2. Verifica que Pinata está configurado correctamente
3. Abre la consola (F12) y busca el error específico
4. Verifica logs en Netlify: Deploys → Functions

### MongoDB connection error

**Solución:**
1. Verifica que `MONGODB_URI` está correcta
2. Si usas MongoDB Atlas, verifica:
   - IP whitelist (agregar 0.0.0.0/0 para Netlify)
   - Usuario y contraseña son correctos
   - URI tiene permiso de acceso

### Frontend dice "Cannot connect to backend"

**Verificar:**
1. Abre el navegador en https://tuapp.netlify.app/api/health
2. Si da error 404, el problema es la redirección
3. Si da error de conectar, el problema es el backend
4. Revisa los logs de Netlify

---

## ✅ Checklist Final

- [ ] ✅ Credenciales de Pinata obtenidas
- [ ] ✅ MongoDB URI configurada
- [ ] ✅ `.env` archivo creado localmente
- [ ] ✅ Backend y Frontend prueban en local
- [ ] ✅ Código pusheado a GitHub
- [ ] ✅ Netlify conectado con GitHub
- [ ] ✅ Variables de entorno agregadas en Netlify
- [ ] ✅ Frontend accesible en Netlify
- [ ] ✅ API responde correctamente
- [ ] ✅ Videos suben a IPFS exitosamente

---

## 🎉 ¡Listo!

Tu aplicación CryptoStream está ahora en producción:

- **Frontend**: https://tuapp.netlify.app
- **API**: https://tuapp.netlify.app/api
- **Videos**: Se almacenan en IPFS (Pinata)
- **Pagos**: Se procesan en Stellar Testnet

### Próximos Pasos

1. **Compartir**: Envía el enlace a amigos
2. **Testear**: Prueba crear cuenta, subir videos, hacer pagos
3. **Monitorear**: Revisa los logs de Netlify regularmente
4. **Escalar**: Cuando estés listo, migra a Stellar Mainnet (cambiar STELLAR_NETWORK)

---

## 📚 Enlaces Útiles

- [Documentación de Netlify](https://docs.netlify.com/)
- [Documentación de Stellar](https://developers.stellar.org/)
- [Documentación de Pinata](https://docs.pinata.cloud/)
- [Documentación de MongoDB](https://docs.mongodb.com/)
- [Logs de Netlify](https://app.netlify.com/)

---

¿Problemas? Revisa los logs de Netlify o abre un issue en GitHub. 🚀
