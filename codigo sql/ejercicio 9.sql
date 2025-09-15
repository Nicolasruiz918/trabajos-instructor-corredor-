-- Crear la base de datos
CREATE DATABASE RentaCarros;
USE RentaCarros;
GO

-- Crear procedimiento almacenado para inicializar la base de datos
CREATE PROCEDURE CrearBaseDeDatosRentaCarros
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Ventas', 'U') IS NOT NULL DROP TABLE Ventas;
    IF OBJECT_ID('Rentas', 'U') IS NOT NULL DROP TABLE Rentas;
    IF OBJECT_ID('Promociones', 'U') IS NOT NULL DROP TABLE Promociones;
    IF OBJECT_ID('Vehiculos', 'U') IS NOT NULL DROP TABLE Vehiculos;
    IF OBJECT_ID('Clientes', 'U') IS NOT NULL DROP TABLE Clientes;
    IF OBJECT_ID('Empleados', 'U') IS NOT NULL DROP TABLE Empleados;
    IF OBJECT_ID('Tipos_Vehiculo', 'U') IS NOT NULL DROP TABLE Tipos_Vehiculo;

    -- Tabla 1: Tipos_Vehiculo (sin dependencias)
    CREATE TABLE Tipos_Vehiculo (
        id_tipo_vehiculo INT PRIMARY KEY IDENTITY(1,1),
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

    -- Tabla 4: Vehiculos (depende de Tipos_Vehiculo y Empleados)
    CREATE TABLE Vehiculos (
        id_vehiculo INT PRIMARY KEY IDENTITY(1,1),
        matricula VARCHAR(100) NOT NULL,
        id_tipo_vehiculo INT FOREIGN KEY REFERENCES Tipos_Vehiculo(id_tipo_vehiculo),
        id_empleado INT FOREIGN KEY REFERENCES Empleados(id_empleado)
    );

    -- Tabla 5: Promociones (depende de Tipos_Vehiculo)
    CREATE TABLE Promociones (
        id_promocion INT PRIMARY KEY IDENTITY(1,1),
        id_tipo_vehiculo INT FOREIGN KEY REFERENCES Tipos_Vehiculo(id_tipo_vehiculo),
        nombre VARCHAR(100) NOT NULL,
        fecha_promocion DATE NOT NULL
    );

    -- Tabla 6: Rentas (depende de Clientes y Vehiculos)
    CREATE TABLE Rentas (
        id_renta INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
        id_vehiculo INT FOREIGN KEY REFERENCES Vehiculos(id_vehiculo),
        fecha_renta DATE NOT NULL
    );

    -- Tabla 7: Ventas (depende de Clientes y Rentas)
    CREATE TABLE Ventas (
        id_venta INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
        id_renta INT FOREIGN KEY REFERENCES Rentas(id_renta),
        precio_venta DECIMAL(7,2) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Tipos_Vehiculo
    INSERT INTO Tipos_Vehiculo (nombre) VALUES 
    ('Sedán'),
    ('SUV'),
    ('Camioneta'),
    ('Deportivo'),
    ('Económico'),
    ('Lujo'),
    ('Furgoneta'),
    ('Convertible'),
    ('Híbrido'),
    ('Eléctrico');

    -- Insertar en Empleados
    INSERT INTO Empleados (nombre) VALUES 
    ('Fernanda López'),
    ('Ricardo Gómez'),
    ('Paula Ramírez'),
    ('Tomás Morales'),
    ('Clara Fernández'),
    ('Ignacio Vega'),
    ('Lorena Castillo'),
    ('Héctor Sánchez'),
    ('Marina Ortiz'),
    ('Gabriel Ruiz');

    -- Insertar en Clientes con nombres reales y correos asociados
    INSERT INTO Clientes (nombre, email) VALUES 
    ('Elena Navarro', 'elena.navarro@email.com'),
    ('Mateo Silva', 'mateo.silva@email.com'),
    ('Lucía Mendoza', 'lucia.mendoza@email.com'),
    ('Daniel Castro', 'daniel.castro@email.com'),
    ('Sofía Paredes', 'sofia.paredes@email.com'),
    ('Juan Delgado', 'juan.delgado@email.com'),
    ('Carolina Bravo', 'carolina.bravo@email.com'),
    ('Pablo Acosta', 'pablo.acosta@email.com'),
    ('María Rivas', 'maria.rivas@email.com'),
    ('Andrés Prado', 'andres.prado@email.com');

    -- Insertar en Vehiculos
    INSERT INTO Vehiculos (matricula, id_tipo_vehiculo, id_empleado) VALUES 
    ('ABC123', 1, 1),
    ('XYZ789', 2, 2),
    ('DEF456', 3, 3),
    ('GHI012', 4, 4),
    ('JKL345', 5, 5),
    ('MNO678', 6, 6),
    ('PQR901', 7, 7),
    ('STU234', 8, 8),
    ('VWX567', 9, 9),
    ('YZA890', 10, 10);

    -- Insertar en Promociones
    INSERT INTO Promociones (id_tipo_vehiculo, nombre, fecha_promocion) VALUES 
    (1, 'Descuento Sedán', '2025-10-01'),
    (2, 'Oferta SUV', '2025-10-02'),
    (3, 'Promoción Camioneta', '2025-10-03'),
    (4, 'Renta Deportiva', '2025-10-04'),
    (5, 'Económico al 50%', '2025-10-05'),
    (6, 'Lujo Exclusivo', '2025-10-06'),
    (7, 'Furgoneta Familiar', '2025-10-07'),
    (8, 'Convertible Verano', '2025-10-08'),
    (9, 'Híbrido Ecológico', '2025-10-09'),
    (10, 'Eléctrico Sin Costo Extra', '2025-10-10');

    -- Insertar en Rentas
    INSERT INTO Rentas (id_cliente, id_vehiculo, fecha_renta) VALUES 
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
    INSERT INTO Ventas (id_cliente, id_renta, precio_venta) VALUES 
    (1, 1, 75.00),
    (2, 2, 120.00),
    (3, 3, 90.00),
    (4, 4, 150.00),
    (5, 5, 60.00),
    (6, 6, 200.00),
    (7, 7, 100.00),
    (8, 8, 130.00),
    (9, 9, 180.00),
    (10, 10, 80.00);

    -- Consultas para verificar los datos
    SELECT * FROM Tipos_Vehiculo;
    SELECT * FROM Empleados;
    SELECT * FROM Clientes;
    SELECT * FROM Vehiculos;
    SELECT * FROM Promociones;
    SELECT * FROM Rentas;
    SELECT * FROM Ventas;
END;
GO

-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosRentaCarros;
GO

-- Vista 1: Tipos de vehículo y número de vehículos
CREATE VIEW Vista_Tipos_Vehiculo AS
SELECT t.nombre AS Tipo_Vehiculo, COUNT(v.id_vehiculo) AS Total_Vehiculos
FROM Tipos_Vehiculo t
LEFT JOIN Vehiculos v ON t.id_tipo_vehiculo = v.id_tipo_vehiculo
GROUP BY t.nombre;

-- Vista 2: Rentas por cliente
CREATE VIEW Vista_Rentas_Cliente AS
SELECT c.nombre AS Cliente, v.matricula AS Vehiculo
FROM Clientes c
INNER JOIN Rentas r ON c.id_cliente = r.id_cliente
INNER JOIN Vehiculos v ON r.id_vehiculo = v.id_vehiculo;

-- Vista 3: Empleados y vehículos asignados
CREATE VIEW Vista_Empleados_Vehiculos AS
SELECT e.nombre AS Empleado, COUNT(v.id_vehiculo) AS Vehiculos_Asignados
FROM Empleados e
LEFT JOIN Vehiculos v ON e.id_empleado = v.id_empleado
GROUP BY e.nombre;

-- Vista 4: Ventas por cliente
CREATE VIEW Vista_Ventas_Cliente AS
SELECT c.nombre AS Cliente, SUM(v.precio_venta) AS Total_Ventas
FROM Clientes c
INNER JOIN Ventas v ON c.id_cliente = v.id_cliente
GROUP BY c.nombre;

-- Vista 5: Promociones por tipo de vehículo
CREATE VIEW Vista_Promociones_Tipo AS
SELECT t.nombre AS Tipo_Vehiculo, p.nombre AS Promocion
FROM Tipos_Vehiculo t
INNER JOIN Promociones p ON t.id_tipo_vehiculo = p.id_tipo_vehiculo;

-- Consultas para verificar las vistas
SELECT * FROM Vista_Tipos_Vehiculo;
SELECT * FROM Vista_Rentas_Cliente;
SELECT * FROM Vista_Empleados_Vehiculos;
SELECT * FROM Vista_Ventas_Cliente;
SELECT * FROM Vista_Promociones_Tipo;