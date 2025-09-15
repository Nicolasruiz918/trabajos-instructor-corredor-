-- Crear la base de datos
CREATE DATABASE Restaurante;
USE Restaurante;
GO

-- Crear procedimiento almacenado para inicializar la base de datos
CREATE PROCEDURE CrearBaseDeDatosRestaurante
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Ventas', 'U') IS NOT NULL DROP TABLE Ventas;
    IF OBJECT_ID('Pedidos', 'U') IS NOT NULL DROP TABLE Pedidos;
    IF OBJECT_ID('Promociones', 'U') IS NOT NULL DROP TABLE Promociones;
    IF OBJECT_ID('Platillos', 'U') IS NOT NULL DROP TABLE Platillos;
    IF OBJECT_ID('Clientes', 'U') IS NOT NULL DROP TABLE Clientes;
    IF OBJECT_ID('Empleados', 'U') IS NOT NULL DROP TABLE Empleados;
    IF OBJECT_ID('Tipos_Platillo', 'U') IS NOT NULL DROP TABLE Tipos_Platillo;

    -- Tabla 1: Tipos_Platillo (sin dependencias)
    CREATE TABLE Tipos_Platillo (
        id_tipo_platillo INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 2: Empleados (sin dependencias)
    CREATE TABLE Empleados (
        id_empleado INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 3: Clientes (sin dependencias)
    CREATE TABLE Clientes (
        id_cliente INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Tabla 4: Platillos (depende de Tipos_Platillo y Empleados)
    CREATE TABLE Platillos (
        id_platillo INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        id_tipo_platillo INT FOREIGN KEY REFERENCES Tipos_Platillo(id_tipo_platillo),
        id_empleado INT FOREIGN KEY REFERENCES Empleados(id_empleado)
    );

    -- Tabla 5: Promociones (depende de Tipos_Platillo)
    CREATE TABLE Promociones (
        id_promocion INT PRIMARY KEY IDENTITY(1,1),
        id_tipo_platillo INT FOREIGN KEY REFERENCES Tipos_Platillo(id_tipo_platillo),
        nombre VARCHAR(100) NOT NULL,
        fecha_promocion DATE NOT NULL
    );

    -- Tabla 6: Pedidos (depende de Clientes y Platillos)
    CREATE TABLE Pedidos (
        id_pedido INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
        id_platillo INT FOREIGN KEY REFERENCES Platillos(id_platillo),
        fecha_pedido DATE NOT NULL
    );

    -- Tabla 7: Ventas (depende de Clientes y Pedidos)
    CREATE TABLE Ventas (
        id_venta INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
        id_pedido INT FOREIGN KEY REFERENCES Pedidos(id_pedido),
        precio_venta DECIMAL(7,2) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Tipos_Platillo
    INSERT INTO Tipos_Platillo (nombre) VALUES 
    ('Entradas'),
    ('Platos Fuertes'),
    ('Postres'),
    ('Bebidas'),
    ('Ensaladas'),
    ('Sopas'),
    ('Pizzas'),
    ('Pastas'),
    ('Desayunos'),
    ('Aperitivos');

    -- Insertar en Empleados
    INSERT INTO Empleados (nombre) VALUES 
    ('Alicia Torres'),
    ('Martín Vargas'),
    ('Sofía Guzmán'),
    ('Eduardo Peña'),
    ('Verónica Díaz'),
    ('Rafael Núñez'),
    ('Carmen Morales'),
    ('Óscar Romero'),
    ('Luz Hernández'),
    ('Diego Salazar');

    -- Insertar en Clientes con nombres reales y correos asociados
    INSERT INTO Clientes (nombre, email) VALUES 
    ('Ana Beltrán', 'ana.beltran@email.com'),
    ('Felipe Rojas', 'felipe.rojas@email.com'),
    ('Clara Ortiz', 'clara.ortiz@email.com'),
    ('Samuel Gómez', 'samuel.gomez@email.com'),
    ('Valeria Cruz', 'valeria.cruz@email.com'),
    ('Leonardo Paz', 'leonardo.paz@email.com'),
    ('Mónica Vega', 'monica.vega@email.com'),
    ('Ricardo Luna', 'ricardo.luna@email.com'),
    ('Juliana Méndez', 'juliana.mendez@email.com'),
    ('Tomás Rivas', 'tomas.rivas@email.com');

    -- Insertar en Platillos
    INSERT INTO Platillos (nombre, id_tipo_platillo, id_empleado) VALUES 
    ('Bruschetta', 1, 1),
    ('Filete Mignon', 2, 2),
    ('Tiramisú', 3, 3),
    ('Limonada Natural', 4, 4),
    ('Ensalada César', 5, 5),
    ('Sopa de Tomate', 6, 6),
    ('Pizza Margherita', 7, 7),
    ('Espagueti Carbonara', 8, 8),
    ('Huevos Rancheros', 9, 9),
    ('Alitas Picantes', 10, 10);

    -- Insertar en Promociones
    INSERT INTO Promociones (id_tipo_platillo, nombre, fecha_promocion) VALUES 
    (1, '2x1 en Entradas', '2025-10-01'),
    (2, 'Descuento en Platos Fuertes', '2025-10-02'),
    (3, 'Postre Gratis', '2025-10-03'),
    (4, 'Bebida sin Costo', '2025-10-04'),
    (5, 'Ensalada del Día', '2025-10-05'),
    (6, 'Sopa Gratis con Plato', '2025-10-06'),
    (7, 'Pizza Familiar', '2025-10-07'),
    (8, 'Pasta al 50%', '2025-10-08'),
    (9, 'Desayuno Completo', '2025-10-09'),
    (10, 'Aperitivos Gratis', '2025-10-10');

    -- Insertar en Pedidos
    INSERT INTO Pedidos (id_cliente, id_platillo, fecha_pedido) VALUES 
    (1, 1, '2025-09-01'),
    (2, 2, '2025-09-02'),
    (3, 3, '2025-09-03'),
    (4, 4, '2025-09-04'),
    (5, 5, '2025-09-05'),
    (6, 6, '2025-09-06'),
    (7, 7, '2025-09-07'),
    (8, 8, '2025-09-08'),
    (9, 9, '2025-09-09'),
    (10, 10, '2025-09-10');

    -- Insertar en Ventas
    INSERT INTO Ventas (id_cliente, id_pedido, precio_venta) VALUES 
    (1, 1, 15.00),
    (2, 2, 25.00),
    (3, 3, 10.00),
    (4, 4, 5.00),
    (5, 5, 12.00),
    (6, 6, 8.00),
    (7, 7, 20.00),
    (8, 8, 18.00),
    (9, 9, 14.00),
    (10, 10, 9.00);

    -- Consultas para verificar los datos
    SELECT * FROM Tipos_Platillo;
    SELECT * FROM Empleados;
    SELECT * FROM Clientes;
    SELECT * FROM Platillos;
    SELECT * FROM Promociones;
    SELECT * FROM Pedidos;
    SELECT * FROM Ventas;
END;
GO

-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosRestaurante;
GO

-- Vista 1: Tipos de platillo y número de platillos
CREATE VIEW Vista_Tipos_Platillo AS
SELECT t.nombre AS Tipo_Platillo, COUNT(p.id_platillo) AS Total_Platillos
FROM Tipos_Platillo t
LEFT JOIN Platillos p ON t.id_tipo_platillo = p.id_tipo_platillo
GROUP BY t.nombre;

-- Vista 2: Pedidos por cliente
CREATE VIEW Vista_Pedidos_Cliente AS
SELECT c.nombre AS Cliente, p.nombre AS Platillo
FROM Clientes c
INNER JOIN Pedidos ped ON c.id_cliente = ped.id_cliente
INNER JOIN Platillos p ON ped.id_platillo = p.id_platillo;

-- Vista 3: Empleados y platillos asignados
CREATE VIEW Vista_Empleados_Platillos AS
SELECT e.nombre AS Empleado, COUNT(p.id_platillo) AS Platillos_Asignados
FROM Empleados e
LEFT JOIN Platillos p ON e.id_empleado = p.id_empleado
GROUP BY e.nombre;

-- Vista 4: Ventas por cliente
CREATE VIEW Vista_Ventas_Cliente AS
SELECT c.nombre AS Cliente, SUM(v.precio_venta) AS Total_Ventas
FROM Clientes c
INNER JOIN Ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.nombre;

-- Vista 5: Promociones por tipo de platillo
CREATE VIEW Vista_Promociones_Tipo AS
SELECT t.nombre AS Tipo_Platillo, p.nombre AS Promocion
FROM Tipos_Platillo t
INNER JOIN Promociones p ON t.id_tipo_platillo = p.id_tipo_platillo;

-- Consultas para verificar las vistas
SELECT * FROM Vista_Tipos_Platillo;
SELECT * FROM Vista_Pedidos_Cliente;
SELECT * FROM Vista_Empleados_Platillos;
SELECT * FROM Vista_Ventas_Cliente;
SELECT * FROM Vista_Promociones_Tipo;