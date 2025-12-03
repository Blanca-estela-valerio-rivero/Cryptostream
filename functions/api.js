/**
 * Netlify Serverless Function para CryptoStream
 * 
 * Esta función expone el backend Express como una función serverless en Netlify.
 * La redirección de /api/* a /.netlify/functions/api/:splat se configura en netlify.toml
 * 
 * Importante: Asegúrate de que todas las variables de entorno estén configuradas en Netlify
 */

const serverless = require('serverless-http');
const app = require('../backend/index');

// Configuración de la función serverless
const handler = serverless(app, {
    // Request context
    request: (request, event, context) => {
        // Logging para debugging
        console.log(`[Netlify Function] ${request.method} ${request.path}`);
    },
    // Response context
    response: (response, event, context) => {
        // Logging de respuestas
        console.log(`[Netlify Function] Respuesta: ${response.statusCode}`);
    }
});

module.exports = { handler };
