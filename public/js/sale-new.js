
const metodoPago = document.getElementById("metodo_pago");

const referencia = document.getElementById("referencia");

const efectivo = document.getElementById("efectivoOptions");
const efectivoRecibido = document.getElementById("efectivoRecibido");
const cambioDevuelto = document.getElementById("efectivoCambio");


metodoPago.addEventListener("change", function () {
    mostrarLoader();

    setTimeout(() => {

        if (this.value === "transferencia" || this.value === "tarjeta") {

            referencia.classList.remove("hidden");
            efectivo.classList.add("hidden");
            efectivoRecibido.classList.add("hidden");
            cambioDevuelto.classList.add("hidden");

        } else if (this.value === "efectivo") {
            referencia.classList.add("hidden");
            efectivo.classList.remove("hidden");
            efectivoRecibido.classList.remove("hidden");
            cambioDevuelto.classList.remove("hidden");
        }
        ocultarLoader();

    }, 100); 

});

window.addEventListener("load", () => {
    referencia.classList.add("hidden");
    efectivoRecibido.classList.add("hidden");
    cambioDevuelto.classList.add("hidden");
    efectivo.classList.add("hidden");
});
