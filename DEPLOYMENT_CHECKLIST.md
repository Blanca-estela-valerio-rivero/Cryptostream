# ✅ Checklist de Deployment en Vercel

## 📋 Pre-Deployment

- [ ] Código subido a GitHub
- [ ] Variables de entorno preparadas (de tu archivo `.env`)
  - [ ] `MONGODB_URI`
  - [ ] `PINATA_API_KEY`
  - [ ] `PINATA_SECRET_KEY`
- [ ] Cuenta en Vercel creada

## 🚀 Deployment

- [ ] Proyecto importado en Vercel
- [ ] Variables de entorno configuradas
- [ ] Deploy iniciado
- [ ] Build completado exitosamente

## ✅ Verificación

- [ ] Health check funciona: `/api/health`
- [ ] API de videos funciona: `/api/videos`
- [ ] Frontend carga correctamente: `/`
- [ ] Login/Registro funciona
- [ ] Stellar wallet se conecta
- [ ] Videos se cargan

## 🔄 Post-Deployment

- [ ] Compartir URL con equipo
- [ ] Configurar dominio personalizado (opcional)
- [ ] Monitorear logs en Vercel Dashboard
- [ ] Probar funcionalidades principales

## 📝 Notas

**URL de tu app**: https://_____.vercel.app

**Fecha de deployment**: _____

**Variables de entorno configuradas**: ✅ / ❌

---

## 🆘 Si algo falla

1. Revisa los logs en: Vercel Dashboard > Deployments > Function Logs
2. Verifica variables de entorno
3. Consulta: `VERCEL_DEPLOY.md`
