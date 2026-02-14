const ticketService = require('../services/tickets.service');

const getAllTickets = async (req, res) => {
  try {

    const { fechaInicio, fechaFin } = req.query;
    let tickets;

    if (fechaInicio && fechaFin) {

      const fechaInicioCompleta = `${fechaInicio} 00:00:00`;
      const fechaFinCompleta = `${fechaFin} 23:59:59`;

      tickets = await ticketService.getTicketsDatesService(
        fechaInicioCompleta,
        fechaFinCompleta
      );

    } else {

      tickets = await ticketService.getTicketsService();

    }

    res.render('tickets/tickets', {
  tickets,
  errorMessage: null,
  fechaInicio,
  fechaFin
});

  } catch (error) {

    console.error(error);

    res.render('tickets/tickets', {
      tickets: [],
      errorMessage: "Ocurrió un error al cargar los tickets."
    });
  }
};

module.exports = {
  getAllTickets
};