# 🚀 DEPLOY A NETLIFY - ENLACE DIRECTO

## ✅ OPCIÓN 1: CLICK DIRECTO (Lo más fácil)

### Botón de Deploy

```html
<a href="https://app.netlify.com/start/deploy?repository=https://github.com/Blanca-estela-valerio-rivero/Cryptostream&branch=Blanca" target="_blank">
  <img src="https://www.netlify.com/img/deploy/button.svg" alt="Deploy to Netlify" />
</a>
```

### O simplemente abre este enlace:

**https://app.netlify.com/start/deploy?repository=https://github.com/Blanca-estela-valerio-rivero/Cryptostream&branch=Blanca**

---

## 📋 QUÉ SUCEDE AL HACER CLICK

1. ✅ Te pide iniciar sesión en Netlify (si no estás logueado)
2. ✅ Autoriza el acceso a GitHub
3. ✅ Crea un nuevo sitio automáticamente
4. ✅ Conecta tu repositorio
5. ✅ Va a la pantalla de variables de entorno
6. ⏳ **AHORA TÚ DEBES AGREGAR LAS VARIABLES** (ver abajo)

---

## 🔐 VARIABLES A AGREGAR EN NETLIFY

Una vez que hagas click en el enlace, verás una pantalla para agregar variables. Agrega estas 5:

### Variable 1
```
Key:    PINATA_API_KEY
Value:  25038791f137b293b9e8
```

### Variable 2
```
Key:    PINATA_SECRET_KEY
Value:  25038791f137b293b9e8
```

### Variable 3
```
Key:    MONGODB_URI
Value:  mongodb://localhost:27017/cryptostream
```

### Variable 4
```
Key:    STELLAR_NETWORK
Value:  TESTNET
```

### Variable 5
```
Key:    PORT
Value:  3000
```

---

## ✅ PASOS FINALES

1. Agrega las 5 variables de arriba
2. Click en **"Save and deploy"** o **"Deploy site"**
3. Espera 5-10 minutos a que Netlify construya todo
4. Una vez completo, verás tu URL: `https://xxxxx.netlify.app`

---

## 📊 CONFIGURACIÓN QUE NETLIFY USARÁ

El enlace automáticamente configura:

```toml
# Build settings
Build command:      cd backend && npm install
Publish directory:  frontend/public
Base directory:     (vacío)
Functions:         functions
```

---

## 🎯 ENLACE PARA COMPARTIR

**Comparte este enlace para que otros desplieguen:**

```
https://app.netlify.com/start/deploy?repository=https://github.com/Blanca-estela-valerio-rivero/Cryptostream&branch=Blanca
```

O abre directamente en tu navegador:

https://app.netlify.com/start/deploy?repository=https://github.com/Blanca-estela-valerio-rivero/Cryptostream&branch=Blanca

---

## ⚠️ PUNTOS IMPORTANTES

1. **Necesitas una cuenta Netlify** (gratis en https://netlify.com)
2. **Necesitas GitHub conectado** a Netlify
3. **Agrega las 5 variables** antes de hacer deploy
4. **Sin variables, Pinata no funcionará**
5. El deploy tarda 5-10 minutos

---

## 🔗 ENLACES ÚTILES

- **Dashboard Netlify**: https://app.netlify.com
- **Crear cuenta Netlify**: https://app.netlify.com/signup
- **Repositorio GitHub**: https://github.com/Blanca-estela-valerio-rivero/Cryptostream
- **Rama**: Blanca
- **Documentación**: DEPLOYMENT_COMPLETE.txt

---

## 📝 DESPUÉS DEL DEPLOY

Una vez que esté deployado, verás:

```
✅ Frontend: https://xxxxx.netlify.app
✅ API: https://xxxxx.netlify.app/api/videos
✅ Health: https://xxxxx.netlify.app/api/health
```

---

**Creado**: 3 de diciembre de 2025  
**Estado**: ✅ LISTO PARA COMPARTIR
