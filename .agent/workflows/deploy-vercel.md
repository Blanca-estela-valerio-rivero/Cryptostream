---
description: Desplegar CryptoStream en Vercel
---

# 🚀 Guía de Despliegue en Vercel

Esta guía te ayudará a desplegar tu aplicación CryptoStream en Vercel.

## 📋 Prerrequisitos

1. **Cuenta de Vercel**: Crear una cuenta en [vercel.com](https://vercel.com)
2. **Vercel CLI instalado** (opcional): `npm install -g vercel`
3. **Variables de entorno** del archivo `.env` del backend

## 🎯 Método 1: Despliegue desde la Web (Recomendado)

### Paso 1: Subir código a GitHub

Si aún no lo has hecho, sube tu código a GitHub:

```bash
git add .
git commit -m "Preparar para deployment en Vercel"
git push origin main
```

### Paso 2: Importar proyecto en Vercel

1. Ve a [vercel.com/new](https://vercel.com/new)
2. Haz clic en "Import Git Repository"
3. Selecciona tu repositorio `Cryptostream`
4. Configuración del proyecto:
   - **Framework Preset**: Other
   - **Root Directory**: `./`
   - **Build Command**: (dejar vacío o `npm run vercel-build`)
   - **Output Directory**: `frontend/public`

### Paso 3: Configurar Variables de Entorno

En la sección "Environment Variables", agrega las siguientes variables:

**OBLIGATORIAS:**
- `MONGODB_URI`: Tu conexión a MongoDB (Atlas o similar)
- `PINATA_API_KEY`: Tu API Key de Pinata
- `PINATA_SECRET_KEY`: Tu Secret Key de Pinata

**OPCIONALES:**
- `NODE_ENV`: `production`
- `PORT`: `3000`

### Paso 4: Desplegar

1. Haz clic en "Deploy"
2. Espera 2-3 minutos mientras Vercel construye tu aplicación
3. ¡Listo! Tu app estará disponible en `https://cryptostream.vercel.app` (o el dominio que Vercel asigne)

## 🎯 Método 2: Despliegue desde CLI

### Paso 1: Instalar Vercel CLI

```bash
npm install -g vercel
```

### Paso 2: Login en Vercel

```bash
vercel login
```

### Paso 3: Configurar variables de entorno

Antes de desplegar, configura las variables de entorno:

```bash
vercel env add MONGODB_URI
vercel env add PINATA_API_KEY
vercel env add PINATA_SECRET_KEY
```

### Paso 4: Desplegar

Para despliegue de prueba:
```bash
vercel
```

Para despliegue a producción:
// turbo
```bash
vercel --prod
```

## ✅ Verificación Post-Despliegue

### 1. Probar Health Check

Visita: `https://tu-app.vercel.app/api/health`

Deberías ver:
```json
{
  "status": "ok",
  "message": "Server is running 🚀"
}
```

### 2. Probar API de Videos

Visita: `https://tu-app.vercel.app/api/videos`

Deberías ver la lista de videos (aunque esté vacía al inicio)

### 3. Probar Frontend

Visita: `https://tu-app.vercel.app`

Deberías ver la página de login/registro

## 🔧 Solución de Problemas

### Error: "Module not found"

**Solución**: Asegúrate de que el `package.json` en la raíz tenga todas las dependencias:

```bash
npm install
git add package.json package-lock.json
git commit -m "Actualizar dependencias"
git push
```

Luego redeploy en Vercel.

### Error: "Function timeout"

**Solución**: Las funciones serverless de Vercel tienen un límite de tiempo. Para videos grandes:

1. Aumenta el timeout en `vercel.json`:
```json
{
  "functions": {
    "api/**/*.js": {
      "maxDuration": 60
    }
  }
}
```

### Error: CORS

**Solución**: Ya está configurado en `vercel.json`, pero si persiste:

1. Verifica que el frontend use la URL correcta de la API
2. Asegúrate de que el header `Access-Control-Allow-Origin` esté en `vercel.json`

### MongoDB no conecta

**Solución**:
1. Verifica que `MONGODB_URI` esté en las variables de entorno de Vercel
2. Asegúrate de que tu IP esté en la whitelist de MongoDB Atlas
3. Para MongoDB Atlas, agrega `0.0.0.0/0` en Network Access (solo para desarrollo)

## 🔄 Actualizaciones

Para actualizar tu app después de cambios:

```bash
git add .
git commit -m "Descripción de cambios"
git push origin main
```

Vercel detectará automáticamente los cambios y redesplegará.

## 🌐 Dominio Personalizado

Para usar tu propio dominio:

1. Ve a tu proyecto en Vercel Dashboard
2. Settings > Domains
3. Agrega tu dominio personalizado
4. Configura los DNS según las instrucciones de Vercel

## 📊 Monitoreo

Vercel proporciona:
- **Analytics**: Estadísticas de uso
- **Logs**: Ver logs en tiempo real
- **Performance**: Métricas de rendimiento

Accede a todo esto desde el Dashboard de tu proyecto.

## 🎉 ¡Listo!

Tu aplicación CryptoStream ahora está desplegada en Vercel. Comparte tu URL con el mundo:

```
https://tu-app.vercel.app
```

## 📝 Notas Importantes

- Las funciones serverless de Vercel son **stateless**: no guardan estado entre ejecuciones
- Los archivos subidos con Multer se guardan en `/tmp` y se eliminan después de cada ejecución
- Para persistencia de archivos, usa servicios externos como:
  - **Pinata** (IPFS) - Ya configurado ✅
  - **Cloudinary** (imágenes/videos)
  - **AWS S3** (storage general)

## 🆘 Soporte

Si tienes problemas:
1. Revisa los logs en Vercel Dashboard > Deployments > [tu deployment] > Function Logs
2. Verifica las variables de entorno
3. Consulta la [documentación de Vercel](https://vercel.com/docs)
