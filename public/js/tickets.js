const modal = document.getElementById("modalTicket");
const backdrop = document.getElementById("modalBackdrop");
const btnCerrar = document.getElementById("btnCerrarModal");

document.querySelectorAll(".btnEditar").forEach(btn => {
  btn.addEventListener("click", () => {
    const ticket = JSON.parse(btn.dataset.ticket);

    abrirModal();

    requestAnimationFrame(() => {
      modal.querySelector("#fecha").value = ticket.fecha;
      modal.querySelector("#folio").value = ticket.folio;
      modal.querySelector("#cliente").value = ticket.nombre_cliente;
      modal.querySelector("#metodo_pago").value = ticket.metodo_pago;

      const cant_prod = ticket.productos.reduce(
        (sum, p) => sum + p.cantidad,
        0
      );

      const total = ticket.productos.reduce(
        (sum, p) => sum + p.total,
        0
      );

      modal.querySelector("#cant_prod").value = cant_prod;
      modal.querySelector("#total").value = total.toFixed(2);
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
