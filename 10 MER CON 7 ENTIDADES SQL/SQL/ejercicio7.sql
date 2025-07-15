
-- Creación de la base de datos
CREATE DATABASE Escuela;
USE Escuela;

-- Tabla Profesores 
CREATE TABLE Profesores (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    asignatura VARCHAR(50),
    fecha_contratacion DATE
);

-- Tabla Estudiantes
CREATE TABLE Estudiantes (
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(255),
    telefono VARCHAR(15)
);

-- Tabla Cursos
CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    profesor VARCHAR(100) NOT NULL,
    nivel VARCHAR(50),
    fecha_inicio DATE,
    id_estudiante INT,
    FOREIGN KEY (id_estudiante) REFERENCES Estudiantes(id_estudiante)
);

-- Tabla Clases 
CREATE TABLE Clases (
    id_clase INT PRIMARY KEY,
    codigo_clase VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    fecha_clase DATETIME,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor)
);

-- Tabla Pivote: Asignaciones_Clases
CREATE TABLE Asignaciones_Clases (
    id_asignacion INT PRIMARY KEY,
    id_profesor INT,
    id_clase INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_profesor) REFERENCES Profesores(id_profesor),
    FOREIGN KEY (id_clase) REFERENCES Clases(id_clase)
);

-- Tabla Pivote: Tareas_Cursos
CREATE TABLE Tareas_Cursos (
    id_tarea INT PRIMARY KEY,
    id_curso INT,
    descripcion_tarea VARCHAR(500),
    tipo_tarea VARCHAR(50),
    fecha_entrega DATETIME,
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

-- Inserción de datos iniciales
INSERT INTO Estudiantes  VALUES
(1, 'Juan', 'Pérez', 'Calle 10 #23-45', '3001234567'),
(2, 'Sofía', 'Gómez', 'Avenida 5 #67-89', '3109876543'),
(3, 'María', 'Rodríguez', 'Carrera 15 #12-34', '3014567890');

INSERT INTO Profesores  VALUES
(1, 'Ana', 'Martínez', 'Matemáticas', '2020-08-10'),
(2, 'Carlos', 'López', 'Historia', '2021-05-15'),
(3, 'Luis', 'Ramírez', 'Ciencias', '2019-11-20');

INSERT INTO Cursos  VALUES
(1, 'Álgebra I', 'Ana Martínez', 'Secundaria', '2025-01-15', 1),
(2, 'Historia Moderna', 'Carlos López', 'Secundaria', '2025-02-10', 2),
(3, 'Biología Básica', 'Luis Ramírez', 'Secundaria', '2025-03-05', 3);

INSERT INTO Clases VALUES
(1, 'CLAS-001', 'Clase de álgebra lineal', '2025-07-10 08:00:00', 1),
(2, 'CLAS-002', 'Clase de revoluciones', '2025-06-25 14:00:00', 2),
(3, 'CLAS-003', 'Clase de biología celular', '2025-07-15 10:00:00', 3);

INSERT INTO Asignaciones_Clases  VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos VALUES
(1, 'EQP-001', 'Proyector', 'Epson', 1),
(2, 'EQP-002', 'Computadora', 'Dell', 2),
(3, 'EQP-003', 'Microscopio', 'Nikon', 3);

INSERT INTO Tareas_Cursos  VALUES
(1, 1, 'Resolver ecuaciones lineales', 'Tarea', '2025-07-12 09:00:00'),
(2, 2, 'Ensayo sobre la Revolución Francesa', 'Ensayo', '2025-06-27 15:00:00'),
(3, 3, 'Informe de laboratorio', 'Laboratorio', '2025-07-16 11:00:00');

--  Sentencias SQL con funciones aplicadas al MER
--. Concatenar asignatura y nombre del profesor
SELECT CONCAT(asignatura, ': ', nombre, ' ', apellido) AS profesor_asignatura
FROM Profesores;

-- . Calcular meses desde contratación
SELECT nombre, apellido,
       DATEDIFF(MONTH, fecha_contratacion, GETDATE()) AS meses_contratado
FROM Profesores;

--. Contar clases por trimestre
SELECT descripcion,
       DATEPART(QUARTER, fecha_clase) AS trimestre,
       COUNT(*) AS total_clases
FROM Clases
GROUP BY descripcion, DATEPART(QUARTER, fecha_clase);


-- . Mostrar apellidos de estudiantes en minúsculas
SELECT apellido,
       LOWER(apellido) AS apellido_minusculas
FROM Estudiantes;

-- . Obtener longitud de marcas de equipos
SELECT marca,
       LEN(marca) AS longitud_marca
FROM Equipos;


--  Sentencias SELECT adicionales
-- . Listar cursos iniciados en 2025
SELECT nombre, profesor, nivel
FROM Cursos
WHERE YEAR(fecha_inicio) = 2025;

-- . Obtener clases con información del estudiante
SELECT c.codigo_clase, c.descripcion, e.nombre, e.apellido
FROM Clases c
JOIN Cursos cu ON c.id_curso = cu.id_curso
JOIN Estudiantes e ON cu.id_estudiante = e.id_estudiante;


-- . Mostrar equipos utilizados por profesores de ciencias
SELECT e.codigo_equipo, e.tipo_equipo, e.marca
FROM Equipos e
JOIN Profesores p ON e.id_profesor = p.id_profesor
WHERE p.asignatura = 'Ciencias';

--  Subconsultas
SELECT nombre, apellido
FROM Profesores
WHERE id_profesor IN (SELECT id_profesor FROM Asignaciones_Clases WHERE id_clase = 1);

SELECT codigo_clase
FROM Clases
WHERE id_curso IN (
    SELECT id_curso FROM Cursos WHERE nivel = 'Secundaria'
);

SELECT nombre
FROM Estudiantes
WHERE id_estudiante NOT IN (
    SELECT id_estudiante FROM Cursos WHERE fecha_inicio > '2025-01-01'
);

SELECT id_clase, codigo_clase
FROM Clases
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Clases WHERE id_clase = Clases.id_clase AND id_profesor = 2
);

--  UPDATE
UPDATE Profesores SET nombre = UPPER(nombre);
UPDATE Estudiantes SET direccion = 'Calle 50 #10-20' WHERE id_estudiante = 1;
UPDATE Clases SET descripcion = 'Clase actualizada';

--  ALTER
ALTER TABLE Profesores ADD correo VARCHAR(50);
ALTER TABLE Cursos ADD duracion_meses INT;

--  DELETE
DELETE FROM Tareas_Cursos;
DELETE FROM Asignaciones_Clases;
DELETE FROM Equipos;


-- TRUNCATE
TRUNCATE TABLE Tareas_Cursos;
TRUNCATE TABLE Asignaciones_Clases;

--  DROP
DROP TABLE Tareas_Cursos;
DROP TABLE Asignaciones_Clases;

