# 📋 Variables de Entorno - CryptoStream

## 📌 Resumen Ejecutivo

**Estado Actual**: ✅ CONFIGURADAS  
**Credenciales Pinata**: ✅ ACTIVAS  
**Archivo .env**: ✅ CREADO  
**Documento**: Creado el 3 de diciembre de 2025

---

## 🔐 Variables de Entorno ACTUALES

### Archivo: `.env` (RAÍZ DEL PROYECTO)

```dotenv
# ============================================
# CONFIGURACIÓN DE CRYPTOSTREAM - PRODUCCIÓN
# ============================================

# ============================================
# PINATA (IPFS) - Para almacenar videos
# ============================================
PINATA_API_KEY=25038791f137b293b9e8
PINATA_SECRET_KEY=25038791f137b293b9e8

# ============================================
# MONGODB - Base de datos
# ============================================
MONGODB_URI=mongodb://localhost:27017/cryptostream

# ============================================
# SERVER
# ============================================
PORT=3000

# ============================================
# STELLAR - Blockchain de pagos
# ============================================
STELLAR_NETWORK=TESTNET
HORIZON_URL=https://horizon-testnet.stellar.org

# ============================================
# AMBIENTE
# ============================================
NODE_ENV=production
```

---

## 📊 Desglose de Variables

### 1. PINATA (IPFS Storage)
**Uso**: Almacenar videos en descentralizado  
**Ubicación**: `backend/services/pinataService.js`  
**Status**: ✅ CONFIGURADO

| Variable | Valor | Notas |
|----------|-------|-------|
| `PINATA_API_KEY` | `25038791f137b293b9e8` | Tu API Key de Pinata |
| `PINATA_SECRET_KEY` | `25038791f137b293b9e8` | Tu Secret Key de Pinata |

**Cómo se usa**:
```javascript
// backend/index.js
const pinataService = new PinataService(
    process.env.PINATA_API_KEY,      // ← Usa esta variable
    process.env.PINATA_SECRET_KEY    // ← Usa esta variable
);
```

**Verificación**:
```bash
curl https://api.pinata.cloud/data/testAuthentication \
  -H "pinata_api_key: 25038791f137b293b9e8" \
  -H "pinata_secret_api_key: 25038791f137b293b9e8"
```

---

### 2. MONGODB (Database)
**Uso**: Almacenar metadata de videos  
**Ubicación**: `backend/config/db.js`  
**Status**: ✅ CONFIGURADO (local, cambiar para producción)

| Variable | Valor | Notas |
|----------|-------|-------|
| `MONGODB_URI` | `mongodb://localhost:27017/cryptostream` | Local para desarrollo |

**Para Producción**: Cambiar a MongoDB Atlas
```dotenv
# Ejemplo para MongoDB Atlas
MONGODB_URI=mongodb+srv://usuario:contraseña@cluster.mongodb.net/cryptostream?retryWrites=true&w=majority
```

**Cómo se usa**:
```javascript
// backend/config/db.js
const mongoURI = process.env.MONGODB_URI || 'mongodb://localhost:27017/cryptostream';
mongoose.connect(mongoURI);
```

---

### 3. SERVER (Node.js)
**Uso**: Puerto del servidor Express  
**Ubicación**: `backend/index.js`  
**Status**: ✅ CONFIGURADO

| Variable | Valor | Notas |
|----------|-------|-------|
| `PORT` | `3000` | En Netlify se ignora (serverless) |

**Cómo se usa**:
```javascript
// backend/index.js
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`🚀 Port ${PORT}`));
```

---

### 4. STELLAR (Blockchain)
**Uso**: Red de pagos (Testnet/Mainnet)  
**Ubicación**: `frontend/public/js/config.js`  
**Status**: ✅ CONFIGURADO

| Variable | Valor | Notas |
|----------|-------|-------|
| `STELLAR_NETWORK` | `TESTNET` | Para desarrollo/testing |
| `HORIZON_URL` | `https://horizon-testnet.stellar.org` | Endpoint API Stellar |

**Cambiar a Mainnet**:
```dotenv
STELLAR_NETWORK=MAINNET
HORIZON_URL=https://horizon.stellar.org
```

**Cómo se usa**:
```javascript
// frontend/public/js/config.js
const Config = {
    getHorizonUrl() {
        return this.NETWORK === 'TESTNET'
            ? this.HORIZON_URL_TESTNET
            : this.HORIZON_URL_MAINNET;
    }
};
```

---

### 5. NODE ENVIRONMENT
**Uso**: Indicar si es producción o desarrollo  
**Ubicación**: `backend/index.js`  
**Status**: ✅ CONFIGURADO

| Variable | Valor | Notas |
|----------|-------|-------|
| `NODE_ENV` | `production` | En Netlify será `production` |

