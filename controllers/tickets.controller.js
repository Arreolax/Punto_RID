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

const getTicketPreview = async (req, res) => {
  try {
    const { folio } = req.params;

    const ticket = await ticketService.getTicketByFolioService(folio);

    if (!ticket) {
      return res.render('tickets/preview', {
        ticket: null,
        errorMessage: "Ticket no encontrado."
      });
    }

    res.render('tickets/preview', {
      ticket,
      errorMessage: null
    });

  } catch (error) {
    console.error(error);

    res.render('tickets/preview', {
      ticket: null,
      errorMessage: "Ocurrió un error al cargar el ticket."
    });
  }
};

module.exports = {
  getAllTickets,
  getTicketPreview
};