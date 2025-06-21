CREATE DATABASE TiendaComputadores;
USE TiendaComputadores;

-- Tabla Empleados
CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    cargo VARCHAR(30),
    fecha_contratacion DATE,
    estado VARCHAR(10) DEFAULT 'Activo' CHECK (estado IN ('Activo', 'Inactivo'))
);

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Ventas
CREATE TABLE Ventas (
    id_venta INT PRIMARY KEY,
    tipo_venta VARCHAR(50),
    descripcion VARCHAR(500),
    fecha_venta DATETIME,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabla Reparaciones
CREATE TABLE Reparaciones (
    id_reparacion INT PRIMARY KEY,
    codigo_reparacion VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    estado_reparacion VARCHAR(15) DEFAULT 'Pendiente' CHECK (estado_reparacion IN ('Pendiente', 'Completada', 'En Proceso')),
    fecha_inicio DATE,
    id_venta INT,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta)
);

-- Tabla Productos
CREATE TABLE Productos (
    id_producto INT PRIMARY KEY,
    codigo_producto VARCHAR(10) UNIQUE,
    tipo_producto VARCHAR(30),
    modelo VARCHAR(30),
    id_empleado INT,
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado)
);

-- Tabla Pivote: Asignaciones_Reparaciones
CREATE TABLE Asignaciones_Reparaciones (
    id_asignacion INT PRIMARY KEY,
    id_empleado INT,
    id_reparacion INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_empleado) REFERENCES Empleados(id_empleado),
    FOREIGN KEY (id_reparacion) REFERENCES Reparaciones(id_reparacion)
);

-- Tabla Pivote: Herramientas_Ventas.

CREATE TABLE Herramientas_Ventas (
    id_herramienta INT PRIMARY KEY,
    id_venta INT,
    descripcion_herramienta VARCHAR(500),
    tipo_herramienta VARCHAR(50),
    fecha_registro DATETIME,
    FOREIGN KEY (id_venta) REFERENCES Ventas(id_venta)
);

-- Inserción de datos iniciales
INSERT INTO Clientes (id_cliente, cedula, nombre, apellido, direccion, telefono) VALUES
(1, '1029144515', 'Juan', 'Pérez', 'Calle 123', '3001234567'),
(2, '1075311234', 'María', 'Gómez', 'Avenida 45', '3109876543'),
(3, '1045637892', 'Carlos', 'López', 'Carrera 78', '3012468102'),
(4, '1009876543', 'Ana', 'Martínez', 'Calle 56', '3157891234'),
(5, '1123456789', 'Luis', 'Rodríguez', 'Avenida 12', '3012468102');

INSERT INTO Empleados (id_empleado, nombre, apellido, cargo, fecha_contratacion, estado) VALUES
(1, 'Pedro', 'Alonso', 'Vendedor', '2020-01-15', 'Activo'),
(2, 'Clara', 'Mendoza', 'Técnico', '2018-06-20', 'Activo'),
(3, 'Mateo', 'Rojas', 'Cajero', '2021-03-10', 'Activo'),
(4, 'Valeria', 'Ortiz', 'Gerente', '2015-11-05', 'Activo'),
(5, 'Gabriel', 'Luna', 'Soporte Técnico', '2019-08-25', 'Activo');

INSERT INTO Ventas (id_venta, tipo_venta, descripcion, fecha_venta, id_cliente) VALUES
(1, 'Venta Equipo', 'Venta de laptop gaming', '2025-05-10 14:30:00', 1),
(2, 'Servicio Técnico', 'Reparación de PC de escritorio', '2025-04-01 09:15:00', 2),
(3, 'Venta Accesorios', 'Venta de teclado y mouse', '2025-05-20 22:00:00', 3),
(4, 'Venta Software', 'Licencia de antivirus', '2025-03-15 18:45:00', 4),
(5, 'Venta Periféricos', 'Monitor 24 pulgadas', '2025-02-28 11:00:00', 5);

INSERT INTO Reparaciones (id_reparacion, codigo_reparacion, descripcion, estado_reparacion, fecha_inicio, id_venta) VALUES
(1, 'REP-001', 'Diagnóstico de laptop', 'En Proceso', '2025-05-11', 1),
(2, 'REP-002', 'Reparación de placa base', 'Pendiente', '2025-06-02', 2),
(3, 'REP-003', 'Reemplazo de teclado', 'Completada', '2025-04-21', 3),
(4, 'REP-004', 'Instalación de software', 'En Proceso', '2025-03-16', 4),
(5, 'REP-005', 'Reparación de monitor', 'Pendiente', '2025-03-01', 5);

