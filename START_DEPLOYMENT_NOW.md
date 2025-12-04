# 🚀 DEPLOYMENT EN VERCEL - GUÍA PASO A PASO

## ✅ PASO 1: COMPLETADO
- ✅ Código subido a GitHub exitosamente
- ✅ Rama: `Blanca`
- ✅ Commit: "Configurar proyecto para deployment en Vercel"

---

## 📋 PASO 2: DESPLEGAR EN VERCEL

### Opción A: Desde la Web (5 minutos - RECOMENDADO)

#### 1. Abre Vercel
🔗 **Link directo**: https://vercel.com/new

#### 2. Login
- Haz clic en "Continue with GitHub"
- Autoriza a Vercel si es la primera vez

#### 3. Importar Repositorio
- Busca: `Blanca-estela-valerio-rivero/Cryptostream`
- Haz clic en "Import"

#### 4. Configurar Proyecto
**Important Settings:**
```
Project Name: cryptostream (o el que prefieras)
Framework Preset: Other
Root Directory: ./
Build Command: (dejar vacío)
Output Directory: frontend/public
Install Command: (dejar por defecto)
```

#### 5. Variables de Entorno
Haz clic en "Environment Variables" y agrega estas 3:

**COPIA ESTOS VALORES DE TU ARCHIVO `.env`:**

| Name | Value (copia de .env) |
|------|----------------------|
| `MONGODB_URI` | mongodb+srv://... |
| `PINATA_API_KEY` | tu_api_key |
| `PINATA_SECRET_KEY` | tu_secret_key |

**Importante**: Asegúrate de seleccionar "Production", "Preview" y "Development" para cada variable.

#### 6. Deploy!
- Haz clic en el botón **"Deploy"**
- Espera 2-3 minutos
- ¡Listo! 🎉

---

## 🔍 VERIFICACIÓN POST-DEPLOYMENT

Una vez que Vercel termine el deployment, verás un mensaje de éxito con tu URL.

### Verifica estos endpoints:

1. **Health Check**
   ```
   https://tu-app.vercel.app/api/health
   ```
   Debe mostrar: `{"status": "ok", "message": "Server is running 🚀"}`

2. **API de Videos**
   ```
   https://tu-app.vercel.app/api/videos
   ```
   Debe mostrar un array de videos (puede estar vacío al inicio)

3. **Frontend**
   ```
   https://tu-app.vercel.app
   ```
   Debe cargar la página de login/registro

---

## 📊 TUS VARIABLES DE ENTORNO

Para tu referencia, estas son las variables que necesitas (del archivo `.env`):

```bash
# Copia estos valores exactos en Vercel:

MONGODB_URI=mongodb://localhost:27017/cryptostream
# ↑ Si tienes MongoDB Atlas, usa la URI de Atlas

PINATA_API_KEY=(tu valor de .env)
PINATA_SECRET_KEY=(tu valor de .env)
```

**⚠️ IMPORTANTE**: Si `MONGODB_URI` apunta a `localhost`, necesitarás usar MongoDB Atlas (en la nube) para producción.

---

## 🔧 MONGODB ATLAS (Si usas localhost)

Si tu `.env` tiene `MONGODB_URI=mongodb://localhost:27017/cryptostream`, necesitas crear una base de datos en la nube:

### Pasos Rápidos:

1. **Ve a**: https://www.mongodb.com/cloud/atlas/register
2. **Crea cuenta gratuita**
3. **Crea un cluster** (Free Tier - M0)
4. **Database Access**: Crea un usuario con contraseña
5. **Network Access**: Agrega `0.0.0.0/0` (permite todas las IPs)
6. **Connect**: Copia la cadena de conexión:
   ```
   mongodb+srv://usuario:password@cluster.mongodb.net/cryptostream
   ```
7. **Actualiza** la variable `MONGODB_URI` en Vercel con esta nueva URL

---

## 🎯 CHECKLIST FINAL

Antes de hacer Deploy en Vercel, verifica:

- [ ] ✅ Tu repositorio está en GitHub (rama Blanca)
- [ ] ✅ Tienes los 3 valores de variables de entorno listos
- [ ] ✅ Si usas localhost en MongoDB, tienes lista la URI de Atlas
- [ ] ✅ Tienes cuenta en Vercel (o puedes hacer login con GitHub)

---

## 🆘 SOLUCIÓN DE PROBLEMAS

### Error: "Build Failed"
- Verifica que las variables de entorno estén correctamente configuradas
- Revisa los logs en Vercel Dashboard

### Error: MongoDB Connection Failed
- Verifica que `MONGODB_URI` sea correcta
- Si usas Atlas, verifica que la IP esté permitida (0.0.0.0/0)
- Verifica usuario y contraseña en la URI

### Error: Videos no aparecen
- Verifica `PINATA_API_KEY` y `PINATA_SECRET_KEY`
- Comprueba que las variables estén en "Production"

### API devuelve 404
- Verifica que `vercel.json` exista en la raíz
- Reintenta el deploy

---

## 🎉 ¡LISTO PARA DESPLEGAR!

### ACCIÓN INMEDIATA:

1. **Abre**: https://vercel.com/new
2. **Sigue los pasos de arriba**
3. **En 5 minutos tu app estará en vivo**

---

## 📞 RECURSOS ÚTILES

- **Vercel Dashboard**: https://vercel.com/dashboard
- **MongoDB Atlas**: https://cloud.mongodb.com
- **Pinata Dashboard**: https://app.pinata.cloud
- **Vercel Docs**: https://vercel.com/docs

---

## 💡 TIPS

- Vercel te dará un dominio gratis: `cryptostream-xxxxx.vercel.app`
- Puedes agregar un dominio personalizado después
- Cada push a GitHub redesplegará automáticamente
- Los logs están en: Vercel Dashboard → Tu Proyecto → Deployments

---

**¡Hora de desplegar!** 🚀

👉 https://vercel.com/new
