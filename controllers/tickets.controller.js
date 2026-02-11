// controllers/tickets.controller.js
const ticketService = require('../services/tickets.service');

const getAllTickets = async (req, res) => {
    try {
        const tickets = await ticketService.getTicketsService();

        res.render('tickets/tickets', { 
            tickets: tickets,   // 'tickets' será la variable que usaremos en el HTML
        });

    } catch (error) {
        console.error(error);
        res.status(500).send('Error interno del servidor');
    }
};

module.exports = {
    getAllTickets
};