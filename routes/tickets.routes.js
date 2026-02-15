const express = require('express');
const router = express.Router();
const ticketsController = require('../controllers/tickets.controller');

router.get('/', ticketsController.getAllTickets);


router.get('/preview/:folio', ticketsController.getTicketPreview);

module.exports = router;