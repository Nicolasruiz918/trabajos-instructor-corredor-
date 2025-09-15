-- Crear la base de datos
CREATE DATABASE EmpresaEventos;
USE EmpresaEventos;
GO

-- Crear procedimiento almacenado para inicializar la base de datos
CREATE PROCEDURE CrearBaseDeDatosEventos
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Pagos', 'U') IS NOT NULL DROP TABLE Pagos;
    IF OBJECT_ID('Participaciones', 'U') IS NOT NULL DROP TABLE Participaciones;
    IF OBJECT_ID('Actividades', 'U') IS NOT NULL DROP TABLE Actividades;
    IF OBJECT_ID('Servicios', 'U') IS NOT NULL DROP TABLE Servicios;
    IF OBJECT_ID('Clientes', 'U') IS NOT NULL DROP TABLE Clientes;
    IF OBJECT_ID('Organizadores', 'U') IS NOT NULL DROP TABLE Organizadores;
    IF OBJECT_ID('Tipos_Evento', 'U') IS NOT NULL DROP TABLE Tipos_Evento;

    -- Tabla 1: Tipos_Evento
    CREATE TABLE Tipos_Evento (
        id_tipo_evento INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 2: Organizadores
    CREATE TABLE Organizadores (
        id_organizador INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 3: Clientes
    CREATE TABLE Clientes (
        id_cliente INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Tabla 4: Servicios
    CREATE TABLE Servicios (
        id_servicio INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        id_tipo_evento INT FOREIGN KEY REFERENCES Tipos_Evento(id_tipo_evento),
        id_organizador INT FOREIGN KEY REFERENCES Organizadores(id_organizador)
    );

    -- Tabla 5: Participaciones
    CREATE TABLE Participaciones (
        id_participacion INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
        id_servicio INT FOREIGN KEY REFERENCES Servicios(id_servicio),
        fecha_participacion DATE NOT NULL
    );

    -- Tabla 6: Actividades
    CREATE TABLE Actividades (
        id_actividad INT PRIMARY KEY IDENTITY(1,1),
        id_tipo_evento INT FOREIGN KEY REFERENCES Tipos_Evento(id_tipo_evento),
        nombre VARCHAR(100) NOT NULL,
        fecha_actividad DATE NOT NULL
    );

    -- Tabla 7: Pagos
    CREATE TABLE Pagos (
        id_pago INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT FOREIGN KEY REFERENCES Clientes(id_cliente),
        monto DECIMAL(7,3) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Tipos_Evento
    INSERT INTO Tipos_Evento (nombre) VALUES 
    ('Boda'),
    ('Conferencia'),
    ('Fiesta Corporativa'),
    ('Cumpleaños'),
    ('Seminario'),
    ('Concierto'),
    ('Evento Deportivo'),
    ('Gala Benéfica'),
    ('Taller'),
    ('Festival');

    -- Insertar en Organizadores
    INSERT INTO Organizadores (nombre) VALUES 
    ('Claudia Rojas'),
    ('Felipe Navarro'),
    ('Valeria Castro'),
    ('Rodrigo Méndez'),
    ('Carolina Silva'),
    ('Javier Duarte'),
    ('Patricia Vega'),
    ('Andrés Salazar'),
    ('Mónica Paredes'),
    ('Esteban Cruz');

    -- Insertar en Clientes con nombres reales y correos asociados
    INSERT INTO Clientes (nombre, email) VALUES 
    ('Laura Benítez', 'laura.benitez@email.com'),
    ('Sebastián Rivas', 'sebastian.rivas@email.com'),
    ('Martina Delgado', 'martina.delgado@email.com'),
    ('Nicolás Bravo', 'nicolas.bravo@email.com'),
    ('Catalina Muñoz', 'catalina.munoz@email.com'),
    ('Felipe Acosta', 'felipe.acosta@email.com'),
    ('Valeria Ortiz', 'valeria.ortiz@email.com'),
    ('Joaquín Reyes', 'joaquin.reyes@email.com'),
    ('Camila Prado', 'camila.prado@email.com'),
    ('Emiliano Vargas', 'emiliano.vargas@email.com');

    -- Insertar en Servicios
    INSERT INTO Servicios (nombre, id_tipo_evento, id_organizador) VALUES 
    ('Decoración Floral', 1, 1),
    ('Montaje Audiovisual', 2, 2),
    ('Catering Corporativo', 3, 3),
    ('Torta Personalizada', 4, 4),
    ('Charla Motivacional', 5, 5),
    ('Sonido en Vivo', 6, 6),
    ('Organización de Carrera', 7, 7),
    ('Subasta', 8, 8),
    ('Taller Práctico', 9, 9),
    ('Escenario Principal', 10, 10);

    -- Insertar en Participaciones
    INSERT INTO Participaciones (id_cliente, id_servicio, fecha_participacion) VALUES 
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

    -- Insertar en Actividades
    INSERT INTO Actividades (id_tipo_evento, nombre, fecha_actividad) VALUES 
    (1, 'Ceremonia de Boda', '2025-10-01'),
    (2, 'Conferencia Principal', '2025-10-02'),
    (3, 'Fiesta de Gala', '2025-10-03'),
    (4, 'Fiesta Infantil', '2025-10-04'),
    (5, 'Seminario de Liderazgo', '2025-10-05'),
    (6, 'Concierto al Aire Libre', '2025-10-06'),
    (7, 'Maratón 5K', '2025-10-07'),
    (8, 'Cena Benéfica', '2025-10-08'),
    (9, 'Taller de Innovación', '2025-10-09'),
    (10, 'Festival Cultural', '2025-10-10');

    -- Insertar en Pagos
    INSERT INTO Pagos (id_cliente, monto) VALUES 
    (1, 500.000),
    (2, 750.000),
    (3, 300.000),
    (4, 200.000),
    (5, 400.000),
    (6, 350.000),
    (7, 600.000),
    (8, 450.000),
    (9, 800.000),
    (10, 250.000);

    -- Consultas para verificar los datos
    SELECT * FROM Tipos_Evento;
    SELECT * FROM Organizadores;
    SELECT * FROM Clientes;
    SELECT * FROM Servicios;
    SELECT * FROM Participaciones;
    SELECT * FROM Actividades;
    SELECT * FROM Pagos;
END;
GO

-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosEventos;
GO

-- Vista 1: Tipos de evento y número de servicios
CREATE VIEW Vista_Tipos_Evento AS
SELECT t.nombre AS Tipo_Evento, COUNT(s.id_servicio) AS Total_Servicios
FROM Tipos_Evento t
LEFT JOIN Servicios s ON t.id_tipo_evento = s.id_tipo_evento
GROUP BY t.nombre;

-- Vista 2: Participaciones por cliente
CREATE VIEW Vista_Participaciones_Cliente AS
SELECT c.nombre AS Cliente, s.nombre AS Servicio
FROM Clientes c
INNER JOIN Participaciones p ON c.id_cliente = p.id_cliente
INNER JOIN Servicios s ON p.id_servicio = s.id_servicio;

-- Vista 3: Organizadores y servicios asignados
CREATE VIEW Vista_Organizadores_Servicios AS
SELECT o.nombre AS Organizador, COUNT(s.id_servicio) AS Servicios_Asignados
FROM Organizadores o
LEFT JOIN Servicios s ON o.id_organizador = s.id_organizador
GROUP BY o.nombre;

-- Vista 4: Pagos por cliente
CREATE VIEW Vista_Pagos_Cliente AS
SELECT c.nombre AS Cliente, SUM(p.monto) AS Total_Pagos
FROM Clientes c
INNER JOIN Pagos p ON c.id_cliente = p.id_cliente
GROUP BY c.nombre;

-- Vista 5: Actividades por tipo de evento
CREATE VIEW Vista_Actividades_Tipo AS
SELECT t.nombre AS Tipo_Evento, a.nombre AS Actividad
FROM Tipos_Evento t
INNER JOIN Actividades a ON t.id_tipo_evento = a.id_tipo_evento;

-- Consultas para verificar las vistas
SELECT * FROM Vista_Tipos_Evento;
SELECT * FROM Vista_Participaciones_Cliente;
SELECT * FROM Vista_Organizadores_Servicios;
SELECT * FROM Vista_Pagos_Cliente;
SELECT * FROM Vista_Actividades_Tipo;