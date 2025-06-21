CREATE DATABASE Papeleria;
USE Papeleria;

-- Tabla Personal: Registra información del personal de la papelería.
CREATE TABLE Personal (
    id_personal INT PRIMARY KEY,
    nombre_completo VARCHAR(100),
    puesto VARCHAR(30),
    fecha_ingreso DATE,
    salario INT
);

-- Tabla Compradores: Almacena datos de los compradores
CREATE TABLE Compradores (
    id_comprador INT PRIMARY KEY,
    documento VARCHAR(20) UNIQUE,
    nombre_contacto VARCHAR(50),
    email VARCHAR(50),
    ciudad VARCHAR(50),
    categoria VARCHAR(20) DEFAULT 'Estándar' CHECK (categoria IN ('Estándar', 'Premium', 'Empresarial'))
);

-- Tabla Transacciones: Registra las transacciones de venta
CREATE TABLE Transacciones (
    id_transaccion INT PRIMARY KEY,
    categoria_transaccion VARCHAR(50),
    detalle VARCHAR(500),
    fecha_transaccion DATETIME,
    id_comprador INT,
    valor INT,
    FOREIGN KEY (id_comprador) REFERENCES Compradores(id_comprador)
);

-- Tabla Servicios: Registra servicios de reparación o mantenimiento
CREATE TABLE Servicios (
    id_servicio INT PRIMARY KEY,
    codigo_servicio VARCHAR(20) UNIQUE,
    detalle_servicio VARCHAR(500),
    fecha_inicio DATE,
    id_transaccion INT,
    equipo VARCHAR(50),
    FOREIGN KEY (id_transaccion) REFERENCES Transacciones(id_transaccion)
);

-- Tabla Artículos: Almacena el inventario de artículos de papelería
CREATE TABLE Artículos (
    id_articulo INT PRIMARY KEY,
    codigo_articulo VARCHAR(10) UNIQUE,
    categoria_articulo VARCHAR(30),
    descripcion VARCHAR(100),
    id_personal INT,
    stock INT DEFAULT 0,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

-- Tabla Pivote: Asignaciones_Servicios: Asigna personal a servicios
CREATE TABLE Asignaciones_Servicios (
    id_asignacion INT PRIMARY KEY,
    id_personal INT,
    id_servicio INT,
    fecha_asignacion DATE,
    duracion_estimada INT,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal),
    FOREIGN KEY (id_servicio) REFERENCES Servicios(id_servicio)
);

-- Tabla Pivote: Recursos_Transacciones: Registra recursos usados en transacciones
CREATE TABLE Recursos_Transacciones (
    id_recurso INT PRIMARY KEY,
    id_transaccion INT,
    nombre_recurso VARCHAR(50),
    tipo_recurso VARCHAR(50),
    fecha_uso DATETIME,
    FOREIGN KEY (id_transaccion) REFERENCES Transacciones(id_transaccion)
);

-- Inserción de datos iniciales
INSERT INTO Compradores (id_comprador, documento, nombre_contacto, email, ciudad, categoria) VALUES
(1, '1029144515', 'Juan Pérez', 'juan.perez@gmail.com', 'Bogotá', 'Estándar'),
(2, '1075311234', 'María Gómez', 'maria.gomez@hotmail.com', 'Medellín', 'Premium'),
(3, '1045637892', 'Carlos López', 'carlos.lopez@yahoo.com', 'Cali', 'Empresarial'),
(4, '1009876543', 'Ana Martínez', 'ana.martinez@outlook.com', 'Barranquilla', 'Estándar'),
(5, '1123456789', 'Luis Rodríguez', 'luis.rodriguez@gmail.com', 'Cartagena', 'Premium');

INSERT INTO Personal (id_personal, nombre_completo, puesto, fecha_ingreso, salario) VALUES
(1, 'Pedro Alonso', 'Vendedor', '2020-01-15', 1500000),
(2, 'Clara Mendoza', 'Técnico', '2018-06-20', 1800000),
(3, 'Mateo Rojas', 'Cajero', '2021-03-10', 1200000),
(4, 'Valeria Ortiz', 'Gerente', '2015-11-05', 3000000),
(5, 'Gabriel Luna', 'Encargado Inventario', '2019-08-25', 1600000);

INSERT INTO Transacciones (id_transaccion, categoria_transaccion, detalle, fecha_transaccion, id_comprador, valor) VALUES
(1, 'Venta Artículos', 'Venta de 10 cuadernos', '2025-05-10 14:30:00', 1, 80000),
(2, 'Reparación', 'Reparación de impresora HP', '2025-04-01 09:15:00', 2, 60000),
(3, 'Venta Papel', 'Resma de papel carta', '2025-05-20 22:00:00', 3, 20000),
(4, 'Venta Accesorios', 'Set de marcadores', '2025-03-15 18:45:00', '4', 15000),
(5, 'Venta Escritura', 'Paquete de bolígrafos', '2025-02-28 11:00:00', 5, 10000);

