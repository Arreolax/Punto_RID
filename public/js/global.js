// Modal Alerta
const alertModal = document.getElementById("alertModal");
const alertBackdrop = document.getElementById("alertBackdrop");
const alertTitle = document.getElementById("alertTitle");
const alertMessage = document.getElementById("alertMessage");
const alertIcon = document.getElementById("alertIcon");
const alertClose = document.getElementById("alertClose");

function mostrarAlerta(tipo, mensaje) {

  if (!alertModal) return;

  alertMessage.textContent = mensaje;

  if (tipo === "error") {
    alertTitle.textContent = "Error";
    alertIcon.innerHTML = "❌";
    alertTitle.className = "text-lg font-bold text-red-600";
  }

  if (tipo === "success") {
    alertTitle.textContent = "Éxito";
    alertIcon.innerHTML = "✅";
    alertTitle.className = "text-lg font-bold text-green-600";
  }

  if (tipo === "warning") {
    alertTitle.textContent = "Advertencia";
    alertIcon.innerHTML = "⚠️";
    alertTitle.className = "text-lg font-bold text-yellow-600";
  }

  alertModal.classList.remove("hidden");
  alertModal.classList.add("flex");
  alertBackdrop.classList.remove("hidden");
}

function cerrarAlerta() {
  alertModal.classList.add("hidden");
  alertModal.classList.remove("flex");
  alertBackdrop.classList.add("hidden");
}

if (alertClose) {
  alertClose.addEventListener("click", cerrarAlerta);
  alertBackdrop.addEventListener("click", cerrarAlerta);
}

window.mostrarAlerta = mostrarAlerta;