INSERT INTO Asignaciones_Reparaciones (id_asignacion, id_empleado, id_reparacion, fecha_asignacion) VALUES
(1, 1, 1, '2025-05-12'),
(2, 2, 2, '2025-06-03'),
(3, 3, 3, '2025-04-22'),
(4, 4, 4, '2025-03-17'),
(5, 5, 5, '2025-03-02');

INSERT INTO Productos (id_producto, codigo_producto, tipo_producto, modelo, id_empleado) VALUES
(1, 'ABC123', 'Laptop', 'Gaming Pro', 1),
(2, 'XYZ789', 'Monitor', '24 pulgadas', 2),
(3, 'DEF456', 'Teclado', 'Mecánico', 3),
(4, 'GHI789', 'Laptop', 'UltraBook', 4),
(5, 'JKL012', 'Accesorios', 'Mouse', 5);

INSERT INTO Herramientas_Ventas (id_herramienta, id_venta, descripcion_herramienta, tipo_herramienta, fecha_registro) VALUES
(1, 1, 'Kit de herramientas', 'Herramientas Técnicas', '2025-05-10 15:00:00'),
(2, 2, 'Multímetro', 'Instrumento', '2025-06-01 10:00:00'),
(3, 3, 'Destornilladores', 'Herramienta', '2025-04-20 23:00:00'),
(4, 4, 'Software diagnóstico', 'Software', '2025-03-15 19:00:00'),
(5, 5, 'Cables de prueba', 'Accesorios', '2025-02-28 12:00:00');
go
-- Cambiar estado de una reparación específica
CREATE PROCEDURE CambiarEstadoReparacion
    @id_reparacion INT,
    @estado VARCHAR(15)
AS
BEGIN
    UPDATE Reparaciones
    SET estado_reparacion = @estado
    WHERE id_reparacion = @id_reparacion;
END;

-- Ejecutar procedimiento para cambiar estado de reparación
EXEC CambiarEstadoReparacion @id_reparacion = 1, @estado = 'Completada';




-- 10 Sentencias SELECT con funciones
-- 1. Calcular longitud del nombre completo de empleados
SELECT nombre, apellido,
       LEN(CONCAT(nombre, ' ', apellido)) AS longitud_nombre_completo
FROM Empleados;

-- 2. Extraer año de contratación de empleados
SELECT nombre, apellido,
       YEAR(fecha_contratacion) AS año_contratacion
FROM Empleados;

-- 3. Contar ventas por tipo y mes
SELECT tipo_venta,
       MONTH(fecha_venta) AS mes,
       COUNT(*) AS total_ventas
FROM Ventas
GROUP BY tipo_venta, MONTH(fecha_venta);

-- 4. Extraer primeros tres caracteres de códigos de reparación
SELECT codigo_reparacion,
       LEFT(codigo_reparacion, 3) AS codigo_inicial
FROM Reparaciones;

-- 5. Calcular promedio de días de reparaciones por estado
SELECT estado_reparacion,
       AVG(DATEDIFF(DAY, fecha_inicio, GETDATE())) AS promedio_dias
FROM Reparaciones
GROUP BY estado_reparacion;

-- 6. Cambiar 'Venta' por 'Compra' en tipo de venta
SELECT tipo_venta,
       REPLACE(tipo_venta, 'Venta', 'Compra') AS tipo_modificado
FROM Ventas;

-- 7. Eliminar guiones de números de teléfono de clientes
SELECT telefono,
       REPLACE(telefono, '-', '') AS telefono_limpio
FROM Clientes;

-- 8. Redondear fechas de venta a hora completa
SELECT fecha_venta,
       CONVERT(DATETIME, CONVERT(VARCHAR, fecha_venta, 120)) AS fecha_redondeada
FROM Ventas;

-- 9. Generar iniciales de nombre y apellido de empleados
SELECT nombre, apellido,
       CONCAT(LEFT(nombre, 1), LEFT(apellido, 1)) AS iniciales
FROM Empleados;

-- 10. Convertir descripciones de herramientas a mayúsculas
SELECT descripcion_herramienta,
       UPPER(descripcion_herramienta) AS descripcion_mayuscula
FROM Herramientas_Ventas;

-- 5 Sentencias SELECT adicionales
-- 1. Listar empleados técnicos
SELECT nombre, apellido, cargo
FROM Empleados
WHERE cargo IN ('Técnico', 'Soporte Técnico');

-- 2. Mostrar ventas con descripciones largas
SELECT tipo_venta, descripcion
FROM Ventas
WHERE LEN(descripcion) > 20;

-- 3. Ordenar productos por tipo
SELECT codigo_producto, tipo_producto, modelo
FROM Productos
ORDER BY tipo_producto;

-- 4. Filtrar clientes con teléfono que incluye '300'
SELECT nombre, apellido, telefono
FROM Clientes
WHERE telefono LIKE '%300%';

