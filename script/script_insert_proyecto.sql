-- =========================
-- Lote de datos del proyecto
-- =========================

-- Métodos de pago
INSERT INTO metodo_pago (metodo_pago_id, descripcion_metodo_pago) VALUES
(1, 'Efectivo'),
(2, 'Tarjeta de Crédito'),
(3, 'Transferencia'),
(4, 'Mercado Pago');

-- Perfiles
INSERT INTO perfil (perfil_id, tipo_perfil) VALUES
(1, 'Administrador'),
(2, 'Cliente');

-- Talles
INSERT INTO talle (talle_id, descripcion_talle) VALUES
(1, 'S'),
(2, 'M'),
(3, 'L'),
(4, 'XL');

-- Tipos de producto
INSERT INTO tipo (tipo_id, nombre_tipo) VALUES
(1, 'Remeras'),
(2, 'Pantalones');

-- Marcas
INSERT INTO marca (nombre_marca) VALUES
('Nike'),
('Adidas'),
('Puma'),
('Reebok'),
('Under Armour'),
('Fila'),
('Converse');

-- Estados de producto
INSERT INTO estado (estado_id, descripcion_estado) VALUES
(1, 'Disponible'),
(2, 'No disponible');

-- Categorías
INSERT INTO categoria (categoria_id, nombre_categoria) VALUES
(1, 'Hombre'),
(2, 'Mujer');

-- Países
INSERT INTO pais (pais_nombre) VALUES
('Argentina'),
('Brasil'),
('Chile'),
('Uruguay'),
('Paraguay'),
('Bolivia');

-- Provincias
INSERT INTO provincia (provincia_nombre, pais_id) VALUES
('Corrientes', 1),	   -- Argentina
('Buenos Aires', 1),   -- Argentina
('São Paulo', 3),      -- Brasil
('Santiago', 4),       -- Chile
('Montevideo', 5),     -- Uruguay
('Asunción', 6),       -- Paraguay
('La Paz', 7);         -- Bolivia

-- Ciudades
INSERT INTO ciudad (ciudad_nombre, provincia_id) VALUES
('Corrientes Capital', 1),   -- Corrientes (Argentina)
('La Plata', 2),             -- Buenos Aires (Argentina)
('Córdoba Capital', 3),      -- Córdoba (Argentina)
('Rosario', 4),              -- Santa Fe (Argentina)
('Mendoza Capital', 5),      -- Mendoza (Argentina)
('Salta Capital', 6),        -- Salta (Argentina)
('Posadas', 7),              -- Misiones (Argentina)
('São Paulo', 8),            -- São Paulo (Brasil)
('Santiago de Chile', 9),    -- Santiago (Chile)
('Montevideo', 10),          -- Montevideo (Uruguay)
('Asunción', 11),            -- Asunción (Paraguay)
('La Paz', 12);              -- La Paz (Bolivia)

-- Domicilios de proveedores
INSERT INTO domicilio (altura, calle, ciudad_id) VALUES
(100, 'Av. Independencia', 1),  -- Corrientes Capital
(200, 'Calle 9 de Julio', 2),   -- La Plata
(300, 'Av. Colón', 3),          -- Córdoba Capital
(400, 'Bv. Oroño', 4);          -- Rosario

-- Proveedores
INSERT INTO proveedor (proveedor_nombre, domicilio_id) VALUES
('Deportes Global', 1),
('SportMax Distribuidora', 2),
('Atletas Proveedor', 3),
('UrbanFit Supply', 4);

