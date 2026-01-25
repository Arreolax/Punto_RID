const btn = document.getElementById('menuBtn');
const sidebar = document.getElementById('sidebar');
const overlay = document.getElementById('overlay');

btn?.addEventListener('click', () => {
  sidebar.classList.toggle('-translate-x-full');
  overlay.classList.toggle('hidden');
});

overlay?.addEventListener('click', () => {
  sidebar.classList.add('-translate-x-full');
  overlay.classList.add('hidden');
});

function actualizarHora() {
  const now = new Date();
  document.getElementById('fecha').textContent =
    now.toLocaleDateString('es-MX');
  document.getElementById('hora').textContent =
    now.toLocaleTimeString('es-MX');
}

setInterval(actualizarHora, 1000);
actualizarHora();
