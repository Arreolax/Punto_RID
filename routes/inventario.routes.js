const express = require('express');
const router = express.Router();
const controller = require('../controllers/inventario.controller');

router.get('/', controller.index);
router.post('/productos', controller.create);
router.post('/productos/:id', controller.update);

module.exports = router;
