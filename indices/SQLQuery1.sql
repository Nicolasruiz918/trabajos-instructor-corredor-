
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
    ('Informotica'), 
    ('Matematicas'), 
    ('Fisica'), 
    ('Quimica'), 
    ('Biologia'),
    ('Historia'), 
    ('Literatura'), 
    ('Economia'),
    ('Derecho'), 
    ('Psicologia');

    INSERT INTO Profesores (nombre, id_depto) VALUES 
    ('Juan Perez', 1), 
    ('Maria Garcia', 1),
    ('Carlos Lopez', 2), 
    ('Ana Martinez', 2),
    ('Luis Rodroguez', 3), 
    ('Sofia Hernandez', 3), 
    ('Pedro Gomez', 4), 
    ('Laura Diaz', 4),
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
    ('Programacion', 1), 
    ('Algoritmos', 1), 
    ('Calculo', 3), 
    ('Algebra', 3),
    ('Mecanica', 5), 
    ('Termodinamica', 5), 
    ('Quimica Organica', 7), 
    ('Quimica Inorganica', 7),
    ('Genetica', 9), 
    ('Ecologia', 9);

    INSERT INTO Cursos (id_mat, semestre) VALUES 
    (1, '2025-1'), 
    (2, '2025-1'), 
    (3, '2025-2'), 
    (4, '2025-2'), 
    (5, '2025-1'),
    (6, '2025-3'), 
    (7, '2025-3'), 
    (8, '2025-2'), 
    (9, '2025-2'), 
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
EXEC Crear_BaseDeDatosUniversidad;


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
-- 2. Vista: Estudiantes con calificaci�n y materia
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
-- 5. Vista: N�mero de profesores por departamento
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

      --index 

  --1 acelera los filtros por materia 
  CREATE NONCLUSTERED INDEX IX_Cursos_materia 
  ON Cursos (id_mat);
   -- 
     --2 acelera los filtros por notas  
  CREATE NONCLUSTERED INDEX IX_Notas_calificacion
  ON Notas (calificacion);
   -- 

   --3 mejora la busqueda de las materias por nombre 
   CREATE NONCLUSTERED INDEX   IX_Materias_Nombre
   ON Materias (nombre);

   -- 4 mejora la busqueda de las profesores por nombre 
   CREATE NONCLUSTERED INDEX IX_Profesores_Nombre
   ON Profesores (nombre);


   -- 5 mejora la busqueda  de los departamentos por nombre 
   CREATE NONCLUSTERED INDEX IX_Departamenos_Nombre 
   ON Departamentos (nombre);

   --  6 Mejora la búsqueda de notas por estudiante
CREATE NONCLUSTERED INDEX IX_Notas_IdEstudiante
ON Notas (id_insc);

--7  que no se repita los datos 
CREATE UNIQUE NONCLUSTERED INDEX IX_Estudiantes_email
ON Estudiantes (email);


    --verificar si el index funciona 
    --1
    SELECT * FROM Cursos WHERE id_mat = 1 ;

    --2
    SELECT * FROM  Notas WHERE calificacion > 8.0 ;
    --3
    SELECT * FROM Materias WHERE nombre like 'Programacion%';
    --4
    SELECT * FROM  Estudiantes   WHERE nombre LIKE 'kevin%';
    --5 
    SELECT * FROM Departamentos  WHERE nombre LIKE  'Informotica%';
     

     --6
     SELECT * FROM Notas WHERE id_insc = 2 ;

    -- 7
    INSERT INTO Estudiantes (nombre,email) VALUES
    ( 'samuel ', 'est1@email.com ');


    -- MOSTRAR EL DATO DE CADA EJECUCION 
    SET STATISTICS TIME ON ; 


     -- verificar que los indices esten creados 
    SELECT 
    t.name AS Tabla,
    i.name AS Indice,
    C.name AS Columna 
    FROM SYS.indexes i 
    INNER JOIN sys.tables t ON i.object_id =t.object_id
    INNER JOIN SYS.index_columns ic  ON i.object_id = ic.object_id AND i.index_id= ic.index_id
    inner JOIN sys.columns c ON  ic.object_id = c.object_id AND  ic.column_id = c.column_id
    WHERE t.name IN ('Cursos', 'Notas', 'Estudiantes ','Materias','Profesores' , 'Departamentos');