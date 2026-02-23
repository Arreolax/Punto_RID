-- ================================
-- ROLES
-- ================================
INSERT INTO roles (id, name, description) VALUES
(1,'Administrador','Acceso total al sistema'),
(2,'Empleado','Acceso limitado a ventas'),
(3,'Cajero','Solo módulo de ventas'),
(4,'Almacenista','Gestión de inventario'),
(5,'Supervisor','Supervisa operaciones'),
(6,'Gerente','Control general del negocio'),
(7,'Soporte','Soporte técnico'),
(8,'Auditor','Solo lectura de reportes'),
(9,'Facturación','Acceso a facturación SAT'),
(10,'Invitado','Acceso mínimo');

-- ================================
-- PERMISSIONS
-- ================================
INSERT INTO permissions (id,name,module,description) VALUES
(1,'crear_producto','inventario','Permite crear productos'),
(2,'editar_producto','inventario','Permite editar productos'),
(3,'eliminar_producto','inventario','Permite eliminar productos'),
(4,'ver_reportes','reportes','Permite ver reportes'),
(5,'crear_venta','ventas','Permite registrar ventas'),
(6,'cancelar_venta','ventas','Permite cancelar ventas'),
(7,'gestionar_usuarios','usuarios','Administra usuarios'),
(8,'generar_factura','facturacion','Permite generar facturas'),
(9,'cancelar_factura','facturacion','Permite cancelar facturas'),
(10,'ver_logs','sistema','Ver registros del sistema');

-- ================================
-- USERS
-- ================================
INSERT INTO users (id,username, name, last_name,email,password_hash,role_id,is_active,is_blocked,failed_attempts) VALUES
(1,'admin', 'Administrador', 'General', 'admin@ferreteria.com','$2y$10$hash',1,1,0,0),
(2, 'empleado1', 'Juan', 'Pérez', 'juan@ferreteria.com','$2y$10$hash',2,1,0,0),
(3, 'empleado2', 'Ana', 'Gómez', 'ana.gomez@sistema.com','$2y$10$hash',3,1,0,0),
(4, 'empleado3', 'Luis', 'Martínez', 'luis.martinez@sistema.com','$2y$10$hash',4,1,0,0),
(5, 'cajero1', 'María', 'López', 'maria.lopez@sistema.com','$2y$10$hash',5,1,0,0),
(6, 'cajero2', 'Pedro', 'Hernández', 'pedro.hernandez@sistema.com','$2y$10$hash',2,1,0,0),
(7, 'almacen1', 'Carlos', 'Ramírez', 'carlos.ramirez@sistema.com','$2y$10$hash',7,1,0,0),
(8, 'almacen2', 'Sofía', 'Torres', 'sofia.torres@sistema.com','$2y$10$hash',8,1,0,0),
(9, 'empleado4', 'Diego', 'Flores', 'diego.flores@sistema.com','$2y$10$hash',9,1,0,0),
(10, 'cajero3', 'Laura', 'Castillo','laura.castillo@sistema.com','$2y$10$hash',10,1,0,0);

-- ================================
-- ROLE_PERMISSIONS
-- ================================
INSERT INTO role_permissions (id,role_id,permission_id) VALUES
(1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),
(6,2,5),(7,3,5),(8,4,1),(9,9,8),(10,1,10);

-- ================================
-- USER_ROLES
-- ================================
INSERT INTO user_roles (id,user_id,role_id) VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),
(6,6,2),(7,7,7),(8,8,8),(9,9,9),(10,10,10);

-- ================================
-- ACTIVITY_LOGS
-- ================================
INSERT INTO activity_logs (id,user_id,action,module,details) VALUES
(1,1,'crear','usuarios','Creó usuario Juan'),
(2,2,'crear','ventas','Venta mostrador'),
(3,3,'crear','ventas','Venta efectivo'),
(4,4,'editar','inventario','Actualizó stock'),
(5,5,'ver','reportes','Reporte mensual'),
(6,1,'crear','inventario','Nuevo producto'),
(7,9,'crear','facturacion','Factura generada'),
(8,2,'cancelar','ventas','Venta cancelada'),
(9,8,'ver','reportes','Auditoría'),
(10,7,'editar','sistema','Configuración');

-- ================================
-- SESSIONS
-- ================================
INSERT INTO sessions (id,user_id,token,is_active) VALUES
(1,1,'token1',1),
(2,2,'token2',1),
(3,3,'token3',1),
(4,4,'token4',1),
(5,5,'token5',1),
(6,6,'token6',1),
(7,7,'token7',1),
(8,8,'token8',1),
(9,9,'token9',1),
(10,10,'token10',1);

