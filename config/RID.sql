-- ============================================================
-- SISTEMA DE PUNTO DE VENTA
-- Base de Datos Completa_RID
-- ============================================================

CREATE DATABASE IF NOT EXISTS punto_venta
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE punto_venta;

-- ============================================================
-- MÓDULO DE USUARIOS
-- ============================================================

-- Tabla: roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL COMMENT 'Nombre del rol (Administrador / Empleado)',
    description TEXT COMMENT 'Descripción del rol y sus alcances',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name)
) ENGINE=InnoDB COMMENT='Define los tipos de rol disponibles';

-- Tabla: permissions
CREATE TABLE permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(80) NOT NULL COMMENT 'Nombre del permiso (ej: crear_producto)',
    module VARCHAR(50) COMMENT 'Módulo al que pertenece el permiso',
    description TEXT COMMENT 'Descripción de lo que permite hacer',
    INDEX idx_module (module)
) ENGINE=InnoDB COMMENT='Catálogo de permisos disponibles en el sistema';

-- Tabla: users
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE COMMENT 'Nombre de usuario único para login',
    name VARCHAR(50) NOT NULL COMMENT 'Nombre del usuario',
    last_name VARCHAR(50) NOT NULL COMMENT 'Apellidos del usuario',
    email VARCHAR(100) UNIQUE COMMENT 'Correo electrónico (requerido para Administrador)',
    password_hash VARCHAR(255) NOT NULL COMMENT 'Contraseña encriptada',
    role_id INT NOT NULL COMMENT 'Rol asignado al usuario',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Estado activo/inactivo de la cuenta',
    is_blocked BOOLEAN DEFAULT FALSE COMMENT 'Si la cuenta está bloqueada por intentos fallidos',
    blocked_until DATETIME COMMENT 'Fecha/hora hasta la cual está bloqueado',
    failed_attempts INT DEFAULT 0 COMMENT 'Contador de intentos fallidos consecutivos',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_users_role
        FOREIGN KEY (role_id) REFERENCES roles(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role_id)
) ENGINE=InnoDB COMMENT='Almacena los datos de cada usuario del sistema';

-- Tabla: role_permissions
CREATE TABLE role_permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL COMMENT 'Rol asociado',
    permission_id INT NOT NULL COMMENT 'Permiso asociado',
    
    CONSTRAINT fk_role_permissions_role
        FOREIGN KEY (role_id) REFERENCES roles(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_role_permissions_permission
        FOREIGN KEY (permission_id) REFERENCES permissions(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    UNIQUE KEY uq_role_permission (role_id, permission_id),
    INDEX idx_role (role_id),
    INDEX idx_permission (permission_id)
) ENGINE=InnoDB COMMENT='Relación N:M entre roles y permisos';

-- Tabla: user_roles
CREATE TABLE user_roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL COMMENT 'Usuario asociado',
    role_id INT NOT NULL COMMENT 'Rol asignado',
    assigned_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de asignación del rol',
    
    CONSTRAINT fk_user_roles_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_user_roles_role
        FOREIGN KEY (role_id) REFERENCES roles(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    UNIQUE KEY uq_user_role (user_id, role_id),
    INDEX idx_user (user_id),
    INDEX idx_role (role_id)
) ENGINE=InnoDB COMMENT='Asigna un rol único a cada usuario';

-- Tabla: activity_logs
CREATE TABLE activity_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL COMMENT 'Usuario que realizó la acción',
    action VARCHAR(100) NOT NULL COMMENT 'Acción realizada (crear, editar, eliminar, etc.)',
    module VARCHAR(50) COMMENT 'Módulo donde se realizó la acción',
    details TEXT COMMENT 'Detalles adicionales de la acción',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_activity_logs_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    INDEX idx_user (user_id),
    INDEX idx_module (module),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Registro de actividades realizadas por cada usuario (solo visible para Administrador)';

-- Tabla: sessions
CREATE TABLE sessions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL COMMENT 'Usuario de la sesión',
    token VARCHAR(255) NOT NULL COMMENT 'Token de sesión (JWT o similar)',
    last_activity DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Último momento de actividad del usuario',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha de inicio de sesión',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Si la sesión sigue activa',
    
    CONSTRAINT fk_sessions_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    INDEX idx_user (user_id),
    INDEX idx_token (token),
    INDEX idx_active (is_active)
) ENGINE=InnoDB COMMENT='Gestiona las sesiones activas (cierre automático tras 2 horas de inactividad)';


-- ============================================================
-- MÓDULO DE INVENTARIO
-- ============================================================

-- Tabla: categories
CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL COMMENT 'Nombre de la categoría',
    description TEXT COMMENT 'Descripción de la categoría',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_name (name)
) ENGINE=InnoDB COMMENT='Categorías para clasificar y filtrar productos';

