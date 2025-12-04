# 🚀 CryptoStream - Deployment en Vercel

## 🎯 Despliegue Rápido

### Opción 1: Desde la Web (Más Fácil)

1. **Ve a**: [vercel.com/new](https://vercel.com/new)
2. **Importa** tu repositorio de GitHub
3. **Configura**:
   - Framework: `Other`
   - Root Directory: `./`
   - Output Directory: `frontend/public`
4. **Agrega variables de entorno**:
   ```
   MONGODB_URI=tu_conexion_mongodb
   PINATA_API_KEY=tu_api_key
   PINATA_SECRET_KEY=tu_secret_key
   ```
5. **Deploy!** 🎉

### Opción 2: Desde CLI

```bash
# 1. Instalar Vercel CLI
npm install -g vercel

# 2. Login
vercel login

# 3. Deploy
vercel --prod
```

## 📋 Variables de Entorno Requeridas

Copia estas variables de tu archivo `.env` del backend:

- `MONGODB_URI` - Conexión a MongoDB Atlas
- `PINATA_API_KEY` - API Key de Pinata (IPFS)
- `PINATA_SECRET_KEY` - Secret Key de Pinata

## 🔍 Verificación

Después del deploy, verifica:

1. **Health Check**: `https://tu-app.vercel.app/api/health`
2. **API Videos**: `https://tu-app.vercel.app/api/videos`
3. **Frontend**: `https://tu-app.vercel.app`

## 📖 Documentación Completa

Para más detalles, consulta: `.agent/workflows/deploy-vercel.md`

## 🎬 Arquitectura en Vercel

```
cryptostream.vercel.app/
├── /                    → Frontend (HTML/CSS/JS)
├── /api/health         → Health Check Serverless
├── /api/videos         → API de Videos Serverless
└── /api/upload         → Upload a IPFS Serverless
```

## ⚡ Ventajas de Vercel

- ✅ **Serverless**: Escalado automático
- ✅ **CDN Global**: Ultra rápido en todo el mundo
- ✅ **HTTPS**: SSL automático
- ✅ **Git Integration**: Deploy automático en cada push
- ✅ **Logs**: Monitoreo en tiempo real
- ✅ **Analytics**: Estadísticas de uso

## 🔄 Actualizaciones

```bash
git add .
git commit -m "Actualización"
git push
```

Vercel redesplegará automáticamente.

## 🆘 Problemas Comunes

### MongoDB no conecta
- Verifica `MONGODB_URI` en variables de entorno de Vercel
- Agrega `0.0.0.0/0` a Network Access en MongoDB Atlas

### Videos no se ven
- Verifica `PINATA_API_KEY` y `PINATA_SECRET_KEY`
- Comprueba que tu cuenta Pinata tenga créditos

### Error 404 en API
- Verifica que `vercel.json` exista en la raíz
- Revisa los logs en Vercel Dashboard

---

**¿Listo para desplegar?** 🚀

Sigue la guía paso a paso en `.agent/workflows/deploy-vercel.md`
