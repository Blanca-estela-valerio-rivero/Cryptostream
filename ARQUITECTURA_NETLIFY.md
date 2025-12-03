# 📐 Arquitectura de CryptoStream - Configuración para Netlify

## 🎯 Resumen de Cambios Realizados

Se ha configurado completamente el proyecto **CryptoStream** para desplegar en **Netlify** con el siguiente stack:

- **Frontend**: HTML/CSS/JavaScript puro → Netlify (Static Hosting)
- **Backend**: Node.js + Express → Netlify Functions (Serverless)
- **Base de Datos**: MongoDB Atlas (Cloud)
- **Almacenamiento**: IPFS via Pinata
- **Blockchain**: Stellar Testnet

---

## 🏗️ Arquitectura General

### Flujo de Solicitudes en Producción

```
┌─────────────────────────────────────────────────────────────────┐
│                         NAVEGADOR                                │
│                  https://app.netlify.app                         │
└────────────────────┬────────────────────────────────────────────┘
                     │
        ┌────────────┴────────────┐
        │                         │
        ▼                         ▼
    STATIC FILES            API REQUESTS
    (HTML/CSS/JS)           (/api/*)
        │                         │
        │                         │
    ┌─────────────────────────────┴──────────────────┐
    │        NETLIFY CDN & EDGE                       │
    │  (netlify.toml - Redirects & Headers)          │
    └────────────┬──────────────────────────────────┘
                 │
        ┌────────┴────────┐
        │                 │
        ▼                 ▼
   /index.html      /.netlify/functions/api
   (SPA Routing)    (Serverless Backend)
                         │
                         ▼
                 ┌─────────────────────┐
                 │  backend/index.js   │
                 │  (Express Server)   │
                 └────────┬────────────┘
                          │
        ┌─────────────────┼─────────────────┐
        │                 │                 │
        ▼                 ▼                 ▼
    MongoDB          Pinata (IPFS)    Stellar (Blockchain)
    (Data)           (Videos)         (Payments)
```

---

## 📁 Estructura de Archivos Clave

```
Cryptostream/
│
├── netlify.toml                    ⭐ CONFIGURACIÓN PRINCIPAL
│   ├── [build] - Directorio de publish y comando de build
│   ├── [[redirects]] - Rutas de API y SPA
│   └── [[headers]] - CORS y seguridad
│
├── .env.example                    📝 PLANTILLA DE VARIABLES
│   └── Ejemplo de todas las variables necesarias
│
├── .gitignore                      🔐 ARCHIVOS NO A SUBIR
│   └── Incluye .env, node_modules, etc.
│
├── frontend/
│   └── public/
│       ├── index.html              🌐 PÁGINA PRINCIPAL
│       ├── video.html              🎬 APP PRINCIPAL
│       ├── js/
│       │   ├── config.js           ⭐ CONFIGURACIÓN FRONTEND
│       │   ├── api.js              🔌 LLAMADAS API (ACTUALIZADO)
│       │   ├── user-identity.js    👤 USUARIOS
│       │   ├── passkey-auth.js     🔐 AUTENTICACIÓN
│       │   ├── stellar-wallet.js   💰 BILLETERA
│       │   ├── video-manager.js    🎥 GESTIÓN VIDEOS
│       │   └── ui-controller.js    🎨 INTERFAZ
│       └── css/
│           └── style.css
│
├── backend/                        🔧 BACKEND SERVERLESS
│   ├── index.js                    ⭐ EXPRESS APP (ACTUALIZADO)
│   ├── package.json                📦 DEPENDENCIAS (CON SERVERLESS-HTTP)
│   ├── config/
│   │   └── db.js                   🗄️ CONEXIÓN MONGODB
│   ├── routes/
│   │   └── videos.js               📹 RUTAS API
│   ├── controllers/
│   │   └── videosController.js     🎬 LÓGICA NEGOCIO
│   ├── services/
│   │   └── pinataService.js        📤 IPFS/PINATA
│   └── models/
│       └── Video.js                📊 MODELO DATOS
│
├── functions/
│   └── api.js                      ⭐ FUNCIÓN SERVERLESS (ACTUALIZADO)
│       └── Expone Express como function de Netlify
│
├── NETLIFY_DEPLOYMENT.md           📖 GUÍA COMPLETA
│   └── Pasos detallados para desplegar
│
├── DEPLOYMENT.md                   📖 GUÍA ANTIGUA
│   └── (Referencia, para Railway)
│
└── README.md                       📖 DESCRIPCIÓN GENERAL
```

