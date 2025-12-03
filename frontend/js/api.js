/**
 * API Module para CryptoStream
 * Utiliza Config.getApiBaseUrl() para manejar automáticamente dev vs producción
 * 
 * En desarrollo: http://localhost:3000/api
 * En producción: /api (redirigido por netlify.toml a funciones serverless)
 */

export async function registerWallet(publicKey) {
    const url = `${Config.getApiBaseUrl()}/register-wallet`;
    return fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ publicKey })
    }).then(r => r.json());
}

export async function getVideos() {
    const url = `${Config.getVideosUrl()}`;
    return fetch(url).then(r => r.json());
}

export async function sendReward(videoId, publicKey) {
    const url = `${Config.getApiBaseUrl()}/reward`;
    return fetch(url, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ videoId, publicKey })
    }).then(r => r.json());
}