INSERT INTO Servicios (id_servicio, codigo_servicio, detalle_servicio, fecha_inicio, id_transaccion, equipo) VALUES
(1, 'SRV-001', 'Revisión de impresora', '2025-05-11', 1, 'Impresora'),
(2, 'SRV-002', 'Mantenimiento de encuadernadora', '2025-06-02', 2, 'Encuadernadora'),
(3, 'SRV-003', 'Cambio de cartucho', '2025-04-21', 3, 'Impresora'),
(4, 'SRV-004', 'Reparación de guillotina', '2025-03-16', 4, 'Guillotina'),
(5, 'SRV-005', 'Ajuste de calculadora', '2025-03-01', 5, 'Calculadora');

INSERT INTO Asignaciones_Servicios (id_asignacion, id_personal, id_servicio, fecha_asignacion, duracion_estimada) VALUES
(1, 1, 1, '2025-05-12', 2),
(2, 2, 2, '2025-06-03', 3),
(3, 3, 3, '2025-04-22', 1),
(4, 4, 4, '2025-03-17', 4),
(5, 5, 5, '2025-03-02', 2);

INSERT INTO Artículos (id_articulo, codigo_articulo, categoria_articulo, descripcion, id_personal, stock) VALUES
(1, 'ART123', 'Papel', 'Resma Carta 500 Hojas', 1, 50),
(2, 'ART789', 'Escritura', 'Bolígrafo Negro', 2, 200),
(3, 'ART456', 'Cuadernos', 'Cuaderno 100 Hojas', 3, 100),
(4, 'ART790', 'Marcadores', 'Marcador Permanente', 4, 150),
(5, 'ART012', 'Accesorios', 'Cinta Adhesiva', 5, 300);

INSERT INTO Recursos_Transacciones (id_recurso, id_transaccion, nombre_recurso, tipo_recurso, fecha_uso) VALUES
(1, 1, 'Kit Técnico', 'Herramientas', '2025-05-10 15:00:00'),
(2, 2, 'Multímetro', 'Instrumento', '2025-06-01 10:00:00'),
(3, 3, 'Destornillador', 'Herramienta', '2025-04-20 23:00:00'),
(4, 4, 'Software Diagnóstico', 'Software', '2025-03-15 19:00:00'),
(5, 5, 'Cable Prueba', 'Accesorios', '2025-02-28 12:00:00');

go
-- Asignar un empleado a un servicio
CREATE PROCEDURE AsignarPersonalServicio
    @id_personal INT,
    @id_servicio INT
AS
BEGIN
    INSERT INTO Asignaciones_Servicios (id_asignacion, id_personal, id_servicio, fecha_asignacion, duracion_estimada)
    VALUES ((SELECT ISNULL(MAX(id_asignacion), 0) + 1 FROM Asignaciones_Servicios), @id_personal, @id_servicio, GETDATE(), 1);
END;

-- Ejecutar procedimiento para asignar personal
EXEC AsignarPersonalServicio @id_personal = 2, @id_servicio = 3;

-- 10 Sentencias SELECT con funciones
-- 1. Calcular longitud del nombre completo del personal
SELECT nombre_completo,
       LEN(nombre_completo) AS longitud_nombre
FROM Personal;

-- 2. Extraer año de ingreso del personal
SELECT nombre_completo,
       YEAR(fecha_ingreso) AS año_ingreso
FROM Personal;

-- 3. Contar transacciones por categoría y mes
SELECT categoria_transaccion,
       MONTH(fecha_transaccion) AS mes,
       COUNT(*) AS total_transacciones
FROM Transacciones
GROUP BY categoria_transaccion, MONTH(fecha_transaccion);

-- 4. Extraer primeros tres caracteres de códigos de servicio
SELECT codigo_servicio,
       LEFT(codigo_servicio, 3) AS codigo_inicial
FROM Servicios;

-- 5. Calcular promedio de días desde inicio de servicios
SELECT equipo,
       AVG(DATEDIFF(DAY, fecha_inicio, GETDATE())) AS promedio_dias
FROM Servicios
GROUP BY equipo;

-- 6. Cambiar 'Venta' por 'Compra' en categoría de transacción
SELECT categoria_transaccion,
       REPLACE(categoria_transaccion, 'Venta', 'Compra') AS categoria_modificada
FROM Transacciones;

-- 7. Eliminar guiones de documentos de compradores
SELECT documento,
       REPLACE(documento, '-', '') AS documento_limpio
FROM Compradores;

-- 8. Redondear fechas de transacción a hora completa
SELECT fecha_transaccion,
       CONVERT(DATETIME, CONVERT(VARCHAR, fecha_transaccion, 120)) AS fecha_redondeada
FROM Transacciones;

-- 9. Generar iniciales del nombre de contacto de compradores
SELECT nombre_contacto,
       LEFT(nombre_contacto, 1) AS inicial
FROM Compradores;

-- 10. Convertir nombres de recursos a mayúsculas
SELECT nombre_recurso,
       UPPER(nombre_recurso) AS nombre_mayuscula
FROM Recursos_Transacciones;

-- 5 Sentencias SELECT adicionales
-- 1. Listar personal técnico
SELECT nombre_completo, puesto
FROM Personal
WHERE puesto IN ('Técnico', 'Encargado Inventario');