---

## ⚙️ Cambios Realizados

### 1. **netlify.toml** - Configuración Correcta

#### ✅ Problemas Solucionados:

**ANTES:**
```toml
# ❌ PROBLEMA: Redirección /* ANTES de /api/*
# Esto causaba que /api/* se redirigiera a /index.html
[[redirects]]
  from = "/*"
  to = "/index.html"

[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/api/:splat"
```

**AHORA:**
```toml
# ✅ SOLUCIÓN: API redirige PRIMERO
[[redirects]]
  from = "/api/*"
  to = "/.netlify/functions/api/:splat"  # ← API primero
  force = true

# ✅ SPA routing es la ÚLTIMA regla
[[redirects]]
  from = "/*"
  to = "/index.html"
  force = false
```

**¿Por qué importa el orden?**
- Netlify procesa redirecciones en el orden que aparecen
- Si `/*` va primero, TODAS las solicitudes (incluyendo `/api/*`) van a `/index.html`
- Agregamos `force = true` en API para asegurar que tiene prioridad

### 2. **frontend/public/js/config.js** - Detección Automática

#### ✅ Ahora maneja Dev y Producción Automáticamente:

```javascript
getApiBaseUrl() {
    // En localhost → http://localhost:3000/api
    if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
        return 'http://localhost:3000/api';
    }
    // En Netlify → /api (se redirige automáticamente)
    return '/api';
}
```

**Ventaja**: NO necesitas cambiar código. Funciona en ambos ambientes.

### 3. **functions/api.js** - Función Serverless

#### ✅ Expone Express como Function de Netlify:

```javascript
const serverless = require('serverless-http');
const app = require('../backend/index');

const handler = serverless(app, {
    request: (request, event, context) => {
        console.log(`[Netlify Function] ${request.method} ${request.path}`);
    }
});

module.exports = { handler };
```

**Cómo funciona:**
1. Netlify llama a `handler()` cuando hay solicitud a `/.netlify/functions/api`
2. `serverless-http` convierte la solicitud HTTP en formato que Express entiende
3. Express procesa la solicitud como si fuera un servidor normal
4. La respuesta se devuelve a Netlify

### 4. **backend/package.json** - Dependencia Serverless

#### ✅ Se agregó `serverless-http`:

```json
{
  "dependencies": {
    "serverless-http": "^3.2.0",  // ← NUEVA
    "express": "^4.18.2",
    "cors": "^2.8.5",
    // ... resto de deps
  }
}
```

**Por qué es necesaria:**
- Convierte Express a formato compatible con Netlify Functions
- Netlify lo instala automáticamente al detectar `functions/api.js`

### 5. **backend/index.js** - Modo Dual

#### ✅ Funciona como Servidor Normal Y como Serverless:

```javascript
// Al final del archivo:
if (require.main === module) {
    // ↓ Solo se ejecuta cuando se llama directamente (node index.js)
    app.listen(PORT, () => {
        console.log(`🚀 Servidor en puerto ${PORT}`);
    });
}

// ↓ Se exporta para que lo use serverless-http
module.exports = app;
```

**Ventaja:**
- Puedes testear localmente: `npm start`
- En Netlify se usa como módulo: no escucha puertos

### 6. **frontend/js/api.js** - URLs Dinámicas

#### ✅ Ahora usa Config en lugar de hardcodear localhost:

**ANTES:**
```javascript
const API_URL = 'http://localhost:3000/api/videos'; // ❌ Hardcodeado
```

**AHORA:**
```javascript
export async function getVideos() {
    const url = `${Config.getVideosUrl()}`; // ✅ Dinámico
    return fetch(url).then(r => r.json());
}
```

---

## 🔑 Variables de Entorno

### Requeridas en Netlify

```env
# ⭐ CRÍTICAS - Sin estas, nada funciona
PINATA_API_KEY=tu_api_key
PINATA_SECRET_KEY=tu_secret_key
MONGODB_URI=mongodb+srv://user:pass@cluster.mongodb.net/db

# Opcionales pero recomendadas
PORT=3000
STELLAR_NETWORK=TESTNET
```

### Cómo Agregarlas

```
1. Netlify Dashboard → Tu Sitio
2. Site settings → Build & deploy → Environment
3. Add variables (agregar cada una)
4. Triggear redeploy (Deploys → Trigger deploy)
```

---

## 🔍 Flujos de Solicitud Específicos

### Flujo 1: Cargar Página (SPA Routing)

