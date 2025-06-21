CREATE DATABASE Cafeteria;
USE Cafeteria;

-- Tabla Baristas: Registra información del personal de la cafetería
CREATE TABLE Baristas (
    id_barista INT PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad VARCHAR(30),
    fecha_contratacion DATE,
    sueldo INT
);

-- Tabla ClientesFrecuentes: Almacena datos de los clientes frecuentes
CREATE TABLE ClientesFrecuentes (
    id_cliente INT PRIMARY KEY,
    numero_membresia VARCHAR(20) UNIQUE,
    nombre_socio VARCHAR(50),
    telefono VARCHAR(15)
);

-- Tabla Pedidos: Registra los pedidos realizados
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY,
    tipo_pedido VARCHAR(50),
    descripcion VARCHAR(500),
    fecha_pedido DATETIME,
    id_cliente INT,
    monto INT,
    FOREIGN KEY (id_cliente) REFERENCES ClientesFrecuentes(id_cliente)
);

-- Tabla Recetas: Registra instrucciones para preparar productos
CREATE TABLE Recetas (
    id_receta INT PRIMARY KEY,
    codigo_receta VARCHAR(20) UNIQUE,
    instrucciones VARCHAR(500),
    fecha_creacion DATE,
    id_pedido INT,
    producto_final VARCHAR(50),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabla Ingredientes: Almacena el inventario de ingredientes
CREATE TABLE Ingredientes (
    id_ingrediente INT PRIMARY KEY,
    codigo_ingrediente VARCHAR(10) UNIQUE,
    tipo_ingrediente VARCHAR(30),
    nombre_ingrediente VARCHAR(100),
    id_barista INT,
    cantidad INT DEFAULT 0,
    FOREIGN KEY (id_barista) REFERENCES Baristas(id_barista)
);

-- Tabla Pivote: Asignaciones_Recetas: Asigna baristas a recetas
CREATE TABLE Asignaciones_Recetas (
    id_asignacion INT PRIMARY KEY,
    id_barista INT,
    id_receta INT,
    fecha_asignacion DATE,
    tiempo_estimado INT,
    FOREIGN KEY (id_barista) REFERENCES Baristas(id_barista),
    FOREIGN KEY (id_receta) REFERENCES Recetas(id_receta)
);

-- Tabla Pivote: Equipos_Pedidos: Registra equipos usados en pedidos
CREATE TABLE Equipos_Pedidos (
    id_equipo INT PRIMARY KEY,
    id_pedido INT,
    nombre_equipo VARCHAR(50),
    tipo_equipo VARCHAR(50),
    fecha_uso DATETIME,
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Inserción de datos iniciales
INSERT INTO ClientesFrecuentes (id_cliente, numero_membresia, nombre_socio, telefono) VALUES
(1, 'MEMB-001', 'Laura Vargas', '3001234567'),
(2, 'MEMB-002', 'Diego Salazar', '3109876543'),
(3, 'MEMB-003', 'Sofía Mejía', '3204567890'),
(4, 'MEMB-004', 'Andrés ', '3103404920'),
(5, 'MEMB-005', 'Camila Ospina', '3136268983');

INSERT INTO Baristas (id_barista, nombre, especialidad, fecha_contratacion, sueldo) VALUES
(1, 'Ana Torres', 'Latte Art', '2020-03-01', 1450000),
(2, 'Juan Castro', 'Cocina', '2019-08-10', 1650000),
(3, 'María Fernández', 'Caja', '2021-05-15', 1150000),
(4, 'Carlos Rincón', 'Gestión', '2017-01-20', 2700000),
(5, 'Valentina Gómez', 'Inventario', '2020-11-05', 1550000);

INSERT INTO Pedidos (id_pedido, tipo_pedido, descripcion, fecha_pedido, id_cliente, monto) VALUES
(1, 'Bebida', 'Latte mediano x2', '2025-06-12 09:00:00', 1, 14000),
(2, 'Plato', 'Croissant de jamón', '2025-06-03 13:30:00', 2, 12000),
(3, 'Postre', 'Cheesecake', '2025-06-18 16:00:00', 3, 9000),
(4, 'Bebida', 'Jugo de mango', '2025-05-22 11:15:00', 4, 7000),
(5, 'Plato', 'Omelette con tostadas', '2025-05-27 08:30:00', 5, 18000);

INSERT INTO Recetas (id_receta, codigo_receta, instrucciones, fecha_creacion, id_pedido, producto_final) VALUES
(1, 'REC-001', 'Espumar leche, servir espreso', '2025-06-13', 1, 'Latte'),
(2, 'REC-002', 'Hornear croissant, añadir jamón', '2025-06-04', 2, 'Croissant'),
(3, 'REC-003', 'Cortar cheesecake, decorar', '2025-06-19', 3, 'Cheesecake'),
(4, 'REC-004', 'Licuar mango con agua', '2025-05-23', 4, 'Jugo de Mango'),
(5, 'REC-005', 'Batir huevos, tostar pan', '2025-05-28', 5, 'Omelette');

INSERT INTO Asignaciones_Recetas (id_asignacion, id_barista, id_receta, fecha_asignacion, tiempo_estimado) VALUES
(1, 1, 1, '2025-06-13', 1),
(2, 2, 2, '2025-06-04', 2),
(3, 3, 3, '2025-06-19', 1),
(4, 4, 4, '2025-05-23', 1),
(5, 5, 5, '2025-05-28', 3);

INSERT INTO Ingredientes (id_ingrediente, codigo_ingrediente, tipo_ingrediente, nombre_ingrediente, id_barista, cantidad) VALUES
(1, 'ING001', 'Bebida', 'Granos de Café', 1, 500),
(2, 'ING002', 'Comida', 'Jamón', 2, 200),
(3, 'ING003', 'Postre', 'Queso Crema', 3, 150),
(4, 'ING004', 'Fruta', 'Mango', 4, 300),
(5, 'ING005', 'Comida', 'Huevos', 5, 100);

INSERT INTO Equipos_Pedidos (id_equipo, id_pedido, nombre_equipo, tipo_equipo, fecha_uso) VALUES
(1, 1, 'Espumador', 'Equipo', '2025-06-12 09:10:00'),
(2, 2, 'Horno', 'Equipo', '2025-06-03 13:40:00'),
(3, 3, 'Cuchillo', 'Herramienta', '2025-06-18 16:10:00'),
(4, 4, 'Licuadora', 'Equipo', '2025-05-22 11:20:00'),
(5, 5, 'Sartén', 'Equipo', '2025-05-27 08:40:00');

GO
-- Asignar un barista a una receta
CREATE PROCEDURE AsignarEmpleadoPreparacion
    @id_barista INT,
    @id_receta INT
AS
BEGIN
    INSERT INTO Asignaciones_Recetas (id_asignacion, id_barista, id_receta, fecha_asignacion, tiempo_estimado)
    VALUES ((SELECT ISNULL(MAX(id_asignacion), 0) + 1 FROM Asignaciones_Recetas), @id_barista, @id_receta, GETDATE(), 1);
END;

-- Ejecutar procedimiento para asignar barista
EXEC AsignarEmpleadoPreparacion @id_barista = 2, @id_receta = 3;

-- 10 Sentencias SELECT con funciones
-- 1. Concatenar nombre y especialidad de baristas
SELECT nombre,
       CONCAT(nombre, ' - ', especialidad) AS nombre_especialidad
FROM Baristas;

-- 2. Extraer día de la semana de la fecha de pedido
SELECT descripcion,
       DATENAME(WEEKDAY, fecha_pedido) AS dia_semana
FROM Pedidos;

-- 3. Calcular total de pedidos por tipo y año
SELECT tipo_pedido,
       YEAR(fecha_pedido) AS año,
       SUM(monto) AS total_monto
FROM Pedidos
GROUP BY tipo_pedido, YEAR(fecha_pedido);

-- 4. Obtener últimos 4 caracteres de códigos de receta
SELECT codigo_receta,
       RIGHT(codigo_receta, 4) AS codigo_final
FROM Recetas;

-- 5. Redondear monto de pedidos al múltiplo de 1000
SELECT descripcion,
       ROUND(monto, -3) AS monto_redondeado
FROM Pedidos;

-- 6. Convertir instrucciones de recetas a minúsculas
SELECT instrucciones,
       LOWER(instrucciones) AS instrucciones_minusculas
FROM Recetas;

-- 7. Formatear número de membresía con guiones
SELECT numero_membresia,
       STUFF(STUFF(numero_membresia, 5, 0, '-'), 10, 0, '-') AS membresia_formateada
FROM ClientesFrecuentes;

-- 8. Calcular diferencia de días entre fecha de creación y hoy
SELECT codigo_receta,
       DATEDIFF(DAY, fecha_creacion, GETDATE()) AS dias_desde_creacion
FROM Recetas;

-- 9. Extraer mes de contratación de baristas
SELECT nombre,
       DATEPART(MONTH, fecha_contratacion) AS mes_contratacion
FROM Baristas;

-- 10. Reemplazar espacios por guiones en nombre de equipos
SELECT nombre_equipo,
       REPLACE(nombre_equipo, ' ', '-') AS nombre_formateado
FROM Equipos_Pedidos;


-- 5 Sentencias SELECT adicionales
-- 1. Listar baristas con sueldo superior a 1500000
SELECT nombre, sueldo
FROM Baristas
WHERE sueldo > 1500000;

-- 2. Mostrar pedidos de tipo 'Bebida'
SELECT tipo_pedido, monto
FROM Pedidos
WHERE tipo_pedido = 'Bebida';

-- 3. Ordenar ingredientes por cantidad descendente
SELECT codigo_ingrediente, nombre_ingrediente, cantidad
FROM Ingredientes
ORDER BY cantidad DESC;

-- 4. Listar recetas creadas en mayo o junio de 2025
SELECT codigo_receta, producto_final
FROM Recetas
WHERE YEAR(fecha_creacion) = 2025 AND MONTH(fecha_creacion) IN (5, 6);

-- 5. Mostrar clientes con id mayor a 3
SELECT nombre_socio, telefono
FROM ClientesFrecuentes
WHERE id_cliente > 3;

-- 5 Subconsultas
-- 1. Listar baristas asignados a recetas de lattes
SELECT nombre
FROM Baristas
WHERE id_barista IN (
    SELECT id_barista FROM Asignaciones_Recetas
    WHERE id_receta IN (SELECT id_receta FROM Recetas WHERE producto_final = 'Latte')
);

-- 2. Mostrar pedidos de clientes con teléfono específico
SELECT tipo_pedido, descripcion
FROM Pedidos
WHERE id_cliente IN (
    SELECT id_cliente FROM ClientesFrecuentes WHERE telefono LIKE '310%'
);

-- 3. Listar ingredientes no asignados a recetas
SELECT codigo_ingrediente, nombre_ingrediente
FROM Ingredientes
WHERE id_barista NOT IN (
    SELECT id_barista FROM Asignaciones_Recetas
);

-- 4. Mostrar equipos usados en pedidos de platos
SELECT nombre_equipo
FROM Equipos_Pedidos
WHERE id_pedido IN (
    SELECT id_pedido FROM Pedidos WHERE tipo_pedido = 'Plato'
);

-- 5. Listar recetas asociadas a pedidos de monto alto
SELECT codigo_receta
FROM Recetas
WHERE id_pedido IN (
    SELECT id_pedido FROM Pedidos WHERE monto > 10000
);

-- 5 UPDATE
-- 1. Aumentar sueldo de baristas en 15%
UPDATE Baristas
SET sueldo = sueldo * 1.15;

-- 2. Agregar sufijo al teléfono de clientes
UPDATE ClientesFrecuentes
SET telefono = telefono + CAST(id_cliente AS NVARCHAR(10));

-- 3. Actualizar instrucciones de recetas a genérico
UPDATE Recetas
SET instrucciones = 'Preparar según estándar';

-- 4. Establecer fecha fija para pedidos
UPDATE Pedidos
SET fecha_pedido = '2025-06-01 10:00:00';

-- 5. Actualizar tiempo estimado de asignaciones
UPDATE Asignaciones_Recetas
SET tiempo_estimado = 2;

-- 5 ALTER
-- 1. Agregar columna de comentarios a baristas
ALTER TABLE Baristas ADD comentarios VARCHAR(200);

-- 2. Agregar columna de descuento a pedidos
ALTER TABLE Pedidos ADD descuento INT DEFAULT 0;

-- 3. Agregar columna de precio unitario a ingredientes
ALTER TABLE Ingredientes ADD precio_unitario INT DEFAULT 0;

-- 4. Agregar columna de estado a recetas
ALTER TABLE Recetas ADD estado VARCHAR(20) DEFAULT 'Activa';

-- 5. Agregar columna de capacidad a equipos
ALTER TABLE Equipos_Pedidos ADD capacidad VARCHAR(50);

-- 5 DELETE
-- 1. Eliminar todos los registros de equipos
DELETE FROM Equipos_Pedidos;

-- 2. Eliminar todos los registros de asignaciones de recetas
DELETE FROM Asignaciones_Recetas;

-- 3. Eliminar todos los registros de ingredientes
DELETE FROM Ingredientes;

-- 4. Eliminar todos los registros de recetas
DELETE FROM Recetas;

-- 5. Eliminar todos los registros de pedidos
DELETE FROM Pedidos;

-- 3 TRUNCATE
-- 1. Vaciar tabla de equipos
TRUNCATE TABLE Equipos_Pedidos;

-- 2. Vaciar tabla de asignaciones de recetas
TRUNCATE TABLE Asignaciones_Recetas;

-- 3. Vaciar tabla de ingredientes
TRUNCATE TABLE Ingredientes;

-- 5 DROP
-- 1. Eliminar tabla de equipos
DROP TABLE Equipos_Pedidos;

-- 2. Eliminar tabla de asignaciones de recetas
DROP TABLE Asignaciones_Recetas;

-- 3. Eliminar tabla de ingredientes
DROP TABLE Ingredientes;

-- 4. Eliminar tabla de recetas
DROP TABLE Recetas;

-- 5. Eliminar tabla de pedidos
DROP TABLE Pedidos;