-- 2. Mostrar transacciones con valor superior a 50000
SELECT categoria_transaccion, valor
FROM Transacciones
WHERE valor > 50000;

-- 3. Ordenar artículos por stock
SELECT codigo_articulo, categoria_articulo, stock
FROM Artículos
ORDER BY stock DESC;

-- 4. Filtrar compradores premium o empresariales
SELECT nombre_contacto, categoria
FROM Compradores
WHERE categoria IN ('Premium', 'Empresarial');

-- 5. Mostrar servicios asignados a personal con salario alto
SELECT s.codigo_servicio, p.nombre_completo
FROM Servicios s
JOIN Asignaciones_Servicios a ON s.id_servicio = a.id_servicio
JOIN Personal p ON a.id_personal = p.id_personal
WHERE p.salario > 1500000;

-- 5 Subconsultas
-- 1. Listar personal asignado a servicios de impresoras
SELECT nombre_completo
FROM Personal
WHERE id_personal IN (
    SELECT id_personal FROM Asignaciones_Servicios
    WHERE id_servicio IN (SELECT id_servicio FROM Servicios WHERE equipo = 'Impresora')
);

-- 2. Mostrar transacciones de compradores premium
SELECT categoria_transaccion, detalle
FROM Transacciones
WHERE id_comprador IN (
    SELECT id_comprador FROM Compradores WHERE categoria = 'Premium');

-- 3. Listar artículos no asignados a servicios
SELECT codigo_articulo, categoria_articulo
FROM Artículos
WHERE id_personal NOT IN (
    SELECT id_personal FROM Asignaciones_Servicios
);

-- 4. Mostrar recursos usados en ventas de papel
SELECT nombre_recurso
FROM Recursos_Transacciones
WHERE id_transaccion IN (
    SELECT id_transaccion FROM Transacciones WHERE categoria_transaccion = 'Venta Papel'
);

-- 5. Listar servicios con transacciones de alto valor
SELECT codigo_servicio
FROM Servicios
WHERE id_transaccion IN (
    SELECT id_transaccion FROM Transacciones WHERE valor > 50000
);

-- 5 UPDATE


-- 1. Aumentar salario del personal en 10%
UPDATE Personal
SET salario = salario * 1.10;

-- 2. Establecer documento fijo para compradores
UPDATE Compradores
SET documento = '3000000000';

-- 3. Establecer fecha fija para inicio de servicios
UPDATE Servicios
SET fecha_inicio = '2025-06-01';

-- 4. Establecer detalle genérico para transacciones
UPDATE Transacciones
SET detalle = 'Transacción registrada';

-- 5. Establecer fecha fija para asignaciones de servicios
UPDATE Asignaciones_Servicios
SET fecha_asignacion = '2025-06-01';

-- 5 ALTER
-- 1. Agregar columna de notas a personal
ALTER TABLE Personal ADD notas VARCHAR(100);

-- 2. Agregar columna de urgencia a transacciones
ALTER TABLE Transacciones ADD urgencia VARCHAR(20) CHECK (urgencia IN ('Baja', 'Media', 'Alta'));

-- 3. Agregar columna de costo a servicios
ALTER TABLE Servicios ADD costo INT DEFAULT 0;

-- 4. Aumentar longitud de categoría de artículo
ALTER TABLE Artículos
ALTER COLUMN categoria_articulo VARCHAR(50);

-- 5. Agregar columna de condición a recursos
ALTER TABLE Recursos_Transacciones
ADD condicion VARCHAR(20) DEFAULT 'Operativo';

-- 5 DELETE
-- 1. Eliminar todos los registros de recursos
DELETE FROM Recursos_Transacciones;

-- 2. Eliminar todos los registros de asignaciones de servicios
DELETE FROM Asignaciones_Servicios;

-- 3. Eliminar todos los registros de artículos
DELETE FROM Artículos;

-- 4. Eliminar todos los registros de servicios
DELETE FROM Servicios;

-- 5. Eliminar todos los registros de transacciones
DELETE FROM Transacciones;

-- 5 TRUNCATE
-- 1. Vaciar tabla de recursos
TRUNCATE TABLE Recursos_Transacciones;

-- 2. Vaciar tabla de asignaciones de servicios
TRUNCATE TABLE Asignaciones_Servicios;

-- 3. Vaciar tabla de artículos
TRUNCATE TABLE Artículos;

-- 4. Vaciar tabla de servicios
TRUNCATE TABLE Servicios;

-- 5. Vaciar tabla de transacciones
TRUNCATE TABLE Transacciones;

-- 5 DROP
-- 1. Eliminar tabla de recursos
DROP TABLE Recursos_Transacciones;

-- 2. Eliminar tabla de asignaciones de servicios
DROP TABLE Asignaciones_Servicios;

-- 3. Eliminar tabla de artículos
DROP TABLE Artículos;

-- 4. Eliminar tabla de servicios
DROP TABLE Servicios;

-- 5. Eliminar tabla de transacciones
DROP TABLE Transacciones;