-- Tabla: products
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ref_producto VARCHAR(50) NOT NULL UNIQUE COMMENT 'Referencia/clave única del producto (asignada por Admin)',
    etiqueta VARCHAR(150) NOT NULL COMMENT 'Etiqueta/nombre del producto',
    categoria_id INT COMMENT 'Categoría del producto',
    precio_venta DECIMAL(10,2) NOT NULL COMMENT 'Precio de venta del producto (IVA incluido)',
    mejor_precio_compra DECIMAL(10,2) COMMENT 'Mejor precio de compra registrado',
    stock_deseado INT DEFAULT 20 COMMENT 'Stock deseado/objetivo para el producto',
    stock_fisico INT DEFAULT 0 COMMENT 'Cantidad física disponible actual',
    estado_venta ENUM('En venta','Pausado') DEFAULT 'En venta' COMMENT 'Estado del producto para venta',
    estado_compra ENUM('En compra','Pausado') DEFAULT 'En compra' COMMENT 'Estado del producto para compra',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Si el producto está activo en el sistema',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_products_category
        FOREIGN KEY (categoria_id) REFERENCES categories(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    
    INDEX idx_ref (ref_producto),
    INDEX idx_etiqueta (etiqueta),
    INDEX idx_categoria (categoria_id),
    INDEX idx_stock (stock_fisico)
) ENGINE=InnoDB COMMENT='Almacena todos los productos del inventario';

-- Tabla: clients
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL COMMENT 'Nombre completo o razón social',
    rfc VARCHAR(20) COMMENT 'RFC del cliente (requerido para facturación)',
    email VARCHAR(100) COMMENT 'Correo electrónico',
    phone VARCHAR(20) COMMENT 'Teléfono de contacto',
    address TEXT COMMENT 'Dirección del cliente',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (name),
    INDEX idx_rfc (rfc)
) ENGINE=InnoDB COMMENT='Base de datos de clientes para reutilizar en ventas y facturas';