-- ================================
-- CATEGORIES
-- ================================
INSERT INTO categories (id,name,description) VALUES
(1,'Herramientas Manuales','Martillos, llaves, desarmadores'),
(2,'Herramientas Eléctricas','Taladros y esmeriles'),
(3,'Plomería','Tuberías y conexiones'),
(4,'Electricidad','Cables y apagadores'),
(5,'Pintura','Brochas y rodillos'),
(6,'Tornillería','Tornillos y taquetes'),
(7,'Construcción','Cemento y arena'),
(8,'Seguridad','Guantes y cascos'),
(9,'Jardinería','Mangueras y palas'),
(10,'Adhesivos','Silicones y pegamentos');

-- ================================
-- PRODUCTS
-- ================================
INSERT INTO products (id,ref_producto,etiqueta,categoria_id,precio_venta,mejor_precio_compra,stock_deseado,stock_fisico) VALUES
(1,'REF001','Martillo 16oz',1,150.00,90.00,20,35),
(2,'REF002','Taladro 1/2',2,1200.00,850.00,10,15),
(3,'REF003','Llave Stilson 14"',1,320.00,200.00,15,20),
(4,'REF004','Cable THW 100m',4,950.00,700.00,8,12),
(5,'REF005','Tubo PVC 1/2"',3,85.00,50.00,50,100),
(6,'REF006','Brocha 3"',5,45.00,20.00,40,60),
(7,'REF007','Caja Tornillos 1"',6,120.00,70.00,30,45),
(8,'REF008','Cemento 50kg',7,210.00,160.00,100,150),
(9,'REF009','Guantes Carnaza',8,95.00,60.00,25,40),
(10,'REF010','Silicón Transparente',10,70.00,40.00,30,55);

-- ================================
-- CLIENTS
-- ================================
INSERT INTO clients (id,name,rfc,email,phone,address) VALUES
(1,'Constructora Durango','CDU010203AB1','contacto@cdu.com','6181111111','Durango'),
(2,'Juan Pérez','JUAP900101AA1','juan@mail.com','6182222222','Durango'),
(3,'María López','MALO920202BB2','maria@mail.com','6183333333','Durango'),
(4,'Taller El Tornillo','TET800303CC3','taller@mail.com','6184444444','Durango'),
(5,'Pedro Ramírez','PERA850404DD4','pedro@mail.com','6185555555','Durango'),
(6,'Ferre Norte','FEN700505EE5','norte@mail.com','6186666666','Durango'),
(7,'Electricos SA','ELE600606FF6','elec@mail.com','6187777777','Durango'),
(8,'Plomería López','PLO500707GG7','plom@mail.com','6188888888','Durango'),
(9,'Carpintería Ruiz','CAR400808HH8','carp@mail.com','6189999999','Durango'),
(10,'Jardines MX','JMX300909II9','jard@mail.com','6181010101','Durango');

-- ================================
-- SALES
-- ================================
INSERT INTO sales (id,user_id,client_id,total,payment_method,cash_received,change_given) VALUES
(1,2,2,440.00,'efectivo',500.00,60.00),
(2,3,3,1365.00,'tarjeta',NULL,NULL),
(3,2,1,1090.00,'transferencia',NULL,NULL),
(4,3,4,195.00,'efectivo',200.00,5.00),
(5,2,5,330.00,'efectivo',400.00,70.00),
(6,3,6,130.00,'tarjeta',NULL,NULL),
(7,2,7,415.00,'efectivo',500.00,85.00),
(8,3,8,115.00,'transferencia',NULL,NULL),
(9,2,9,140.00,'efectivo',200.00,60.00),
(10,3,10,140.00,'efectivo',200.00,60.00);

-- ================================
-- SALE_ITEMS
-- ================================
INSERT INTO sale_items (id,sale_id,product_id,quantity,unit_price,subtotal) VALUES

-- Venta 1 (3 productos)
(1,1,1,2,150.00,300.00),
(2,1,6,1,45.00,45.00),
(3,1,9,1,95.00,95.00),

-- Venta 2 (3 productos)
(4,2,2,1,1200.00,1200.00),
(5,2,7,1,120.00,120.00),
(6,2,6,1,45.00,45.00),

-- Venta 3 (3 productos)
(7,3,4,1,950.00,950.00),
(8,3,9,1,95.00,95.00),
(9,3,6,1,45.00,45.00),

-- Venta 4 (2 productos)
(10,4,1,1,150.00,150.00),
(11,4,6,1,45.00,45.00),

-- Venta 5 (2 productos)
(12,5,8,1,210.00,210.00),
(13,5,7,1,120.00,120.00),

-- Venta 6 (2 productos)
(14,6,5,1,85.00,85.00),
(15,6,6,1,45.00,45.00),

