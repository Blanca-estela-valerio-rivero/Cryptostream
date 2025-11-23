const serverURL = 'http://localhost:3000/api/videos';
let publicKey = null;

// Conectar con Freighter
document.getElementById('connect').onclick = async () => {
    if (window.freighterApi) {
        try {
            publicKey = await window.freighterApi.getPublicKey();
            document.getElementById('account').innerText = `Cuenta conectada: ${publicKey}`;
            loadVideos();
        } catch (err) {
            console.error(err);
        }
    } else {
        alert('Instala Freighter!');
    }
};

// Agregar video
document.getElementById('addVideo').onclick = async () => {
    const url = document.getElementById('videoUrl').value;
    if (!url || !publicKey) return alert('Debes conectar tu cuenta y poner la URL');

    const response = await fetch(`${serverURL}/add`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ url, ownerPublicKey: publicKey })
    });

    const data = await response.json();
    console.log(data);
    loadVideos();
};

// Cargar videos
async function loadVideos() {
    const res = await fetch(serverURL);
    const videos = await res.json();
    const list = document.getElementById('videosList');
    list.innerHTML = '';
    videos.forEach(v => {
        const li = document.createElement('li');
        li.textContent = `ID: ${v.id}, URL: ${v.url}, Dueño: ${v.owner}`;
        list.appendChild(li);
    });
}