-- Productos (20 registros)
INSERT INTO producto (precio_unitario, descripcion, tipo_id, marca_id, estado_id, categoria_id, proveedor_id) VALUES
(12000.00, 'Remera deportiva algodón', 1, 2, 1, 2, 1),
(9500.00, 'Short deportivo liviano', 1, 1, 1, 2, 2),
(8000.00, 'Musculosa running hombre', 1, 3, 1, 1, 3),
(11000.00, 'Pantalón deportivo frisa', 1, 2, 1, 2, 4),
(9000.00, 'Remera dry-fit entrenamiento', 1, 1, 1, 1, 1),
(9800.00, 'Camiseta fútbol oficial', 1, 2, 1, 1, 1),
(8700.00, 'Short de básquet', 1, 3, 1, 1, 2),
(10200.00, 'Remera manga larga running', 1, 1, 1, 2, 3),
(11500.00, 'Pantalón térmico entrenamiento', 1, 2, 1, 1, 4),
(9400.00, 'Musculosa dry-fit mujer', 1, 3, 1, 2, 1),
(10000.00, 'Remera entrenamiento manga corta', 1, 1, 1, 2, 2),
(10800.00, 'Pantalón deportivo slim', 1, 2, 1, 2, 3),
(9200.00, 'Short running mujer', 1, 3, 1, 2, 4),
(9700.00, 'Remera técnica compresión', 1, 1, 1, 1, 1),
(8900.00, 'Musculosa entrenamiento liviana', 1, 2, 1, 2, 2),
(11200.00, 'Pantalón deportivo clásico', 1, 3, 1, 2, 3),
(9500.00, 'Remera básica algodón', 1, 1, 1, 2, 4),
(8800.00, 'Short training con bolsillos', 1, 2, 1, 2, 1),
(10400.00, 'Remera dry-fit manga larga', 1, 3, 1, 1, 2),
(11800.00, 'Jogging deportivo liviano', 1, 1, 1, 2, 3);


-- Stock por talle 
INSERT INTO stock_talle (stock, talle_id, producto_id) VALUES
-- Producto 1: Remera deportiva algodón
(12, 1, 1),
(18, 2, 1),
(10, 3, 1),

-- Producto 2: Short deportivo liviano
(8, 1, 2),
(15, 2, 2),
(12, 3, 2),
(4, 4, 2),

-- Producto 3: Musculosa running hombre
(10, 1, 3),
(9, 3, 3),

-- Producto 4: Pantalón deportivo frisa
(6, 1, 4),
(10, 3, 4),

-- Producto 5: Remera dry-fit entrenamiento
(11, 1, 5),
(16, 2, 5),
(8, 4, 2),

-- Producto 6: Camiseta fútbol oficial
(9, 1, 6),
(14, 2, 6),
(11, 3, 6),

-- Producto 7: Short de básquet
(12, 2, 7),
(2, 4, 2),

-- Producto 8: Remera manga larga running
(10, 1, 8),
(15, 2, 8),
(12, 3, 8),

-- Producto 9: Pantalón térmico entrenamiento
(10, 2, 9),
(8, 3, 9),

-- Producto 10: Musculosa dry-fit mujer
(12, 1, 10),
(18, 2, 10),
(14, 3, 10),

-- Producto 11: Remera entrenamiento manga corta
(7, 2, 11),
(10, 3, 11),
(3, 4, 2),

-- Producto 12: Pantalón deportivo slim
(6, 1, 12),
(12, 2, 12),
(9, 3, 12),

-- Producto 13: Short running mujer
(8, 1, 13),
(14, 2, 13),
(11, 3, 13),

-- Producto 14: Remera técnica compresión
(10, 1, 14),
(12, 3, 14),

-- Producto 15: Musculosa entrenamiento liviana
(9, 1, 15),
(13, 2, 15),
(10, 3, 15),

-- Producto 16: Pantalón deportivo clásico
(7, 1, 16),
(11, 2, 16),

-- Producto 17: Remera básica algodón
(12, 1, 17),
(14, 3, 17),

-- Producto 18: Short training con bolsillos
(8, 1, 18),
(13, 2, 18),
(10, 3, 18),

-- Producto 19: Remera dry-fit manga larga
(10, 1, 19),
(15, 2, 19),
(2, 4, 2),

-- Producto 20: Jogging deportivo liviano
(6, 1, 20),
(10, 2, 20),
(8, 3, 20);

-- Estados de pago
INSERT INTO estado_pago (estado_pago_id, descripcion_estado_pago) VALUES
(1, 'Pendiente'),
(2, 'Pagado');

-- Domicilios de usuarios
INSERT INTO domicilio (altura, calle, ciudad_id) VALUES
(101, 'San Martín', 1),
(202, 'Belgrano', 2),
(303, 'Rivadavia', 3),
(404, 'Mitre', 4),
(505, 'Lavalle', 5),
(606, 'Catamarca', 6),
(707, 'Entre Ríos', 7),
(808, 'Corrientes', 8),
(909, 'Santa Fe', 9),
(1001, 'Urquiza', 10),
(1102, 'Salta', 11),
(1203, 'Tucumán', 12),
(1304, 'Jujuy', 1),
(1405, 'Formosa', 2);

