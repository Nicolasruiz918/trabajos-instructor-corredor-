-- Crear la base de datos
CREATE DATABASE Hotel;
USE Hotel;
GO

-- Crear procedimiento almacenado para inicializar la base de datos
CREATE PROCEDURE CrearBaseDeDatosHotel
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Pagos', 'U') IS NOT NULL DROP TABLE Pagos;
    IF OBJECT_ID('Reservas', 'U') IS NOT NULL DROP TABLE Reservas;
    IF OBJECT_ID('Eventos', 'U') IS NOT NULL DROP TABLE Eventos;
    IF OBJECT_ID('Habitaciones', 'U') IS NOT NULL DROP TABLE Habitaciones;
    IF OBJECT_ID('Huespedes', 'U') IS NOT NULL DROP TABLE Huespedes;
    IF OBJECT_ID('Empleados', 'U') IS NOT NULL DROP TABLE Empleados;
    IF OBJECT_ID('Tipos_Habitacion', 'U') IS NOT NULL DROP TABLE Tipos_Habitacion;

    -- Tabla 1: Tipos_Habitacion
    CREATE TABLE Tipos_Habitacion (
        id_tipo_habitacion INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 2: Empleados
    CREATE TABLE Empleados (
        id_empleado INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 3: Huespedes
    CREATE TABLE Huespedes (
        id_huesped INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Tabla 4: Habitaciones
    CREATE TABLE Habitaciones (
        id_habitacion INT PRIMARY KEY IDENTITY(1,1),
        numero VARCHAR(100) NOT NULL,
        id_tipo_habitacion INT FOREIGN KEY REFERENCES Tipos_Habitacion(id_tipo_habitacion),
        id_empleado INT FOREIGN KEY REFERENCES Empleados(id_empleado)
    );

    -- Tabla 5: Reservas
    CREATE TABLE Reservas (
        id_reserva INT PRIMARY KEY IDENTITY(1,1),
        id_huesped INT FOREIGN KEY REFERENCES Huespedes(id_huesped),
        id_habitacion INT FOREIGN KEY REFERENCES Habitaciones(id_habitacion),
        fecha_reserva DATE NOT NULL
    );

    -- Tabla 6: Eventos
    CREATE TABLE Eventos (
        id_evento INT PRIMARY KEY IDENTITY(1,1),
        id_tipo_habitacion INT FOREIGN KEY REFERENCES Tipos_Habitacion(id_tipo_habitacion),
        nombre VARCHAR(100) NOT NULL,
        fecha_evento DATE NOT NULL
    );

    -- Tabla 7: Pagos
    CREATE TABLE Pagos (
        id_pago INT PRIMARY KEY IDENTITY(1,1),
        id_huesped INT FOREIGN KEY REFERENCES Huespedes(id_huesped),
        monto DECIMAL(7,2) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Tipos_Habitacion
    INSERT INTO Tipos_Habitacion (nombre) VALUES 
    ('Estándar'),
    ('Deluxe'),
    ('Suite'),
    ('Familiar'),
    ('Ejecutiva'),
    ('Vista al Mar'),
    ('Habitación Doble'),
    ('Habitación Individual'),
    ('Presidencial'),
    ('Económica');

    -- Insertar en Empleados
    INSERT INTO Empleados (nombre) VALUES 
    ('Juan Pérez'),
    ('María Gómez'),
    ('Carlos López'),
    ('Ana Martínez'),
    ('Luis Fernández'),
    ('Sofía Ramírez'),
    ('Pedro Sánchez'),
    ('Laura Torres'),
    ('Diego Morales'),
    ('Elena Ruiz');

    -- Insertar en Huespedes con nombres reales y correos asociados
    INSERT INTO Huespedes (nombre, email) VALUES 
    ('Andrés Morales', 'andres.morales@email.com'),
    ('Camila Fernández', 'camila.fernandez@email.com'),
    ('Diego Ramírez', 'diego.ramirez@email.com'),
    ('Valentina López', 'valentina.lopez@email.com'),
    ('Santiago Gómez', 'santiago.gomez@email.com'),
    ('Isabela Torres', 'isabela.torres@email.com'),
    ('Mateo Vargas', 'mateo.vargas@email.com'),
    ('Sofía Mendoza', 'sofia.mendoza@email.com'),
    ('Lucas Ortiz', 'lucas.ortiz@email.com'),
    ('Gabriela Castro', 'gabriela.castro@email.com');

    -- Insertar en Habitaciones
    INSERT INTO Habitaciones (numero, id_tipo_habitacion, id_empleado) VALUES 
    ('101', 1, 1),
    ('202', 2, 2),
    ('303', 3, 3),
    ('404', 4, 4),
    ('505', 5, 5),
    ('606', 6, 6),
    ('707', 7, 7),
    ('808', 8, 8),
    ('909', 9, 9),
    ('1010', 10, 10);

    -- Insertar en Reservas
    INSERT INTO Reservas (id_huesped, id_habitacion, fecha_reserva) VALUES 
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

    -- Insertar en Eventos
    INSERT INTO Eventos (id_tipo_habitacion, nombre, fecha_evento) VALUES 
    (1, 'Desayuno Estándar', '2025-10-01'),
    (2, 'Cena Deluxe', '2025-10-02'),
    (3, 'Noche de Suite', '2025-10-03'),
    (4, 'Evento Familiar', '2025-10-04'),
    (5, 'Reunión Ejecutiva', '2025-10-05'),
    (6, 'Cóctel Vista al Mar', '2025-10-06'),
    (7, 'Tarde de Relax', '2025-10-07'),
    (8, 'Desayuno Individual', '2025-10-08'),
    (9, 'Gala Presidencial', '2025-10-09'),
    (10, 'Noche Económica', '2025-10-10');

    -- Insertar en Pagos
    INSERT INTO Pagos (id_huesped, monto) VALUES 
    (1, 100.000),
    (2, 150.000),
    (3, 200.000),
    (4, 120.000),
    (5, 180.000),
    (6, 90.000),
    (7, 110.000),
    (8, 130.000),
    (9, 250.000),
    (10, 80.000);

    -- Consultas para verificar los datos
    SELECT * FROM Tipos_Habitacion;
    SELECT * FROM Empleados;
    SELECT * FROM Huespedes;
    SELECT * FROM Habitaciones;
    SELECT * FROM Reservas;
    SELECT * FROM Eventos;
    SELECT * FROM Pagos;
END;
GO

-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosHotel;
GO

-- Vista 1: Tipos de habitación y número de habitaciones
CREATE VIEW Vista_Tipos_Habitacion AS
SELECT t.nombre AS Tipo_Habitacion, COUNT(h.id_habitacion) AS Total_Habitaciones
FROM Tipos_Habitacion t
LEFT JOIN Habitaciones h ON t.id_tipo_habitacion = h.id_tipo_habitacion
GROUP BY t.nombre;

-- Vista 2: Reservas por huésped
CREATE VIEW Vista_Reservas_Huesped AS
SELECT h.nombre AS Huesped, ha.numero AS Habitacion
FROM Huespedes h
INNER JOIN Reservas r ON h.id_huesped = r.id_huesped
INNER JOIN Habitaciones ha ON r.id_habitacion = ha.id_habitacion;

-- Vista 3: Empleados y habitaciones asignadas
CREATE VIEW Vista_Empleados_Habitaciones AS
SELECT e.nombre AS Empleado, COUNT(h.id_habitacion) AS Habitaciones_Asignadas
FROM Empleados e
LEFT JOIN Habitaciones h ON e.id_empleado = h.id_empleado
GROUP BY e.nombre;

-- Vista 4: Pagos por huésped
CREATE VIEW Vista_Pagos_Huesped AS
SELECT h.nombre AS Huesped, SUM(p.monto) AS Total_Pagos
FROM Huespedes h
INNER JOIN Pagos p ON h.id_huesped = p.id_huesped
GROUP BY h.nombre;

-- Vista 5: Eventos por tipo de habitación
CREATE VIEW Vista_Eventos_Tipo AS
SELECT t.nombre AS Tipo_Habitacion, e.nombre AS Evento
FROM Tipos_Habitacion t
INNER JOIN Eventos e ON t.id_tipo_habitacion = e.id_tipo_habitacion;

-- Consultas para verificar las vistas
SELECT * FROM Vista_Tipos_Habitacion;
SELECT * FROM Vista_Reservas_Huesped;
SELECT * FROM Vista_Empleados_Habitaciones;
SELECT * FROM Vista_Pagos_Huesped;
SELECT * FROM Vista_Eventos_Tipo;