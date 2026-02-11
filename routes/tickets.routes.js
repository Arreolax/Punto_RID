const express = require('express');
const router = express.Router();
const ticketsController = require('../controllers/tickets.controller');

router.get('/', ticketsController.getAllTickets);


router.get('/preview', (req, res) => {
  const ticket = {
    fecha: "XX/XX/XXXX 00:00:00",
    nombre_cliente: "Nombre Cliente",
    folio: "432rd3efef",
    total: 11111.99,
    pagado: 11112.0,
    metodo_pago: "Efectivo",
    productos: [
      {
        nombre: "Producto 1",
        codigo: "P001",
        descripcion: "blablablabla",
        cantidad: 100,
        total: 999.99,
      },
      {
        nombre: "Producto 2",
        codigo: "P002",
        descripcion: "blablablabla",
        cantidad: 100,
        total: 999.99,
      },
      {
        nombre: "Producto 3",
        codigo: "P003",
        descripcion: "blablablabla",
        cantidad: 100,
        total: 999.99,
      },
      {
        nombre: "Producto 4",
        codigo: "P004",
        descripcion: "blablablabla",
        cantidad: 100,
        total: 999.99,
      },
    ],
  };

  const efectivo = ticket.metodo_pago === 'Efectivo';
  const cambio = (ticket.pagado - ticket.total).toFixed(2);

   res.render('tickets/ticketpreview', {
    ticket,
    efectivo,
    cambio,
  });
});


module.exports = router;