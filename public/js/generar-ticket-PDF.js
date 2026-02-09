async function generarTicketPDF(folio) {
  const input = document.getElementById('ticket-pdf');

  const canvas = await html2canvas(input, {
    scale: 3,
    useCORS: true,
    backgroundColor: '#ffffff',
  });

  const imgData = canvas.toDataURL('image/png');

  const pdfHeight = (canvas.height * 80) / canvas.width;

  const pdf = new jsPDF({
    orientation: 'portrait',
    unit: 'mm',
    format: [80, pdfHeight],
  });

  pdf.addImage(imgData, 'PNG', 0, 0, 80, pdfHeight);
  pdf.save(`ticket_${folio}.pdf`);
}
