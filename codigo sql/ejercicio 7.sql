-- Crear la base de datos
CREATE DATABASE Escuela;
USE Escuela;
GO

-- Crear procedimiento almacenado para inicializar la base de datos
CREATE PROCEDURE CrearBaseDeDatosEscuela
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Calificaciones', 'U') IS NOT NULL DROP TABLE Calificaciones;
    IF OBJECT_ID('Inscripciones', 'U') IS NOT NULL DROP TABLE Inscripciones;
    IF OBJECT_ID('Eventos', 'U') IS NOT NULL DROP TABLE Eventos;
    IF OBJECT_ID('Cursos', 'U') IS NOT NULL DROP TABLE Cursos;
    IF OBJECT_ID('Estudiantes', 'U') IS NOT NULL DROP TABLE Estudiantes;
    IF OBJECT_ID('Profesores', 'U') IS NOT NULL DROP TABLE Profesores;
    IF OBJECT_ID('Materias', 'U') IS NOT NULL DROP TABLE Materias;

    -- Tabla 1: Materias
    CREATE TABLE Materias (
        id_materia INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 2: Profesores
    CREATE TABLE Profesores (
        id_profesor INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 3: Estudiantes
    CREATE TABLE Estudiantes (
        id_estudiante INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Tabla 4: Cursos
    CREATE TABLE Cursos (
        id_curso INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        id_materia INT FOREIGN KEY REFERENCES Materias(id_materia),
        id_profesor INT FOREIGN KEY REFERENCES Profesores(id_profesor)
    );

    -- Tabla 5: Inscripciones
    CREATE TABLE Inscripciones (
        id_inscripcion INT PRIMARY KEY IDENTITY(1,1),
        id_estudiante INT FOREIGN KEY REFERENCES Estudiantes(id_estudiante),
        id_curso INT FOREIGN KEY REFERENCES Cursos(id_curso),
        fecha_inscripcion DATE NOT NULL
    );

    -- Tabla 6: Eventos
    CREATE TABLE Eventos (
        id_evento INT PRIMARY KEY IDENTITY(1,1),
        id_materia INT FOREIGN KEY REFERENCES Materias(id_materia),
        nombre VARCHAR(100) NOT NULL,
        fecha_evento DATE NOT NULL
    );

    -- Tabla 7: Calificaciones
    CREATE TABLE Calificaciones (
        id_calificacion INT PRIMARY KEY IDENTITY(1,1),
        id_estudiante INT FOREIGN KEY REFERENCES Estudiantes(id_estudiante),
        id_curso INT FOREIGN KEY REFERENCES Cursos(id_curso),
        nota DECIMAL(3,1) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Materias
    INSERT INTO Materias (nombre) VALUES 
    ('Matemáticas'),
    ('Lenguaje'),
    ('Ciencias'),
    ('Historia'),
    ('Inglés'),
    ('Arte'),
    ('Educación Física'),
    ('Tecnología'),
    ('Música'),
    ('Geografía');

    -- Insertar en Profesores
    INSERT INTO Profesores (nombre) VALUES 
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

    -- Insertar en Estudiantes con nombres reales y correos asociados
    INSERT INTO Estudiantes (nombre, email) VALUES 
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

    -- Insertar en Cursos
    INSERT INTO Cursos (nombre, id_materia, id_profesor) VALUES 
    ('Noveno A', 1, 1),
    ('Noveno B ', 2, 2),
    ('Noveno C', 3, 3),
    ('Decimo A ', 4, 4),
    ('Decimo B', 5, 5),
    ('Decimo C', 6, 6),
    ('Decimo D', 7, 7),
    ('Once A', 8, 8),
    ('Once B', 9, 9),
    ('Once C', 10, 10);

    -- Insertar en Inscripciones
    INSERT INTO Inscripciones (id_estudiante, id_curso, fecha_inscripcion) VALUES 
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
    INSERT INTO Eventos (id_materia, nombre, fecha_evento) VALUES 
    (1, 'Taller de Matemáticas', '2025-10-01'),
    (2, 'Feria de Literatura', '2025-10-02'),
    (3, 'Exposición de Ciencias', '2025-10-03'),
    (4, 'Conferencia de Historia', '2025-10-04'),
    (5, 'Club de Inglés', '2025-10-05'),
    (6, 'Galería de Arte', '2025-10-06'),
    (7, 'Torneo Deportivo', '2025-10-07'),
    (8, 'Hackathon Escolar', '2025-10-08'),
    (9, 'Concierto Escolar', '2025-10-09'),
    (10, 'Seminario de Geografía', '2025-10-10');

    -- Insertar en Calificaciones
    INSERT INTO Calificaciones (id_estudiante, id_curso, nota) VALUES 
    (1, 1, 4.5),
    (2, 2, 3.8),
    (3, 3, 4.0),
    (4, 4, 3.5),
    (5, 5, 4.2),
    (6, 6, 4.8),
    (7, 7, 3.7),
    (8, 8, 4.1),
    (9, 9, 4.9),
    (10, 10, 3.9);

    -- Consultas para verificar los datos
    SELECT * FROM Materias;
    SELECT * FROM Profesores;
    SELECT * FROM Estudiantes;
    SELECT * FROM Cursos;
    SELECT * FROM Inscripciones;
    SELECT * FROM Eventos;
    SELECT * FROM Calificaciones;
END;
GO

-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosEscuela;
GO

-- Vista 1: Materias y número de cursos
CREATE VIEW Vista_Materias_Cursos AS
SELECT m.nombre AS Materia, COUNT(c.id_curso) AS Total_Cursos
FROM Materias m
LEFT JOIN Cursos c ON m.id_materia = c.id_materia
GROUP BY m.nombre;

-- Vista 2: Inscripciones por estudiante
CREATE VIEW Vista_Inscripciones_Estudiante AS
SELECT e.nombre AS Estudiante, c.nombre AS Curso
FROM Estudiantes e
INNER JOIN Inscripciones i ON e.id_estudiante = i.id_estudiante
INNER JOIN Cursos c ON i.id_curso = c.id_curso;

-- Vista 3: Profesores y cursos asignados
CREATE VIEW Vista_Profesores_Cursos AS
SELECT p.nombre AS Profesor, COUNT(c.id_curso) AS Cursos_Asignados
FROM Profesores p
LEFT JOIN Cursos c ON p.id_profesor = c.id_profesor
GROUP BY p.nombre;

-- Vista 4: Calificaciones por estudiante
CREATE VIEW Vista_Calificaciones_Estudiante AS
SELECT e.nombre AS Estudiante, AVG(c.nota) AS Promedio_Nota
FROM Estudiantes e
INNER JOIN Calificaciones c ON e.id_estudiante = c.id_estudiante
GROUP BY e.nombre;

-- Vista 5: Eventos por materia
CREATE VIEW Vista_Eventos_Materia AS
SELECT m.nombre AS Materia, e.nombre AS Evento
FROM Materias m
INNER JOIN Eventos e ON m.id_materia = e.id_materia;

-- Consultas para verificar las vistas
SELECT * FROM Vista_Materias_Cursos;
SELECT * FROM Vista_Inscripciones_Estudiante;
SELECT * FROM Vista_Profesores_Cursos;
SELECT * FROM Vista_Calificaciones_Estudiante;
SELECT * FROM Vista_Eventos_Materia;