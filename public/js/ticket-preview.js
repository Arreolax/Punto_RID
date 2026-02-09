document.addEventListener('DOMContentLoaded', () => {
  const btnPDF = document.getElementById('btnGenerarPDF');
  const btnRegresar = document.getElementById('btnRegresar');

  btnPDF?.addEventListener('click', () => {
    const folio = btnPDF.dataset.folio;
    generarTicketPDF(folio);
  });

  btnRegresar?.addEventListener('click', () => {
    window.location.href = '/tickets';
  });
});