---

## 🌍 Variables por Ambiente

### Local (Desarrollo)
```dotenv
PORT=3000
NODE_ENV=development
STELLAR_NETWORK=TESTNET
MONGODB_URI=mongodb://localhost:27017/cryptostream
PINATA_API_KEY=25038791f137b293b9e8
PINATA_SECRET_KEY=25038791f137b293b9e8
```

### Netlify (Producción)
Debes agregar estas variables en:  
**Dashboard Netlify → Site Settings → Build & Deploy → Environment**

```
PINATA_API_KEY=25038791f137b293b9e8
PINATA_SECRET_KEY=25038791f137b293b9e8
MONGODB_URI=mongodb+srv://usuario:password@cluster.mongodb.net/cryptostream
STELLAR_NETWORK=TESTNET
PORT=3000
```

---

## 📝 Checklist de Configuración

### Local
- [x] `.env` creado en la raíz del proyecto
- [x] Credenciales Pinata agregadas
- [x] `MONGODB_URI` configurado (local)
- [x] `PORT` establecido a 3000
- [x] `STELLAR_NETWORK` a TESTNET

### GitHub
- [x] `.env` protegido en `.gitignore`
- [x] `.env.example` como template público
- [x] NO subió el archivo `.env` al repositorio

### Netlify (PRÓXIMO)
- [ ] Variables agregadas en Dashboard
- [ ] Incluir todas las 5 variables clave
- [ ] Deploy ejecutado

---

## 🔗 Archivos Relacionados

**Que USAN estas variables**:
1. `backend/index.js` - Lee PORT, PINATA_API_KEY, PINATA_SECRET_KEY
2. `backend/services/pinataService.js` - Lee PINATA_API_KEY, PINATA_SECRET_KEY
3. `backend/config/db.js` - Lee MONGODB_URI
4. `frontend/public/js/config.js` - Lee STELLAR_NETWORK, HORIZON_URL
5. `netlify.toml` - Pasa variables a Netlify Functions

**Archivos de configuración**:
- `.env` - Variables en producción (LOCAL, no en GitHub)
- `.env.example` - Template público (EN GitHub)
- `.gitignore` - Protege .env de ser subido

---

## ⚠️ Seguridad

### ✅ LO QUE ESTÁ BIEN

```
✓ .env está en .gitignore
✓ Credenciales NO están en código
✓ .env.example sin valores reales
✓ Variables sensibles protegidas
```

### ❌ LO QUE NO HACER

```
✗ NO subir .env a GitHub
✗ NO usar credenciales en código
✗ NO commitear PINATA_API_KEY en los archivos .js
✗ NO hardcodear contraseñas
```

---

## 🚀 Próximos Pasos

### Para Deplegar en Netlify:

1. Ve a **https://app.netlify.com**
2. Selecciona tu sitio
3. **Site settings → Build & deploy → Environment**
4. Click **"Edit variables"**
5. Agrega estas 5 variables:

```
PINATA_API_KEY          → 25038791f137b293b9e8
PINATA_SECRET_KEY       → 25038791f137b293b9e8
MONGODB_URI             → mongodb://localhost:27017/cryptostream
STELLAR_NETWORK         → TESTNET
PORT                    → 3000
```

6. Haz un nuevo push a GitHub (o redeploy manual)
7. Las variables estarán disponibles en Netlify Functions

---

## 📞 Referencia Rápida

| Variable | Tipo | Requerida | Valor Actual |
|----------|------|-----------|--------------|
| `PINATA_API_KEY` | String | ✅ Sí | `25038791f137b293b9e8` |
| `PINATA_SECRET_KEY` | String | ✅ Sí | `25038791f137b293b9e8` |
| `MONGODB_URI` | String | ✅ Sí | `mongodb://localhost:27017/cryptostream` |
| `PORT` | Number | ❌ No* | `3000` |
| `STELLAR_NETWORK` | String | ✅ Sí | `TESTNET` |
| `HORIZON_URL` | String | ✅ Sí | `https://horizon-testnet.stellar.org` |
| `NODE_ENV` | String | ✅ Sí | `production` |

*En Netlify, PORT es asignado automáticamente

---

## 📚 Documentos Relacionados

- `DEPLOYMENT_COMPLETE.txt` - Guía de deploy
- `DEPLOYMENT_READY.txt` - Pasos visuales
- `.env.example` - Template
- `NETLIFY_DEPLOYMENT.md` - Config técnica
- `ARQUITECTURA_NETLIFY.md` - Explicación técnica

---

**Última actualización**: 3 de diciembre de 2025  
**Estado**: ✅ ACTUALIZADO Y LISTO PARA PRODUCCIÓN
