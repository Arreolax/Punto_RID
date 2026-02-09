const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  const tickets = [ { fecha: "01/01/2026 10:30:00", nombre_cliente: "Juan Pérez", folio: "432rd3efef", metodo_pago: "Efectivo", productos: [ { cantidad: 2, total: 199.98 }, { cantidad: 2, total: 99.99 }, ], }, { fecha: "02/01/2026 18:45:00", nombre_cliente: "María López", folio: "98asd76asd", metodo_pago: "Tarjeta", productos: [ { cantidad: 3, total: 300.0 }, { cantidad: 1, total: 150.0 }, ], }, { fecha: "03/01/2026 12:55:00", nombre_cliente: "Carlitos Lechuga", folio: "4326482322", metodo_pago: "Efectivo", productos: [ { cantidad: 3, total: 300.0 }, { cantidad: 6, total: 500.0 }, ], }, ];

  res.render('tickets/tickets', {
    tickets,
    path: '/tickets',
  });
});


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