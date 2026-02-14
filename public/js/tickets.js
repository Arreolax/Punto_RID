//mostrarAlerta("success", "success_text");
//mostrarAlerta("error", "error_text");
//mostrarAlerta("warning", "warning_text");

// Pantalla Carga
const loader = document.getElementById("loader");
const contenido = document.getElementById("contenido");

function ocultarLoader() {
  loader.classList.add("hidden");
  contenido.classList.remove("hidden");
}
// Filtrar Fechas
const formFiltro = document.querySelector("form");
const inputFechaInicio = document.querySelector("input[name='fechaInicio']");
const inputFechaFin = document.querySelector("input[name='fechaFin']");

formFiltro.addEventListener("submit", function (e) {

  const fechainicio = inputFechaInicio.value;
  const fechafin = inputFechaFin.value;

  if (!fechainicio || !fechafin) {
    e.preventDefault();
    mostrarAlerta("error", "Debes seleccionar ambas fechas.");
    return;
  }

  if (fechafin < fechainicio) {
    e.preventDefault();
    mostrarAlerta("error", "La fecha final no puede ser menor que la inicial.");
    return;
  }
});


// Modal Editar
const modal = document.getElementById("modalTicket");
const backdrop = document.getElementById("modalBackdrop");
const btnCerrar = document.getElementById("btnCerrarModal");

document.querySelectorAll(".btnEditar").forEach(btn => {
  btn.addEventListener("click", () => {
    const ticket = JSON.parse(btn.dataset.ticket);

    abrirModal();
    requestAnimationFrame(() => {
      modal.querySelector("#fecha").value = ticket.created_at_ticket_formatted;
      modal.querySelector("#folio").value = ticket.folio;
      modal.querySelector("#cliente").value = ticket.nombre_cliente;
      modal.querySelector("#metodo_pago").value = ticket.metodo_pago;
      modal.querySelector("#cant_prod").value = ticket.total_productos;
      modal.querySelector("#total").value = ticket.total_pago;
    });
  });
});

function abrirModal() {
  modal.classList.remove("hidden");
  modal.classList.add("flex");
  backdrop.classList.remove("hidden");
}

function cerrarModal() {
  modal.classList.add("hidden");
  modal.classList.remove("flex");
  backdrop.classList.add("hidden");
}

btnCerrar.addEventListener("click", cerrarModal);
backdrop.addEventListener("click", cerrarModal);

// Mostrar pantalla carga - Errores
window.addEventListener("load", () => {
  ocultarLoader();

  if (window.SERVER_ERROR) {
    mostrarAlerta("error", window.SERVER_ERROR);
  }
});