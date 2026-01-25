const express = require('express');
const router = express.Router();

//Layouts pora especificas paginas (test)
router.use((req, res, next) => {

  if (req.path.startsWith('/login') || req.path.startsWith('/register') ) {
    res.locals.layout = 'layouts/auth';
  } else {
    res.locals.layout = 'layouts/header-menu';
  }

  next();
});

// Rutas

router.get('/', (req, res) => {
  res.render('index');
});

/*
router.get('/tickets', (req, res) => {
  res.render('tickets/tickets');
});

router.get('/ticketpreview', (req, res) => {
  res.render('tickets/ticketpreview');
});
*/
//404
router.use((req, res) => {
  res.status(404).render('404');
});

module.exports = router;
