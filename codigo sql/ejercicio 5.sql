-- Crear la base de datos
CREATE DATABASE Gimnasio;
USE Gimnasio;
GO

-- Crear procedimiento almacenado para inicializar la base de datos
CREATE PROCEDURE CrearBaseDeDatosGimnasio
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Pagos', 'U') IS NOT NULL DROP TABLE Pagos;
    IF OBJECT_ID('Asistencias', 'U') IS NOT NULL DROP TABLE Asistencias;
    IF OBJECT_ID('Clases', 'U') IS NOT NULL DROP TABLE Clases;
    IF OBJECT_ID('Ejercicios', 'U') IS NOT NULL DROP TABLE Ejercicios;
    IF OBJECT_ID('Miembros', 'U') IS NOT NULL DROP TABLE Miembros;
    IF OBJECT_ID('Entrenadores', 'U') IS NOT NULL DROP TABLE Entrenadores;
    IF OBJECT_ID('Tipos_Entrenamiento', 'U') IS NOT NULL DROP TABLE Tipos_Entrenamiento;

    -- Tabla 1: Tipos_Entrenamiento
    CREATE TABLE Tipos_Entrenamiento (
        id_tipo_entrenamiento INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 2: Entrenadores
    CREATE TABLE Entrenadores (
        id_entrenador INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 3: Miembros
    CREATE TABLE Miembros (
        id_miembro INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Tabla 4: Ejercicios
    CREATE TABLE Ejercicios (
        id_ejercicio INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        id_tipo_entrenamiento INT FOREIGN KEY REFERENCES Tipos_Entrenamiento(id_tipo_entrenamiento),
        id_entrenador INT FOREIGN KEY REFERENCES Entrenadores(id_entrenador)
    );

    -- Tabla 5: Asistencias
    CREATE TABLE Asistencias (
        id_asistencia INT PRIMARY KEY IDENTITY(1,1),
        id_miembro INT FOREIGN KEY REFERENCES Miembros(id_miembro),
        id_ejercicio INT FOREIGN KEY REFERENCES Ejercicios(id_ejercicio),
        fecha_asistencia DATE NOT NULL
    );

    -- Tabla 6: Clases
    CREATE TABLE Clases (
        id_clase INT PRIMARY KEY IDENTITY(1,1),
        id_tipo_entrenamiento INT FOREIGN KEY REFERENCES Tipos_Entrenamiento(id_tipo_entrenamiento),
        nombre VARCHAR(100) NOT NULL,
        fecha_clase DATE NOT NULL
    );

    -- Tabla 7: Pagos
    CREATE TABLE Pagos (
        id_pago INT PRIMARY KEY IDENTITY(1,1),
        id_miembro INT FOREIGN KEY REFERENCES Miembros(id_miembro),
        monto DECIMAL(7,2) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Tipos_Entrenamiento
    INSERT INTO Tipos_Entrenamiento (nombre) VALUES 
    ('Cardio'),
    ('Fuerza'),
    ('Yoga'),
    ('CrossFit'),
    ('Pilates'),
    ('Zumba'),
    ('Spinning'),
    ('Entrenamiento Funcional'),
    ('Boxeo'),
    ('HIIT');

    -- Insertar en Entrenadores
    INSERT INTO Entrenadores (nombre) VALUES 
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

    -- Insertar en Miembros con nombres reales y correos asociados
    INSERT INTO Miembros (nombre, email) VALUES 
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

    -- Insertar en Ejercicios
    INSERT INTO Ejercicios (nombre, id_tipo_entrenamiento, id_entrenador) VALUES 
    ('Cinta de Correr', 1, 1),
    ('Press de Banca', 2, 2),
    ('Postura del Árbol', 3, 3),
    ('Burpees', 4, 4),
    ('Reformer', 5, 5),
    ('Baile Zumba', 6, 6),
    ('Ciclismo Indoor', 7, 7),
    ('Kettlebell Swing', 8, 8),
    ('Sacos de Boxeo', 9, 9),
    ('Sprint Interválico', 10, 10);

    -- Insertar en Asistencias
    INSERT INTO Asistencias (id_miembro, id_ejercicio, fecha_asistencia) VALUES 
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

    -- Insertar en Clases
    INSERT INTO Clases (id_tipo_entrenamiento, nombre, fecha_clase) VALUES 
    (1, 'Clase de Cardio Intenso', '2025-10-01'),
    (2, 'Entrenamiento de Fuerza', '2025-10-02'),
    (3, 'Yoga Restaurativo', '2025-10-03'),
    (4, 'CrossFit Avanzado', '2025-10-04'),
    (5, 'Pilates Mat', '2025-10-05'),
    (6, 'Zumba Party', '2025-10-06'),
    (7, 'Spinning Nocturno', '2025-10-07'),
    (8, 'Funcional Total', '2025-10-08'),
    (9, 'Clase de Boxeo', '2025-10-09'),
    (10, 'HIIT Explosivo', '2025-10-10');

    -- Insertar en Pagos
    INSERT INTO Pagos (id_miembro, monto) VALUES 
    (1, 50.000),
    (2, 75.000),
    (3, 20.000),
    (4, 10.000),
    (5, 30.000),
    (6, 25.000),
    (7, 80.000),
    (8, 45.000),
    (9, 60.000),
    (10, 90.000);

    -- Consultas para verificar los datos
    SELECT * FROM Tipos_Entrenamiento;
    SELECT * FROM Entrenadores;
    SELECT * FROM Miembros;
    SELECT * FROM Ejercicios;
    SELECT * FROM Asistencias;
    SELECT * FROM Clases;
    SELECT * FROM Pagos;
END;
GO

-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosGimnasio;
GO

-- Vista 1: Ejercicios por tipo de entrenamiento
CREATE VIEW Vista_Ejercicios_Por_Tipo AS
SELECT t.nombre AS Tipo_Entrenamiento, e.nombre AS Ejercicio, en.nombre AS Entrenador
FROM Tipos_Entrenamiento t
INNER JOIN Ejercicios e ON t.id_tipo_entrenamiento = e.id_tipo_entrenamiento
INNER JOIN Entrenadores en ON e.id_entrenador = en.id_entrenador;

-- Vista 2: Asistencias por miembro
CREATE VIEW Vista_Asistencias_Por_Miembro AS
SELECT m.nombre AS Miembro, e.nombre AS Ejercicio, a.fecha_asistencia AS Fecha_Asistencia
FROM Miembros m
INNER JOIN Asistencias a ON m.id_miembro = a.id_miembro
INNER JOIN Ejercicios e ON a.id_ejercicio = e.id_ejercicio;

-- Vista 3: Entrenadores y número de ejercicios
CREATE VIEW Vista_Entrenadores_Y_Ejercicios AS
SELECT en.nombre AS Entrenador, COUNT(e.id_ejercicio) AS Numero_Ejercicios
FROM Entrenadores en
LEFT JOIN Ejercicios e ON en.id_entrenador = e.id_entrenador
GROUP BY en.id_entrenador, en.nombre;

-- Vista 4: Pagos por miembro
CREATE VIEW Vista_Pagos_Por_Miembro AS
SELECT m.nombre AS Miembro, SUM(p.monto) AS Total_Pagos
FROM Miembros m
INNER JOIN Pagos p ON m.id_miembro = p.id_miembro
GROUP BY m.id_miembro, m.nombre;

-- Vista 5: Clases por tipo de entrenamiento
CREATE VIEW Vista_Clases_Por_Tipo AS
SELECT t.nombre AS Tipo_Entrenamiento, c.nombre AS Clase, c.fecha_clase AS Fecha_Clase
FROM Tipos_Entrenamiento t
INNER JOIN Clases c ON t.id_tipo_entrenamiento = c.id_tipo_entrenamiento;

-- Consultas para verificar las vistas
SELECT * FROM Vista_Ejercicios_Por_Tipo;
SELECT * FROM Vista_Asistencias_Por_Miembro;
SELECT * FROM Vista_Entrenadores_Y_Ejercicios;
SELECT * FROM Vista_Pagos_Por_Miembro;
SELECT * FROM Vista_Clases_Por_Tipo;  