-- 5. Mostrar reparaciones asignadas a empleados activos
SELECT r.codigo_reparacion, e.nombre, e.apellido
FROM Reparaciones r
JOIN Asignaciones_Reparaciones ar ON r.id_reparacion = ar.id_reparacion
JOIN Empleados e ON ar.id_empleado = e.id_empleado
WHERE e.estado = 'Activo';

-- 5 Subconsultas
-- 1. Listar empleados asignados a reparaciones completadas
SELECT nombre, apellido
FROM Empleados
WHERE id_empleado IN (
    SELECT id_empleado FROM Asignaciones_Reparaciones
    WHERE id_reparacion IN (SELECT id_reparacion FROM Reparaciones WHERE estado_reparacion = 'Completada')
);

-- 2. Mostrar ventas de clientes con cédula mayor a '1050'
SELECT tipo_venta, descripcion
FROM Ventas
WHERE id_cliente IN (
    SELECT id_cliente FROM Clientes WHERE cedula > '1050'
);

-- 3. Listar productos no asignados a reparaciones
SELECT codigo_producto, tipo_producto
FROM Productos
WHERE id_empleado NOT IN (
    SELECT id_empleado FROM Asignaciones_Reparaciones
);

-- 4. Mostrar herramientas usadas en ventas de periféricos
SELECT descripcion_herramienta
FROM Herramientas_Ventas
WHERE id_venta IN (
    SELECT id_venta FROM Ventas WHERE tipo_venta = 'Venta Periféricos'
);

-- 5. Listar reparaciones iniciadas después de su venta
SELECT codigo_reparacion
FROM Reparaciones
WHERE fecha_inicio > (
    SELECT fecha_venta FROM Ventas WHERE id_venta = Reparaciones.id_venta
);

-- 5 UPDATE
-- 1. Cambiar cargo de empleados a 'Trabajador'
UPDATE Empleados
SET cargo = 'Trabajador';

-- 2. Establecer teléfono fijo para clientes
UPDATE Clientes
SET telefono = '3000000000';

-- 3. Cambiar estado de reparaciones a 'Pendiente'
UPDATE Reparaciones
SET estado_reparacion = 'Pendiente';

-- 4. Establecer descripción genérica para ventas
UPDATE Ventas
SET descripcion = 'Venta registrada';

-- 5. Establecer fecha fija para asignaciones de reparaciones
UPDATE Asignaciones_Reparaciones
SET fecha_asignacion = '2025-06-01';

-- 5 ALTER
-- 1. Agregar columna de correo a empleados
ALTER TABLE Empleados ADD correo VARCHAR(50);

-- 2. Agregar columna de prioridad a ventas
ALTER TABLE Ventas ADD nivel_prioridad VARCHAR(20) CHECK (nivel_prioridad IN ('Baja', 'Media', 'Alta'));

-- 3. Agregar columna de costo a reparaciones
ALTER TABLE Reparaciones ADD costo INT DEFAULT 0;

-- 4. Aumentar longitud de tipo de producto
ALTER TABLE Productos
ALTER COLUMN tipo_producto VARCHAR(50);

-- 5. Agregar columna de condición a herramientas
ALTER TABLE Herramientas_Ventas
ADD condicion VARCHAR(20) DEFAULT 'Operativo';

-- 5 DELETE
-- 1. Eliminar todos los registros de herramientas
DELETE FROM Herramientas_Ventas;

-- 2. Eliminar todos los registros de asignaciones de reparaciones
DELETE FROM Asignaciones_Reparaciones;

-- 3. Eliminar todos los registros de productos
DELETE FROM Productos;

-- 4. Eliminar todos los registros de reparaciones
DELETE FROM Reparaciones;

-- 5. Eliminar todos los registros de ventas
DELETE FROM Ventas;

-- 5 TRUNCATE
-- 1. Vaciar tabla de herramientas
TRUNCATE TABLE Herramientas_Ventas;

-- 2. Vaciar tabla de asignaciones de reparaciones
TRUNCATE TABLE Asignaciones_Reparaciones;

-- 3. Vaciar tabla de productos
TRUNCATE TABLE Productos;

-- 4. Vaciar tabla de reparaciones
TRUNCATE TABLE Reparaciones;

-- 5. Vaciar tabla de ventas
TRUNCATE TABLE Ventas;

-- 5 DROP
-- 1. Eliminar tabla de herramientas
DROP TABLE Herramientas_Ventas;

-- 2. Eliminar tabla de asignaciones de reparaciones
DROP TABLE Asignaciones_Reparaciones;

-- 3. Eliminar tabla de productos
DROP TABLE Productos;

-- 4. Eliminar tabla de reparaciones
DROP TABLE Reparaciones;

-- 5. Eliminar tabla de ventas
DROP TABLE Ventas;