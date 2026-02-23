const express = require('express');
const router = express.Router(); 
const salesController = require('../controllers/sales.controller');

router.get('/', salesController.getAllSales);

router.get('/preview/:id', salesController.getSalePreview);


router.get('/nueva', (req, res) => {
  res.render('ventas/newsale');
});

module.exports = router;