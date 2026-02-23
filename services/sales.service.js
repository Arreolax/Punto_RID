const db = require("../config/database");

const getSalesService = async () => {
  try {
    const query = `SELECT 
    DATE_FORMAT(s.created_at, '%d/%m/%Y %H:%i:%s') AS created_at_sale_formatted,
    s.id AS id,
    s.payment_method AS metodo_pago,
    s.total AS total_pago,
    s.cash_received AS total_recibido,
    s.change_given AS cambio,

    c.name AS nombre_cliente,
    CONCAT(u.name, ' ', u.last_name) AS nombre_empleado,

    GROUP_CONCAT(
        CONCAT('» ', p.etiqueta, ' (', si.quantity, ' unidades)')
        SEPARATOR '<br>'
    ) AS productos,

    si.quantity AS cantidad,
    SUM(si.subtotal) AS total_venta

FROM sales s
JOIN clients c ON s.client_id = c.id
JOIN users u ON s.user_id = u.id
JOIN sale_items si ON si.sale_id = s.id
JOIN products p ON si.product_id = p.id

GROUP BY 
    s.id,
    s.created_at,
    s.payment_method,
    s.total,
    s.cash_received,
    s.change_given,
    c.name,
    u.name,
    u.last_name

ORDER BY s.created_at DESC;
`;

    const [rows] = await db.query(query);
    return rows;
  } catch (error) {
    throw new Error(
      "Error en el servicio al obtener ventas: " + error.message,
    );
  }
};

const getSalesDatesService = async (fechaInicio, fechaFin) => {
    try {
        const query = `SELECT 
    DATE_FORMAT(s.created_at, '%d/%m/%Y %H:%i:%s') AS created_at_sale_formatted,
    s.id AS id,
    s.payment_method AS metodo_pago,
    s.total AS total_pago,
    s.cash_received AS total_recibido,
    s.change_given AS cambio,

    c.name AS nombre_cliente,
    CONCAT(u.name, ' ', u.last_name) AS nombre_empleado,

    GROUP_CONCAT(
        CONCAT('» ', p.etiqueta, ' (', si.quantity, ' unidades)')
        SEPARATOR '<br>'
    ) AS productos,

    si.quantity AS cantidad,
    SUM(si.subtotal) AS total_venta

FROM sales s
JOIN clients c ON s.client_id = c.id
JOIN users u ON s.user_id = u.id
JOIN sale_items si ON si.sale_id = s.id
JOIN products p ON si.product_id = p.id

WHERE s.created_at BETWEEN ? AND ?

GROUP BY 
    s.id,
    s.created_at,
    s.payment_method,
    s.total,
    s.cash_received,
    s.change_given,
    c.name,
    u.name,
    u.last_name

ORDER BY s.created_at DESC;
        `;

        const [rows] = await db.query(query, [fechaInicio, fechaFin]);
        return rows;

    } catch (error) {
        throw new Error('Error en el servicio al obtener ventas: ' + error.message);
    }
};

//Preview
const getSaleByIDService = async (id) => {
    try {
        const query = `SELECT 
    DATE_FORMAT(s.created_at, '%d/%m/%Y %H:%i:%s') AS created_at_sale_formatted,
    s.id AS id,
    s.payment_method AS metodo_pago,
    s.payment_reference AS referencia_pago,
    s.total AS total_pago,
    s.cash_received AS total_recibido,
    s.change_given AS cambio,

    c.name AS nombre_cliente,
    CONCAT(u.name, ' ', u.last_name) AS nombre_empleado,

    si.quantity AS producto_cantidad,
    si.unit_price AS precio_unidad,
    si.subtotal AS subtotal,

    p.ref_producto AS codigo,
    p.etiqueta AS producto_nombre,

    t.ticket_number AS folio,
    
    ca.name AS categoria

FROM sales s
JOIN clients c ON s.client_id = c.id
JOIN users u ON s.user_id = u.id
JOIN sale_items si ON si.sale_id = s.id
JOIN products p ON si.product_id = p.id
JOIN tickets t ON s.id = t.sale_id
JOIN categories ca ON ca.id = p.categoria_id

WHERE s.id = ?`;

        const [rows] = await db.query(query, [id]);
        
        if (rows.length === 0) return null;

        const sale = {
            id: rows[0].id,
            fecha: rows[0].created_at_sale_formatted,
            username_empleado: rows[0].username_empleado,
            nombre_empleado: rows[0].nombre_empleado,
            nombre_cliente: rows[0].nombre_cliente,
            metodo_pago: rows[0].metodo_pago,
            referencia_pago: rows[0].referencia_pago,
            total_pago: rows[0].total_pago,
            total_recibido: rows[0].total_recibido,
            cambio: rows[0].cambio,
            folio_ticket: rows[0].folio,
            cantidad_productos: rows[0].cantidad,
            productos: []
        };

        rows.forEach(row => {
            sale.productos.push({
            //  nombre a usar: nombre en la consulta
                codigo: row.codigo,
                nombre: row.producto_nombre,
                categoria: row.categoria,
                precio_unidad: row.precio_unidad,
                cantidad: row.producto_cantidad,
                subtotal: row.subtotal
            });
        });
        console.log(sale);

        return sale;

    } catch (error) {
        throw new Error('Error en el servicio al obtener la venta por id: ' + error.message);
    }
};

module.exports = {
  getSalesService,
  getSaleByIDService,
  getSalesDatesService
};