-- Tabla: sales
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL COMMENT 'Empleado que realizó la venta',
    client_id INT COMMENT 'Cliente asociado (nullable)',
    total DECIMAL(10,2) NOT NULL DEFAULT 0.00 COMMENT 'Total de la venta',
    payment_method ENUM('efectivo','transferencia','tarjeta') NOT NULL COMMENT 'Método de pago',
    cash_received DECIMAL(10,2) COMMENT 'Monto recibido en efectivo (si aplica)',
    change_given DECIMAL(10,2) COMMENT 'Cambio devuelto',
    payment_reference VARCHAR(100) COMMENT 'Código/referencia de pago',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_sales_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_sales_client
        FOREIGN KEY (client_id) REFERENCES clients(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    
    INDEX idx_user (user_id),
    INDEX idx_client (client_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Registra cada transacción de venta completa';

-- Tabla: sale_items
CREATE TABLE sale_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL COMMENT 'Venta a la que pertenece',
    product_id INT NOT NULL COMMENT 'Producto vendido',
    quantity INT NOT NULL COMMENT 'Cantidad vendida',
    unit_price DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario al momento de venta',
    subtotal DECIMAL(10,2) NOT NULL COMMENT 'Subtotal (cantidad × precio)',
    
    CONSTRAINT fk_sale_items_sale
        FOREIGN KEY (sale_id) REFERENCES sales(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_sale_items_product
        FOREIGN KEY (product_id) REFERENCES products(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_sale (sale_id),
    INDEX idx_product (product_id)
) ENGINE=InnoDB COMMENT='Detalle de productos vendidos en cada venta';

-- Tabla: inventory_movements
CREATE TABLE inventory_movements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL COMMENT 'Producto involucrado',
    user_id INT NOT NULL COMMENT 'Usuario que realizó el movimiento',
    movement_type ENUM('entrada','salida') NOT NULL COMMENT 'Tipo de movimiento',
    reason ENUM('compra','devolución','venta','eliminación','devolución_proveedor') NOT NULL COMMENT 'Motivo del movimiento',
    quantity INT NOT NULL COMMENT 'Cantidad movida',
    support_document VARCHAR(255) COMMENT 'Ruta/referencia del documento de soporte (opcional)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_inventory_movements_product
        FOREIGN KEY (product_id) REFERENCES products(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_inventory_movements_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_product (product_id),
    INDEX idx_user (user_id),
    INDEX idx_type (movement_type),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Historial completo de entradas y salidas de inventario';


-- ============================================================
-- MÓDULO DE TICKETS
-- ============================================================

-- Tabla: tickets
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_number VARCHAR(30) NOT NULL UNIQUE COMMENT 'Número único e irrepetible del ticket',
    sale_id INT NOT NULL COMMENT 'Venta asociada al ticket',
    user_id INT NOT NULL COMMENT 'Usuario que generó el ticket', 
    company_name VARCHAR(100) DEFAULT 'RUEDAS INDUSTRIALES DURANGO' COMMENT 'Nombre comercial de la empresa',
    company_phone VARCHAR(20) DEFAULT '618 218 8982' COMMENT 'Número de contacto de la empresa',
    company_logo_path VARCHAR(255) DEFAULT '/images/logo-b_w.png' COMMENT 'Ruta de la imagen del logotipo',
    commercial_message TEXT DEFAULT '*** GRACIAS POR SU PREFERENCIA ***' COMMENT 'Mensaje comercial configurable',
    printed_at DATETIME COMMENT 'Fecha/hora de impresión (nullable si no se ha imprimido)',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_tickets_sale
        FOREIGN KEY (sale_id) REFERENCES sales(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_tickets_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_ticket_number (ticket_number),
    INDEX idx_sale (sale_id),
    INDEX idx_user (user_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Almacena cada ticket de venta generado';

-- Tabla: ticket_items
CREATE TABLE ticket_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id INT NOT NULL COMMENT 'Ticket al que pertenece',
    product_id INT NOT NULL COMMENT 'Producto asociado',
    product_name VARCHAR(150) NOT NULL COMMENT 'Nombre del producto al momento de la venta',
    description TEXT COMMENT 'Descripción breve del producto',
    quantity INT NOT NULL COMMENT 'Cantidad vendida',
    unit_price DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario',
    subtotal DECIMAL(10,2) NOT NULL COMMENT 'Subtotal del item',
    
    CONSTRAINT fk_ticket_items_ticket
        FOREIGN KEY (ticket_id) REFERENCES tickets(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_ticket_items_product
        FOREIGN KEY (product_id) REFERENCES products(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_ticket (ticket_id),
    INDEX idx_product (product_id)
) ENGINE=InnoDB COMMENT='Detalle de productos en cada ticket';

-- Tabla: folio (SE RESETEA DIARIAMENTE)
CREATE TABLE folio (
    id_folio INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL UNIQUE COMMENT 'Venta asociada',
    ticket_id INT NOT NULL UNIQUE COMMENT 'Ticket generado',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_folio_sale
        FOREIGN KEY (sale_id) REFERENCES sales(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_folio_ticket
        FOREIGN KEY (ticket_id) REFERENCES tickets(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    INDEX idx_sale (sale_id),
    INDEX idx_ticket (ticket_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Tabla de folios del día (se resetea diariamente con TRUNCATE)';

-- Tabla: historial_permanente (NUNCA SE BORRA)
CREATE TABLE historial_permanente (
    id INT AUTO_INCREMENT PRIMARY KEY,
    folio INT NOT NULL COMMENT 'Número de folio que tuvo ese día',
    sale_id INT NOT NULL COMMENT 'Venta asociada',
    ticket_id INT NOT NULL COMMENT 'Ticket asociado',
    user_id INT NOT NULL COMMENT 'Usuario que generó',
    total DECIMAL(10,2) NOT NULL COMMENT 'Total de la venta (copia para historial)',
    payment_method VARCHAR(20) NOT NULL COMMENT 'Método de pago usado',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_historial_sale
        FOREIGN KEY (sale_id) REFERENCES sales(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_historial_ticket
        FOREIGN KEY (ticket_id) REFERENCES tickets(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_historial_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_folio (folio),
    INDEX idx_sale (sale_id),
    INDEX idx_ticket (ticket_id),
    INDEX idx_user (user_id),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Historial permanente de todos los tickets (nunca se borra)';


-- ============================================================
-- MÓDULO DE FACTURAS (SAT)
-- ============================================================

-- Tabla: cfdi_uses
CREATE TABLE cfdi_uses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(10) NOT NULL COMMENT 'Código del uso CFDI (ej: G01)',
    name VARCHAR(100) NOT NULL COMMENT 'Nombre descriptivo',
    is_active BOOLEAN DEFAULT TRUE COMMENT 'Si está activo',
    INDEX idx_code (code)
) ENGINE=InnoDB COMMENT='Catálogo de usos de CFDI del SAT (ID y nombre)';

-- Tabla: invoices
CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT NOT NULL UNIQUE COMMENT 'Venta asociada (1 factura por venta)',
    client_id INT NOT NULL COMMENT 'Cliente de la factura',
    user_id INT NOT NULL COMMENT 'Usuario que generó la factura',
    cfdi_use_id INT NOT NULL COMMENT 'Uso del CFDI seleccionado',
    payment_method ENUM('contado','plazo') DEFAULT 'contado' COMMENT 'Forma de pago',
    subtotal DECIMAL(10,2) NOT NULL COMMENT 'Subtotal sin IVA',
    tax_amount DECIMAL(10,2) NOT NULL COMMENT 'Monto de IVA',
    total DECIMAL(10,2) NOT NULL COMMENT 'Total de la factura',
    status ENUM('pendiente','timbrada','cancelada','error') DEFAULT 'pendiente' COMMENT 'Estado actual',
    uuid VARCHAR(50) COMMENT 'UUID del SAT tras timbrado',
    xml_path VARCHAR(255) COMMENT 'Ruta del XML generado',
    pdf_path VARCHAR(255) COMMENT 'Ruta del PDF generado',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    CONSTRAINT fk_invoices_sale
        FOREIGN KEY (sale_id) REFERENCES sales(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_invoices_client
        FOREIGN KEY (client_id) REFERENCES clients(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_invoices_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_invoices_cfdi_use
        FOREIGN KEY (cfdi_use_id) REFERENCES cfdi_uses(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_sale (sale_id),
    INDEX idx_client (client_id),
    INDEX idx_user (user_id),
    INDEX idx_status (status),
    INDEX idx_uuid (uuid),
    INDEX idx_created (created_at)
) ENGINE=InnoDB COMMENT='Facturas CFDI generadas';

-- Tabla: invoice_items
CREATE TABLE invoice_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL COMMENT 'Factura a la que pertenece',
    product_id INT NOT NULL COMMENT 'Producto asociado',
    product_name VARCHAR(150) NOT NULL COMMENT 'Nombre del producto',
    description TEXT COMMENT 'Descripción del concepto',
    quantity INT NOT NULL COMMENT 'Cantidad',
    unit_price DECIMAL(10,2) NOT NULL COMMENT 'Precio unitario',
    subtotal DECIMAL(10,2) NOT NULL COMMENT 'Subtotal del concepto',
    
    CONSTRAINT fk_invoice_items_invoice
        FOREIGN KEY (invoice_id) REFERENCES invoices(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_invoice_items_product
        FOREIGN KEY (product_id) REFERENCES products(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_invoice (invoice_id),
    INDEX idx_product (product_id)
) ENGINE=InnoDB COMMENT='Conceptos/productos dentro de cada factura';

-- Tabla: stamping_logs
CREATE TABLE stamping_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL COMMENT 'Factura involucrada',
    action ENUM('timbrado','cancelación') NOT NULL COMMENT 'Tipo de acción',
    status ENUM('exitoso','fallido') NOT NULL COMMENT 'Resultado',
    error_code VARCHAR(50) COMMENT 'Código de error del PAC',
    error_message TEXT COMMENT 'Mensaje de error',
    response_xml TEXT COMMENT 'Respuesta XML del PAC',
    attempted_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha/hora del intento',
    user_id INT NOT NULL COMMENT 'Usuario que inició la acción',
    
    CONSTRAINT fk_stamping_logs_invoice
        FOREIGN KEY (invoice_id) REFERENCES invoices(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_stamping_logs_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_invoice (invoice_id),
    INDEX idx_user (user_id),
    INDEX idx_status (status),
    INDEX idx_attempted (attempted_at)
) ENGINE=InnoDB COMMENT='Logs de timbrado y cancelación con el PAC/SAT';

-- Tabla: invoice_cancellations
CREATE TABLE invoice_cancellations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT NOT NULL UNIQUE COMMENT 'Factura cancelada',
    user_id INT NOT NULL COMMENT 'Usuario que canceló',
    reason TEXT COMMENT 'Motivo de cancelación',
    cancelled_at DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Fecha/hora de cancelación',
    
    CONSTRAINT fk_invoice_cancellations_invoice
        FOREIGN KEY (invoice_id) REFERENCES invoices(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    CONSTRAINT fk_invoice_cancellations_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    
    INDEX idx_invoice (invoice_id),
    INDEX idx_user (user_id),
    INDEX idx_cancelled (cancelled_at)
) ENGINE=InnoDB COMMENT='Registro de cancelaciones de facturas';


-- =================
-- DATOS 
-- =================



-- ============================================================
-- NOTAS IMPORTANTES
-- ============================================================
-- 1. La tabla 'folio' se debe TRUNCAR al final de cada día:
--    TRUNCATE TABLE folio;
--    Esto resetea el auto_increment para empezar en 1 al día siguiente.
--
-- 2. La tabla 'historial_permanente' NUNCA se borra, solo crece.
--
-- 3. Las contraseñas en 'users' están hasheadas con bcrypt.
--    Password de ejemplo para todos: "password123"
--
-- 4. Trigger ON UPDATE puede ser implementado posteriormente
--    para sincronizar datos entre tablas automáticamente.
--
-- 5. Las sesiones inactivas por más de 2 horas deben ser
--    limpiadas periódicamente con un script o cron job, en platicas.
-- ============================================================