const db = require('../config/database');

const getTicketsService = async () => {
    try {
        const query = `SELECT 
    DATE_FORMAT(t.created_at, '%d/%m/%Y %H:%i:%s') AS created_at_ticket_formatted,
    t.ticket_number AS folio,
    c.name AS nombre_cliente,
    s.payment_method AS metodo_pago, 
    SUM(ti.quantity) AS total_productos,
    s.total AS total_pago
FROM tickets t
JOIN sales s ON t.sale_id = s.id
JOIN clients c ON s.client_id = c.id
JOIN ticket_items ti ON ti.ticket_id = t.id
WHERE t.created_at IS NOT NULL
GROUP BY t.id, t.created_at, t.ticket_number, c.name, s.payment_method, s.total
ORDER BY t.created_at DESC;`;

        const [rows] = await db.query(query);
        return rows;

    } catch (error) {
        throw new Error('Error en el servicio al obtener tickets: ' + error.message);
    }

};

const getTicketsDatesService = async (fechaInicio, fechaFin) => {
    try {
        const query = `SELECT DATE_FORMAT(t.created_at, '%d/%m/%Y %H:%i:%s') AS created_at_ticket_formatted,
        t.ticket_number AS folio,
        c.name AS nombre_cliente,
        s.payment_method AS metodo_pago,
        SUM(ti.quantity) AS total_productos,
        s.total AS total_pago

        FROM tickets t
        JOIN sales s ON t.sale_id = s.id
        JOIN clients c ON s.client_id = c.id
        JOIN ticket_items ti ON ti.ticket_id = t.id
        WHERE t.created_at BETWEEN ? AND ?
        GROUP BY  t.id, t.created_at, t.ticket_number, c.name, s.payment_method, s.total
        ORDER BY t.created_at DESC;
        `;

        const [rows] = await db.query(query, [fechaInicio, fechaFin]);
        return rows;

    } catch (error) {
        throw new Error('Error en el servicio al obtener tickets: ' + error.message);
    }
};

//Preview
const getTicketByFolioService = async (folio) => {
    try {
        const query = `
        SELECT 
        DATE_FORMAT(t.created_at, '%d/%m/%Y %H:%i:%s') AS fecha_con_formato,
        t.ticket_number AS folio,
        t.company_name AS compania,
        t.company_phone AS compania_telefono,
        t.company_logo_path AS compania_logo,
        t.commercial_message AS mensaje_comercial,
        
        c.name AS nombre_cliente,
        
        u.username AS username_empleado,
        CONCAT(u.name, ' ', u.last_name) AS nombre_empleado,
        
        s.payment_method AS metodo_pago,
        s.total AS total_pago,
        s.cash_received AS total_recibido,
        s.change_given AS cambio,
        s.id AS sale_id,
        
        p.ref_producto AS codigo,

        ti.product_name AS producto_nombre,
        ti.description AS producto_descripcion,
        ti.quantity AS producto_cantidad,
        ti.unit_price AS precio_unidad,
        ti.subtotal AS subtotal
            
        FROM tickets t
        JOIN sales s ON t.sale_id = s.id
        JOIN clients c ON s.client_id = c.id
        JOIN users u ON t.user_id = u.id
        JOIN ticket_items ti ON ti.ticket_id = s.id
        JOIN products p ON ti.product_id = p.id
        WHERE t.ticket_number = ?;
        `;

        const [rows] = await db.query(query, [folio]);
        
        if (rows.length === 0) return null;

        const ticket = {
            folio: rows[0].folio,
            fecha: rows[0].fecha_con_formato,
            nombre_compania: rows[0].compania,
            telefono_compania: rows[0].compania_telefono,
            compania_logo: rows[0].compania_logo,
            mensaje_comercial: rows[0].mensaje_comercial,
            username_empleado: rows[0].username_empleado,
            nombre_empleado: rows[0].nombre_empleado,
            nombre_cliente: rows[0].nombre_cliente,
            metodo_pago: rows[0].metodo_pago,
            total_pago: rows[0].total_pago,
            total_recibido: rows[0].total_recibido,
            cambio: rows[0].cambio,
            productos: []
        };

        rows.forEach(row => {
            ticket.productos.push({
            //  nombre a usar: nombre en la consulta
                nombre: row.producto_nombre,
                codigo: row.codigo,
                descripcion: row.producto_descripcion,
                cantidad: row.producto_cantidad,
                precio_unidad: row.precio_unidad,
                subtotal: row.subtotal
            });
        });

        return ticket;

    } catch (error) {
        throw new Error('Error en el servicio al obtener ticket por folio: ' + error.message);
    }
};

module.exports = {
    getTicketsService,
    getTicketsDatesService,
    getTicketByFolioService
};