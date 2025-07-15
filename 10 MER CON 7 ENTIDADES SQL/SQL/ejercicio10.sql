
-- Creación de la base de datos
CREATE DATABASE Restaurante;
USE Restaurante;

-- Tabla Chefs 
CREATE TABLE Chefs (
    id_chef INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    especialidad VARCHAR(50),
    fecha_contratacion DATE
);

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    telefono VARCHAR(15)
);

-- Tabla Platos
CREATE TABLE Platos (
    id_plato INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    chef VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    fecha_creacion DATE,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabla Pedidos 
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY,
    codigo_pedido VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    fecha_pedido DATETIME,
    id_plato INT,
    FOREIGN KEY (id_plato) REFERENCES Platos(id_plato)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_chef INT,
    FOREIGN KEY (id_chef) REFERENCES Chefs(id_chef)
);

-- Tabla Pivote: Asignaciones_Pedidos
CREATE TABLE Asignaciones_Pedidos (
    id_asignacion INT PRIMARY KEY,
    id_chef INT,
    id_pedido INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_chef) REFERENCES Chefs(id_chef),
    FOREIGN KEY (id_pedido) REFERENCES Pedidos(id_pedido)
);

-- Tabla Pivote: Preparaciones_Platos
CREATE TABLE Preparaciones_Platos (
    id_preparacion INT PRIMARY KEY,
    id_plato INT,
    descripcion_preparacion VARCHAR(500),
    tipo_preparacion VARCHAR(50),
    fecha_preparacion DATETIME,
    FOREIGN KEY (id_plato) REFERENCES Platos(id_plato)
);

-- Inserción de datos iniciales
INSERT INTO Clientes VALUES
(1, 'Sofía', 'Rodríguez', '3001234567'),
(2, 'Juan', 'Pérez', '3109876543'),
(3, 'María', 'Gómez', '3014567890');

INSERT INTO Chefs  VALUES
(1, 'Ana', 'Martínez', 'Cocina Italiana', '2020-05-10'),
(2, 'Carlos', 'López', 'Cocina Francesa', '2021-06-15'),
(3, 'Luis', 'Ramírez', 'Postres', '2019-08-20');

INSERT INTO Platos (id_plato, nombre, chef, categoria, fecha_creacion, id_cliente) VALUES
(1, 'Pasta Carbonara', 'Ana Martínez', 'Italiana', '2025-01-15', 1),
(2, 'Coq au Vin', 'Carlos López', 'Francesa', '2025-02-10', 2),
(3, 'Tiramisú', 'Luis Ramírez', 'Postre', '2025-03-05', 3);

INSERT INTO Pedidos (id_pedido, codigo_pedido, descripcion, fecha_pedido, id_plato) VALUES
(1, 'PED-001', 'Pedido para cena', '2025-07-12 19:00:00', 1),
(2, 'PED-002', 'Pedido para almuerzo', '2025-06-25 13:00:00', 2),
(3, 'PED-003', 'Pedido para postre', '2025-07-15 20:00:00', 3);

INSERT INTO Asignaciones_Pedidos (id_asignacion, id_chef, id_pedido, fecha_asignacion) VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos (id_equipo, codigo_equipo, tipo_equipo, marca, id_chef) VALUES
(1, 'EQP-001', 'Horno', 'Electrolux', 1),
(2, 'EQP-002', 'Batidora', 'KitchenAid', 2),
(3, 'EQP-003', 'Plancha', 'Vulcan', 3);

INSERT INTO Preparaciones_Platos (id_preparacion, id_plato, descripcion_preparacion, tipo_preparacion, fecha_preparacion) VALUES
(1, 1, 'Preparación de salsa carbonara', 'Cocción', '2025-07-12 18:00:00'),
(2, 2, 'Marinado de pollo', 'Marinado', '2025-06-25 12:00:00'),
(3, 3, 'Elaboración de crema de tiramisú', 'Mezcla', '2025-07-15 19:00:00');

--  Sentencias SQL con funciones aplicadas al MER


-- . Calcular semanas desde contratación
SELECT nombre, apellido,
       DATEDIFF(WEEK, fecha_contratacion, GETDATE()) AS semanas_contratado
FROM Chefs;


-- . Mostrar nombres de clientes en título
SELECT nombre,
       UPPER(LEFT(nombre, 1)) + LOWER(SUBSTRING(nombre, 2, LEN(nombre))) AS nombre_titulo
FROM Clientes;

-- . Reemplazar 'Pedido' por 'Orden' en descripciones
SELECT descripcion,
       REPLACE(descripcion, 'Pedido', 'Orden') AS descripcion_modificada
FROM Pedidos;

--  Obtener longitud de marcas de equipos
SELECT marca,
       LEN(marca) AS longitud_marca
FROM Equipos;

-- . Formatear fecha de pedido como texto
SELECT descripcion,
       CONVERT(VARCHAR, fecha_pedido, 103) AS fecha_texto
FROM Pedidos;

-- . Contar caracteres en nombres de platos
SELECT nombre,
       LEN(nombre) AS longitud_plato
FROM Platos;

--  Sentencias SELECT adicionales

-- . Listar platos creados en 2025
SELECT nombre, chef, categoria
FROM Platos
WHERE YEAR(fecha_creacion) = 2025;

-- . Obtener pedidos con información del cliente
SELECT p.codigo_pedido, p.descripcion, c.nombre, c.apellido
FROM Pedidos p
JOIN Platos pl ON p.id_plato = pl.id_plato
JOIN Clientes c ON pl.id_cliente = c.id_cliente;

-- . Mostrar equipos utilizados por chefs de cocina italiana
SELECT e.codigo_equipo, e.tipo_equipo, e.marca
FROM Equipos e
JOIN Chefs ch ON e.id_chef = ch.id_chef
WHERE ch.especialidad = 'Cocina Italiana';

--  Subconsultas
SELECT nombre, apellido
FROM Chefs
WHERE id_chef IN (SELECT id_chef FROM Asignaciones_Pedidos WHERE id_pedido = 1);

SELECT codigo_pedido
FROM Pedidos
WHERE id_plato IN (
    SELECT id_plato FROM Platos WHERE categoria = 'Postre'
);

SELECT id_pedido, codigo_pedido
FROM Pedidos
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Pedidos WHERE id_pedido = Pedidos.id_pedido AND id_chef = 2
);

--  UPDATE
UPDATE Chefs SET nombre = UPPER(nombre);
UPDATE Pedidos SET descripcion = 'Pedido actualizado';
UPDATE Asignaciones_Pedidos SET fecha_asignacion = DATEADD(DAY, 2, fecha_asignacion);

--  ALTER
ALTER TABLE Chefs ADD correo VARCHAR(50);
ALTER TABLE Platos ADD precio DECIMAL(10,2);
ALTER TABLE Equipos ALTER COLUMN tipo_equipo VARCHAR(50);


--  DELETE
DELETE FROM Preparaciones_Platos;
DELETE FROM Asignaciones_Pedidos;
DELETE FROM Equipos;

--  TRUNCATE
TRUNCATE TABLE Preparaciones_Platos;
TRUNCATE TABLE Asignaciones_Pedidos;
TRUNCATE TABLE Equipos;
;
--  DROP
DROP TABLE Preparaciones_Platos;
DROP TABLE Asignaciones_Pedidos;
DROP TABLE Equipos;
