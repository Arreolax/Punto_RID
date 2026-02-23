document.addEventListener('DOMContentLoaded', () => {
  const btnRegresar = document.getElementById('btnRegresarS');

  btnRegresar?.addEventListener('click', () => {
    window.location.href = '/ventas';
  });
});