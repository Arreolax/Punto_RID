// Filtrar Fechas
const formFiltro = document.querySelector("form");
const inputFechaInicio = document.querySelector("input[name='fechaInicio']");
const inputFechaFin = document.querySelector("input[name='fechaFin']");

formFiltro.addEventListener("submit", function (e) {

  const fechainicio = inputFechaInicio.value;
  const fechafin = inputFechaFin.value;

  if (!fechainicio || !fechafin) {
    e.preventDefault();
    mostrarAlerta("error", "Selecciona ambas fechas");
    return;
  }

  if (fechafin < fechainicio) {
    e.preventDefault();
    mostrarAlerta("error", "La fecha final no puede ser menor que la inicial");
    return;
  }
});