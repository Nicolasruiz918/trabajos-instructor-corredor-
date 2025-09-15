
CREATE DATABASE Universidad;
USE Universidad;
go

CREATE PROCEDURE Crear_BaseDeDatosUniversidad
AS
BEGIN

    -- Si existen las tablas, se borran en orden correcto
    IF OBJECT_ID('Notas', 'U') IS NOT NULL DROP TABLE Notas;
    IF OBJECT_ID('Inscripciones', 'U') IS NOT NULL DROP TABLE Inscripciones;
    IF OBJECT_ID('Cursos', 'U') IS NOT NULL DROP TABLE Cursos;
    IF OBJECT_ID('Materias', 'U') IS NOT NULL DROP TABLE Materias;
    IF OBJECT_ID('Estudiantes', 'U') IS NOT NULL DROP TABLE Estudiantes;
    IF OBJECT_ID('Profesores', 'U') IS NOT NULL DROP TABLE Profesores;
    IF OBJECT_ID('Departamentos', 'U') IS NOT NULL DROP TABLE Departamentos;





    -- Departamentos
    CREATE TABLE Departamentos (
        id_depto INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Profesores
    CREATE TABLE Profesores (
        id_prof INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        id_depto INT FOREIGN KEY REFERENCES Departamentos(id_depto)
    );

    -- Estudiantes
    CREATE TABLE Estudiantes (
        id_est INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Materias
    CREATE TABLE Materias (
        id_mat INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        id_prof INT FOREIGN KEY REFERENCES Profesores(id_prof)
    );

    -- Cursos
    CREATE TABLE Cursos (
        id_cur INT PRIMARY KEY IDENTITY(1,1),
        id_mat INT FOREIGN KEY REFERENCES Materias(id_mat),
        semestre VARCHAR(10) NOT NULL
    );

    -- Inscripciones
    CREATE TABLE Inscripciones (
        id_insc INT PRIMARY KEY IDENTITY(1,1),
        id_est INT FOREIGN KEY REFERENCES Estudiantes(id_est),
        id_cur INT FOREIGN KEY REFERENCES Cursos(id_cur)
    );

    -- Notas
    CREATE TABLE Notas (
        id_nota INT PRIMARY KEY IDENTITY(1,1),
        id_insc INT FOREIGN KEY REFERENCES Inscripciones(id_insc),
        calificacion DECIMAL(3,2) NOT NULL
    );

  
    INSERT INTO Departamentos (nombre) VALUES 
    ('Informática'), 
    ('Matemáticas'), 
    ('Física'), 
    ('Química'), 
    ('Biología'),
    ('Historia'), 
    ('Literatura'), 
    ('Economía'),
    ('Derecho'), 
    ('Psicología');

    INSERT INTO Profesores (nombre, id_depto) VALUES 
    ('Juan Pérez', 1), 
    ('María García', 1),
    ('Carlos López', 2), 
    ('Ana Martínez', 2),
    ('Luis Rodríguez', 3), 
    ('Sofía Hernández', 3), 
    ('Pedro Gómez', 4), 
    ('Laura Díaz', 4),
    ('Miguel Torres', 5), 
    ('Elena Ruiz', 5);

    INSERT INTO Estudiantes ( nombre , email) VALUES 
    ('Nicolas Ruiz', 'est1@email.com'), 
    ('Camilo suaza', 'est2@email.com'), 
    ('Santiago Rodriguez ', 'est3@email.com'),
    ('Mariana Sastoque ', 'est4@email.com'), 
    ('Laura Vanesa ', 'est5@email.com'), 
    ('Miguel angel ', 'est6@email.com'),
    (' Maria Jazmin ', 'est7@email.com'), 
    (' Tomas Garzon ', 'est8@email.com'), 
    ('Eliana Sarmiento ', 'est9@email.com'),
    ('Kevin Culma ', 'est10@email.com');

    INSERT INTO Materias (nombre, id_prof) VALUES 
    ('Programación', 1), 
    ('Algoritmos', 1), 
    ('Cálculo', 3), 
    ('Álgebra', 3),
    ('Mecánica', 5), 
    ('Termodinámica', 5), 
    ('Química Orgánica', 7), 
    ('Química Inorgánica', 7),
    ('Genética', 9), 
    ('Ecología', 9);

    INSERT INTO Cursos (id_mat, semestre) VALUES 
    (1, '2025-1'), 
    (2, '2025-1'), 
    (3, '2025-1'), 
    (4, '2025-1'), 
    (5, '2025-1'),
    (6, '2025-1'), 
    (7, '2025-1'), 
    (8, '2025-1'), 
    (9, '2025-1'), 
    (10, '2025-1');

    INSERT INTO Inscripciones (id_est, id_cur) VALUES 
    (1, 1), 
    (2, 2), 
    (3, 3), 
    (4, 4), 
    (5, 5), 
    (6, 6), 
    (7, 7), 
    (8, 8), 
    (9, 9), 
    (10, 10);

    INSERT INTO Notas (id_insc, calificacion) VALUES 
    (1, 8.5), 
    (2, 9.0), 
    (3, 7.5), 
    (4, 8.0), 
    (5, 9.5), 
    (6, 6.5), 
    (7, 7.0), 
    (8, 8.2), 
    (9, 9.2), 
    (10, 7.8);
   
    
    SELECT * FROM Departamentos ;
    SELECT * FROM Profesores ;
    SELECT * FROM Estudiantes;
    SELECT * FROM Materias ;
    SELECT * FROM Cursos;
    SELECT * FROM Inscripciones;
    SELECT * FROM Notas ;
     

END;
GO
-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosUniversidad;


go

-- 1. Vista: Estudiantes por semestre y materia
CREATE VIEW Vista_Estudiantes_Semestre_Materia AS
SELECT 
    e.nombre AS Estudiante, 
    c.semestre, 
    m.nombre AS Materia
FROM Estudiantes e
INNER JOIN Inscripciones i ON e.id_est = i.id_est
INNER JOIN Cursos c ON i.id_cur = c.id_cur
INNER JOIN Materias m ON c.id_mat = m.id_mat;
go
-- 2. Vista: Estudiantes con calificación y materia
CREATE VIEW Vista_Estudiantes_Calificaciones_Materia AS
SELECT 
    e.nombre AS Estudiante, 
    n.calificacion, 
    m.nombre AS Materia
FROM Estudiantes e
INNER JOIN Inscripciones i ON e.id_est = i.id_est
INNER JOIN Notas n ON i.id_insc = n.id_insc
INNER JOIN Cursos c ON i.id_cur = c.id_cur
INNER JOIN Materias m ON c.id_mat = m.id_mat;
go
-- 3. Vista: Profesores, materias y departamentos
CREATE VIEW Vista_Profesores_Materias_Departamentos AS
SELECT 
    p.nombre AS Profesor, 
    m.nombre AS Materia, 
    d.nombre AS Departamento
FROM Profesores p
INNER JOIN Materias m ON p.id_prof = m.id_prof
INNER JOIN Departamentos d ON p.id_depto = d.id_depto;
go
-- 4. Vista: Semestre, materia y profesor encargado
CREATE VIEW Vista_Cursos_Semestre_Materia_Profesor AS
SELECT 
    c.semestre, 
    m.nombre AS Materia, 
    p.nombre AS Profesor
FROM Cursos c
INNER JOIN Materias m ON c.id_mat = m.id_mat
INNER JOIN Profesores p ON m.id_prof = p.id_prof;
go
-- 5. Vista: Número de profesores por departamento
CREATE VIEW Vista_Profesores_Por_Departamento AS
SELECT 
    d.nombre AS Departamento, 
    COUNT(p.id_prof) AS NumeroProfesores
FROM Departamentos d
LEFT JOIN Profesores p ON d.id_depto = p.id_depto
GROUP BY d.id_depto, d.nombre;



    SELECT * FROM Vista_Estudiantes_Semestre_Materia ;
    SELECT * FROM Vista_Estudiantes_Calificaciones_Materia ;
    SELECT * FROM Vista_Profesores_Materias_Departamentos ;
    SELECT * FROM Vista_Cursos_Semestre_Materia_Profesor ;
    SELECT * FROM Vista_Profesores_Por_Departamento ;