```
1. Usuario entra a https://app.netlify.app
2. Netlify CDN busca /index.html
3. No hay /index.html (porque estamos en raíz)
4. netlify.toml dice: /* → /index.html
5. Netlify sirve /index.html
6. JavaScript se ejecuta
7. Config.getApiBaseUrl() devuelve /api
```

### Flujo 2: Cargar Videos (API Call)

```
1. JavaScript hace fetch('/api/videos')
2. Netlify ve /api/videos
3. netlify.toml dice: /api/* → /.netlify/functions/api/:splat
4. Netlify redirige a /.netlify/functions/api/videos
5. Se ejecuta functions/api.js
6. serverless-http pasa a backend/index.js
7. Express maneja GET /api/videos
8. videosController.js devuelve JSON
9. Respuesta vuelve al navegador
```

### Flujo 3: Subir Video (Con Multer)

```
1. Usuario selecciona archivo
2. upload-manager.js hace POST /api/upload
3. netlify.toml redirige a /.netlify/functions/api/upload
4. backend/index.js recibe con multer
5. Archivo se sube a Pinata (IPFS)
6. Respuesta con IPFS hash
7. video-manager.js crea entrada en BD
```

### Flujo 4: Hacer Pago (Stellar)

```
1. Usuario hace click en "Comprar Video"
2. video-manager.js llama stellar-wallet.js
3. Firma transacción con clave privada
4. Envía a Stellar Testnet (NO a Netlify)
5. Verifica pago en https://stellar.expert/explorer/testnet
6. Frontend marca video como comprado
```

---

## ✅ Checklist de Configuración

### En el Repositorio

- [x] `netlify.toml` - Redirecciones en orden correcto
- [x] `.env.example` - Documentación de variables
- [x] `.gitignore` - NO incluye .env
- [x] `backend/index.js` - Exporta app para serverless
- [x] `backend/package.json` - Incluye serverless-http
- [x] `functions/api.js` - Expone Express
- [x] `frontend/public/js/config.js` - Detección automática
- [x] `frontend/js/api.js` - Usa Config dinámicamente

### En Netlify Dashboard

- [ ] Conectar con GitHub
- [ ] Configurar build: `cd backend && npm install`
- [ ] Configurar publish: `frontend/public`
- [ ] Agregar PINATA_API_KEY
- [ ] Agregar PINATA_SECRET_KEY
- [ ] Agregar MONGODB_URI
- [ ] Triggear primer deploy

---

## 🐛 Debugging

### Verificar que Todo Funciona

```bash
# 1. Test endpoint de salud
curl https://app.netlify.app/api/health
# Debe devolver: {"status":"ok","message":"Server is running 🚀"}

# 2. Test endpoint de videos
curl https://app.netlify.app/api/videos
# Debe devolver array JSON

# 3. Verificar logs de Netlify
# Dashboard → Deploys → Tu deploy → Functions
```

### Errores Comunes

| Error | Causa | Solución |
|-------|-------|----------|
| `Cannot GET /api/videos` | Redirecciones mal ordenadas | Verifica netlify.toml, API debe ir ANTES de /* |
| `MODULE_NOT_FOUND: serverless-http` | Falta dependencia | `npm install serverless-http` en backend |
| `PINATA_API_KEY is undefined` | Variables no agregadas | Netlify Dashboard → Environment → Add variables |
| `Cannot connect to MongoDB` | URI incorrecta | Verifica MONGODB_URI en variables |
| `CORS error` | Headers no configurados | Verifica netlify.toml [[headers]] |

---

## 🚀 Pasos Siguientes

1. **Hacer Push a GitHub**
   ```bash
   git add .
   git commit -m "Configure for Netlify deployment"
   git push
   ```

2. **Conectar Netlify**
   - Ve a netlify.com
   - "Add new site" → "Import existing project"
   - Selecciona GitHub y Cryptostream repo
   - Configura build settings (ver NETLIFY_DEPLOYMENT.md)
   - Agrega variables de entorno
   - Deploy!

3. **Testear**
   - Abre https://app.netlify.app
   - Verifica console (F12) sin errores
   - Prueba crear cuenta, subir video, etc.

---

## 📚 Referencias

- [Netlify Functions](https://docs.netlify.com/functions/overview/)
- [serverless-http](https://github.com/dougmoscrop/serverless-http)
- [Express.js](https://expressjs.com/)
- [Netlify Redirects](https://docs.netlify.com/routing/redirects/)

---

**Status**: ✅ Listo para desplegar en Netlify

**Última actualización**: 3 de diciembre de 2025

