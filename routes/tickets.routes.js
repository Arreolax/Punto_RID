const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  const tickets = [
    {
      fecha: "01/01/2026 10:30:00",
      nombre_cliente: "Juan Pérez",
      folio: "432rd3efef",
      metodo_pago: "Efectivo",
      productos: [
        { cantidad: 2, total: 199.98 },
        { cantidad: 2, total: 99.99 },
      ],
    },
    {
      fecha: "02/01/2026 18:45:00",
      nombre_cliente: "María López",
      folio: "98asd76asd",
      metodo_pago: "Tarjeta",
      productos: [
        { cantidad: 3, total: 300.0 },
        { cantidad: 1, total: 150.0 },
      ],
    },
  ];

  res.render('tickets/tickets', {
    tickets,
    path: '/tickets',
  });
});


/*
router.get('/ticketpreview', (req, res) => {
  res.render('tickets/ticketpreview');
});
*/

module.exports = router;