-- Venta 7 (2 productos)
(16,7,3,1,320.00,320.00),
(17,7,9,1,95.00,95.00),

-- Venta 8 (2 productos)
(18,8,10,1,70.00,70.00),
(19,8,6,1,45.00,45.00),

-- Venta 9 (2 productos)
(20,9,9,1,95.00,95.00),
(21,9,6,1,45.00,45.00),

-- Venta 10 (2 productos)
(22,10,6,1,45.00,45.00),
(23,10,9,1,95.00,95.00);

-- ================================
-- INVENTORY_MOVEMENTS
-- ================================
INSERT INTO inventory_movements (id,product_id,user_id,movement_type,reason,quantity,support_document) VALUES
(1,1,4,'entrada','compra',50,'FAC-001'),
(2,2,4,'entrada','compra',20,'FAC-002'),
(3,3,4,'entrada','compra',30,'FAC-003'),
(4,4,4,'entrada','compra',15,'FAC-004'),
(5,5,4,'entrada','compra',120,'FAC-005'),
(6,6,4,'entrada','compra',80,'FAC-006'),
(7,7,4,'entrada','compra',60,'FAC-007'),
(8,8,4,'entrada','compra',200,'FAC-008'),
(9,9,4,'entrada','compra',50,'FAC-009'),
(10,10,4,'entrada','compra',70,'FAC-010');

-- ================================
-- TICKETS
-- ================================
INSERT INTO tickets (id,ticket_number,sale_id,user_id) VALUES
(1,'TCK-0001',1,2),
(2,'TCK-0002',2,3),
(3,'TCK-0003',3,2),
(4,'TCK-0004',4,3),
(5,'TCK-0005',5,2),
(6,'TCK-0006',6,3),
(7,'TCK-0007',7,2),
(8,'TCK-0008',8,3),
(9,'TCK-0009',9,2),
(10,'TCK-0010',10,3);

-- ================================
-- TICKET_ITEMS
-- ================================
INSERT INTO ticket_items
(id, ticket_id, product_id, product_name, description, quantity, unit_price, subtotal)
VALUES

-- Ticket 1
(1,1,1,'Martillo 16oz','Martillo acero',2,150.00,300.00),
(2,1,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),
(3,1,9,'Guantes Carnaza','Guantes de seguridad',1,95.00,95.00),

-- Ticket 2
(4,2,2,'Taladro 1/2','Taladro eléctrico',1,1200.00,1200.00),
(5,2,7,'Caja Tornillos 1"','Caja tornillos acero',1,120.00,120.00),
(6,2,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),

-- Ticket 3
(7,3,4,'Cable THW 100m','Cable eléctrico',1,950.00,950.00),
(8,3,9,'Guantes Carnaza','Guantes de seguridad',1,95.00,95.00),
(9,3,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),

-- Ticket 4
(10,4,1,'Martillo 16oz','Martillo acero',1,150.00,150.00),
(11,4,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),

-- Ticket 5
(12,5,8,'Cemento 50kg','Saco cemento',1,210.00,210.00),
(13,5,7,'Caja Tornillos 1"','Caja tornillos acero',1,120.00,120.00),

-- Ticket 6
(14,6,5,'Tubo PVC 1/2','Tubo hidráulico',1,85.00,85.00),
(15,6,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),

-- Ticket 7
(16,7,3,'Llave Stilson 14"','Llave ajustable',1,320.00,320.00),
(17,7,9,'Guantes Carnaza','Guantes de seguridad',1,95.00,95.00),

-- Ticket 8
(18,8,10,'Silicón Transparente','Silicón uso general',1,70.00,70.00),
(19,8,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),

-- Ticket 9
(20,9,9,'Guantes Carnaza','Guantes de seguridad',1,95.00,95.00),
(21,9,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),

-- Ticket 10
(22,10,6,'Brocha 3"','Brocha para pintura',1,45.00,45.00),
(23,10,9,'Guantes Carnaza','Guantes de seguridad',1,95.00,95.00);

-- ================================
-- FOLIO
-- ================================
INSERT INTO folio (id_folio,sale_id,ticket_id) VALUES
(1,1,1),(2,2,2),(3,3,3),(4,4,4),(5,5,5),
(6,6,6),(7,7,7),(8,8,8),(9,9,9),(10,10,10);

