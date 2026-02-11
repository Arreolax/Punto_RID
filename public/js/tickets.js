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