-- Usuarios
INSERT INTO usuario (nombre_usuario, apellido_usuario, telefono, email, contrasena, perfil_id, domicilio_id) VALUES
('Juan', 'Pérez', '3794000000', 'juanperez@mail.com', 'clave123', 2, 5),
('Ana', 'Gómez', '3794111111', 'anagomez@mail.com', 'clave456', 1, 6),
('María', 'López', '3794222222', 'marialopez@mail.com', 'clave789', 2, 7),
('Carlos', 'Fernández', '3794333333', 'carlosfernandez@mail.com', 'clave321', 2, 8),
('Lucía', 'Martínez', '3794444444', 'luciamartinez@mail.com', 'clave654', 1, 9),
('Diego', 'Ramírez', '3794555555', 'diegoramirez@mail.com', 'clave987', 2, 10),
('Sofía', 'Alvarez', '3794666666', 'sofiaalvarez@mail.com', 'clave111', 2, 11),
('Martín', 'Domínguez', '3794777777', 'martindominguez@mail.com', 'clave222', 2, 12),
('Valeria', 'Suárez', '3794888888', 'valeriasuarez@mail.com', 'clave333', 1, 13),
('Fernando', 'García', '3794999999', 'fernandogarcia@mail.com', 'clave444', 2, 14),
('Paula', 'Méndez', '3795000000', 'paulamendez@mail.com', 'clave555', 2, 1),
('Ricardo', 'Torres', '3795111111', 'ricardotorres@mail.com', 'clave666', 2, 2),
('Camila', 'Rojas', '3795222222', 'camilarojas@mail.com', 'clave777', 2, 3),
('Andrés', 'Silva', '3795333333', 'andressilva@mail.com', 'clave888', 2, 4);

-- Ventas (15 ventas)
INSERT INTO venta (total, fecha, usuario_id, estado_pago_id) VALUES
(18000.00, GETDATE(), 3, 1), 
(22000.00, GETDATE(), 3, 2),  
(12500.00, GETDATE(), 4, 1),  
(27500.00, GETDATE(), 4, 2),  
(9500.00,  GETDATE(), 6, 1),  
(30500.00, GETDATE(), 6, 2),  
(14500.00, GETDATE(), 6, 1),  
(19800.00, GETDATE(), 6, 2),  
(16000.00, GETDATE(), 7, 1),  
(21000.00, GETDATE(), 7, 2),  
(13200.00, GETDATE(), 8, 1),  
(27500.00, GETDATE(), 8, 2), 
(16200.00, GETDATE(), 1, 1),  
(19800.00, GETDATE(), 6, 2),  
(17500.00, GETDATE(), 7, 1);  

-- Venta - método de pago
INSERT INTO venta_metodo_pago (venta_metodo_pago_id, metodo_pago_id, venta_id) VALUES
(1, 1, 1),   
(2, 2, 2),   
(3, 3, 3),   
(4, 1, 4),  
(5, 2, 5),  
(6, 4, 6),  
(7, 1, 7),   
(8, 2, 8),   
(9, 3, 9),   
(10, 4, 10), 
(11, 1, 11),
(12, 2, 12), 
(13, 3, 13), 
(14, 4, 14), 
(15, 1, 15); 

-- Detalle de ventas 
INSERT INTO detalle_venta (cantidad, precio_uni, talle_id, producto_id, venta_id) VALUES
(1, 15000.00, 1, 1, 1),
(2, 24000.00, 2, 2, 2),
(1, 9500.00, 3, 3, 3),
(1, 11000.00, 2, 4, 3),
(2, 18000.00, 1, 5, 4),
(1, 9500.00, 2, 6, 4),
(1, 8700.00, 3, 7, 5),
(2, 10200.00, 1, 8, 6),
(1, 11500.00, 2, 9, 6),
(1, 9400.00, 3, 10, 7),
(2, 10000.00, 1, 11, 8),
(3, 10800.00, 2, 12, 8),
(1, 9200.00, 3, 13, 9),
(2, 9700.00, 1, 14, 10),
(1, 8900.00, 2, 15, 10),
(1, 11200.00, 3, 16, 11),
(2, 9500.00, 1, 17, 12),
(1, 8800.00, 2, 18, 12),
(1, 10400.00, 3, 19, 13),
(2, 11800.00, 1, 20, 14),
(3, 12000.00, 2, 1, 15),
(1, 9500.00, 3, 2, 15);