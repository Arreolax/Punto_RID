const db = require('../config/database');

const getTicketsService = async () => {
    try {
        const query = `SELECT DATE_FORMAT(t.created_at, '%d/%m/%Y %H:%i:%s') AS created_at_ticket_formatted,
        DATE_FORMAT(t.created_at, '%d/%m/%Y') AS created_at_ticket_formatted_date,
        t.ticket_number AS folio,
        c.name AS nombre_cliente,
        s.payment_method AS metodo_pago,
        COUNT(si.id) AS total_productos,
        s.total AS total_pago
        FROM tickets t
        JOIN sales s ON t.sale_id = s.id
        JOIN clients c ON s.client_id = c.id
        JOIN sale_items si ON si.sale_id = s.id
        GROUP BY  t.id, t.created_at, t.ticket_number, c.name, s.payment_method, s.total
        ORDER BY t.created_at DESC;`;

        const [rows] = await db.query(query);
        return rows;

    } catch (error) {
        throw new Error('Error en el servicio al obtener tickets: ' + error.message);
    }

};

const getTicketsDatesService = async (fechaInicio, fechaFin) => {
    try {
        const query = `
        SELECT 
        DATE_FORMAT(t.created_at, '%d/%m/%Y %H:%i:%s') AS created_at_ticket_formatted,
        DATE_FORMAT(t.created_at, '%d/%m/%Y') AS created_at_ticket_formatted_date,
        t.ticket_number AS folio,
        c.name AS nombre_cliente,
        s.payment_method AS metodo_pago,
        COUNT(si.id) AS total_productos,
        s.total AS total_pago
        FROM tickets t
        JOIN sales s ON t.sale_id = s.id
        JOIN clients c ON s.client_id = c.id
        JOIN sale_items si ON si.sale_id = s.id
        WHERE t.created_at BETWEEN ? AND ?
        GROUP BY t.id, t.created_at, t.ticket_number, c.name, s.payment_method, s.total
        ORDER BY t.created_at DESC;
        `;

        const [rows] = await db.query(query, [fechaInicio, fechaFin]);
        return rows;

    } catch (error) {
        throw new Error('Error en el servicio al obtener tickets: ' + error.message);
    }
};

module.exports = {
    getTicketsService,
    getTicketsDatesService
};