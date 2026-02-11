/* =====================
   ROLES
   ===================== */
INSERT INTO roles (id, name, description) VALUES
(1, 'Administrador', 'Acceso total al sistema'),
(2, 'Empleado', 'Acceso limitado a ventas e inventario');

/* =====================
   PERMISSIONS
   ===================== */
INSERT INTO permissions (id, name, module, description) VALUES
(1, 'crear_producto', 'inventario', 'Permite crear productos'),
(2, 'editar_producto', 'inventario', 'Permite editar productos'),
(3, 'eliminar_producto', 'inventario', 'Permite eliminar productos'),
(4, 'realizar_venta', 'ventas', 'Permite registrar ventas'),
(5, 'ver_reportes', 'reportes', 'Permite ver reportes');

/* =====================
   ROLE_PERMISSIONS
   ===================== */
INSERT INTO role_permissions (id, role_id, permission_id) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 2, 4);

/* =====================
   USERS
   ===================== */
INSERT INTO users (
    id, username, email, password_hash, role_id
) VALUES
(1, 'admin', 'admin@sistema.com', '$2b$10$abcdefghijklmnopqrstuv', 1),
(2, 'empleado1', 'empleado1@sistema.com', '$2b$10$abcdefghijklmnopqrstuv', 2),
(3, 'empleado2', 'empleado2@sistema.com', '$2b$10$abcdefghijklmnopqrstuv', 2),
(4, 'empleado3', 'empleado3@sistema.com', '$2b$10$abcdefghijklmnopqrstuv', 2);

/* =====================
   USER_ROLES
   ===================== */
INSERT INTO user_roles (id, user_id, role_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 2),
(4, 4, 2);

/* =====================
   CATEGORIES
   ===================== */
INSERT INTO categories (id, name, description) VALUES
(1, 'Bebidas', 'Bebidas y refrescos'),
(2, 'Snacks', 'Botanas y golosinas'),
(3, 'Lácteos', 'Productos derivados de la leche'),
(4, 'Abarrotes', 'Productos de despensa');

/* =====================
   PRODUCTS
   ===================== */
INSERT INTO products (
    id, ref_producto, etiqueta, categoria_id,
    precio_venta, mejor_precio_compra,
    stock_deseado, stock_fisico
) VALUES
(1, 'REF-001', 'Coca Cola 600ml', 1, 18.00, 12.50, 50, 30),
(2, 'REF-002', 'Sabritas Original', 2, 15.00, 10.00, 40, 25),
(3, 'REF-003', 'Leche Lala 1L', 3, 25.00, 18.00, 40, 35),
(4, 'REF-004', 'Arroz 1Kg', 4, 22.00, 15.50, 60, 50),
(5, 'REF-005', 'Frijol Negro 1Kg', 4, 28.00, 20.00, 60, 55);

/* =====================
   CLIENTS
   ===================== */
INSERT INTO clients (id, name, rfc, email, phone) VALUES
(1, 'Juan Pérez', 'JUAP900101ABC', 'juan@mail.com', '6181234567'),
(2, 'María López', 'MALO920202XYZ', 'maria@mail.com', '6185551111', 'Durango, México'),
(3, 'Empresa XYZ SA de CV', 'EXY010101AAA', 'facturacion@xyz.com', '6185552222', 'Zona Industrial');

/* =====================
   SALES
   ===================== */
INSERT INTO sales (
    id, user_id, client_id, total,
    payment_method, cash_received, change_given
) VALUES
(1, 2, 1, 33.00, 'efectivo', 50.00, 17.00),
(2, 3, 2, 50.00, 'efectivo', 100.00, 50.00),
(3, 4, NULL, 28.00, 'tarjeta', NULL, NULL);

/* =====================
   SALE_ITEMS
   ===================== */
INSERT INTO sale_items (
    id, sale_id, product_id, quantity,
    unit_price, subtotal
) VALUES
(1, 1, 1, 1, 18.00, 18.00),
(2, 1, 2, 1, 15.00, 15.00),
(3, 2, 3, 2, 25.00, 50.00),
(4, 3, 5, 1, 28.00, 28.00);

/* =====================
   INVENTORY_MOVEMENTS
   ===================== */
INSERT INTO inventory_movements (
    id, product_id, user_id, movement_type,
    reason, quantity
) VALUES
(1, 1, 2, 'salida', 'venta', 1),
(2, 2, 2, 'salida', 'venta', 1),
(3, 3, 3, 'salida', 'venta', 2),
(4, 5, 4, 'salida', 'venta', 1);

/* =====================
   TICKETS
   ===================== */
INSERT INTO tickets (
    id, ticket_number, sale_id,
    user_id, company_name
) VALUES
(1, 'TCK-0001', 1, 2, 'Mi Tienda'),
(2, 'TCK-0002', 2, 3, 'Mi Tienda'),
(3, 'TCK-0003', 3, 4, 'Mi Tienda');

/* =====================
   TICKET_ITEMS
   ===================== */
INSERT INTO ticket_items (
    id, ticket_id, product_id,
    product_name, quantity,
    unit_price, subtotal
) VALUES
(1, 1, 1, 'Coca Cola 600ml', 1, 18.00, 18.00),
(2, 1, 2, 'Sabritas Original', 1, 15.00, 15.00),
(3, 2, 3, 'Leche Lala 1L', 2, 25.00, 50.00),
(4, 3, 5, 'Frijol Negro 1Kg', 1, 28.00, 28.00);

/* =====================
   FOLIO
   ===================== */
INSERT INTO folio (id_folio, sale_id, ticket_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

/* =====================
   HISTORIAL PERMANENTE
   ===================== */
INSERT INTO historial_permanente (
    id, folio, sale_id,
    ticket_id, user_id,
    total, payment_method
) VALUES
(1, 1, 1, 1, 2, 33.00, 'efectivo'),
(2, 2, 2, 2, 3, 50.00, 'efectivo'),
(3, 3, 3, 3, 4, 28.00, 'tarjeta');

/* =====================
   CFDI USES
   ===================== */
INSERT INTO cfdi_uses (id, code, name) VALUES
(1, 'G01', 'Adquisición de mercancías'),
(2, 'G03', 'Gastos en general');

/* =====================
   INVOICES
   ===================== */
INSERT INTO invoices (
    id, sale_id, client_id,
    user_id, cfdi_use_id,
    subtotal, tax_amount,
    total, status
) VALUES
(1, 1, 1, 1, 1, 28.45, 4.55, 33.00, 'timbrada'),
(2, 2, 2, 1, 2, 43.10, 6.90, 50.00, 'pendiente');

/* =====================
   INVOICE_ITEMS
   ===================== */
INSERT INTO invoice_items (
    id, invoice_id, product_id,
    product_name, quantity,
    unit_price, subtotal
) VALUES
(1, 1, 1, 'Coca Cola 600ml', 1, 18.00, 18.00),
(2, 1, 2, 'Sabritas Original', 1, 15.00, 15.00),
(3, 2, 3, 'Leche Lala 1L', 2, 25.00, 50.00);

/* =====================
   STAMPING LOGS
   ===================== */
INSERT INTO stamping_logs (
    id, invoice_id, action,
    status, user_id
) VALUES
(1, 1, 'timbrado', 'exitoso', 1),
(2, 2, 'timbrado', 'fallido', 1);

/* =====================
   INVOICE CANCELLATIONS (ejemplo opcional)
   ===================== */
/*
INSERT INTO invoice_cancellations (
    id, invoice_id, user_id, reason
) VALUES
(1, 1, 1, 'Cancelación de prueba');
*/