-- ================================
-- HISTORIAL_PERMANENTE
-- ================================
INSERT INTO historial_permanente (id,folio,sale_id,ticket_id,user_id,total,payment_method) VALUES
(1,1,1,1,2,300.00,'efectivo'),
(2,2,2,2,3,1200.00,'tarjeta'),
(3,3,3,3,2,950.00,'transferencia'),
(4,4,4,4,3,150.00,'efectivo'),
(5,5,5,5,2,210.00,'efectivo'),
(6,6,6,6,3,85.00,'tarjeta'),
(7,7,7,7,2,320.00,'efectivo'),
(8,8,8,8,3,70.00,'transferencia'),
(9,9,9,9,2,95.00,'efectivo'),
(10,10,10,10,3,45.00,'efectivo');

-- ================================
-- CFDI_USES
-- ================================
INSERT INTO cfdi_uses (id,code,name,is_active) VALUES
(1,'G01','Adquisición de mercancías',1),
(2,'G02','Devoluciones, descuentos',1),
(3,'G03','Gastos en general',1),
(4,'I01','Construcciones',1),
(5,'I02','Mobiliario y equipo',1),
(6,'I03','Equipo de transporte',1),
(7,'I04','Equipo de cómputo',1),
(8,'D01','Honorarios médicos',1),
(9,'D02','Gastos médicos',1),
(10,'P01','Por definir',1);

-- ================================
-- INVOICES
-- ================================
INSERT INTO invoices (id,sale_id,client_id,user_id,cfdi_use_id,subtotal,tax_amount,total,status,uuid,xml_path,pdf_path) VALUES
(1,1,2,9,1,258.62,41.38,300.00,'timbrada','UUID-001','/xml/1.xml','/pdf/1.pdf'),
(2,2,3,9,1,1034.48,165.52,1200.00,'timbrada','UUID-002','/xml/2.xml','/pdf/2.pdf'),
(3,3,1,9,3,818.97,131.03,950.00,'timbrada','UUID-003','/xml/3.xml','/pdf/3.pdf'),
(4,4,4,9,3,129.31,20.69,150.00,'timbrada','UUID-004','/xml/4.xml','/pdf/4.pdf'),
(5,5,5,9,3,181.03,28.97,210.00,'timbrada','UUID-005','/xml/5.xml','/pdf/5.pdf'),
(6,6,6,9,3,73.28,11.72,85.00,'timbrada','UUID-006','/xml/6.xml','/pdf/6.pdf'),
(7,7,7,9,1,275.86,44.14,320.00,'timbrada','UUID-007','/xml/7.xml','/pdf/7.pdf'),
(8,8,8,9,3,60.34,9.66,70.00,'timbrada','UUID-008','/xml/8.xml','/pdf/8.pdf'),
(9,9,9,9,3,81.90,13.10,95.00,'timbrada','UUID-009','/xml/9.xml','/pdf/9.pdf'),
(10,10,10,9,3,38.79,6.21,45.00,'timbrada','UUID-010','/xml/10.xml','/pdf/10.pdf');

-- ================================
-- INVOICE_ITEMS
-- ================================
INSERT INTO invoice_items (id,invoice_id,product_id,product_name,description,quantity,unit_price,subtotal) VALUES
(1,1,1,'Martillo 16oz','Martillo acero',2,129.31,258.62),
(2,2,2,'Taladro 1/2','Taladro eléctrico',1,1034.48,1034.48),
(3,3,4,'Cable THW 100m','Cable eléctrico',1,818.97,818.97),
(4,4,1,'Martillo 16oz','Martillo acero',1,129.31,129.31),
(5,5,8,'Cemento 50kg','Saco cemento',1,181.03,181.03),
(6,6,5,'Tubo PVC 1/2','Tubo hidráulico',1,73.28,73.28),
(7,7,3,'Llave Stilson 14','Llave ajustable',1,275.86,275.86),
(8,8,10,'Silicón Transparente','Silicón uso general',1,60.34,60.34),
(9,9,9,'Guantes Carnaza','Guantes de seguridad',1,81.90,81.90),
(10,10,6,'Brocha 3','Brocha pintura',1,38.79,38.79);

-- ================================
-- STAMPING_LOGS
-- ================================
INSERT INTO stamping_logs (id,invoice_id,action,status,user_id) VALUES
(1,1,'timbrado','exitoso',9),
(2,2,'timbrado','exitoso',9),
(3,3,'timbrado','exitoso',9),
(4,4,'timbrado','exitoso',9),
(5,5,'timbrado','exitoso',9),
(6,6,'timbrado','exitoso',9),
(7,7,'timbrado','exitoso',9),
(8,8,'timbrado','exitoso',9),
(9,9,'timbrado','exitoso',9),
(10,10,'timbrado','exitoso',9);

-- ================================
-- INVOICE_CANCELLATIONS
-- ================================
INSERT INTO invoice_cancellations (id,invoice_id,user_id,reason) VALUES
(1,10,9,'Error en datos del cliente');