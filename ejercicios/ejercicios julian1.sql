-- Trabajo Julian David Obregon 
-- MER 1 : universidad 



-- no puso el create database 
CREATE DATABASE universidad;
USE universidad;


-- Crear la tabla estudiantes
CREATE TABLE estudiantes(
    id_estudiante INT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT,
    carrera VARCHAR(100)
);

-- Crear la tabla profesores
CREATE TABLE profesores (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100),
    departamento VARCHAR(100)
);

-- Crear la tabla de cursos
CREATE TABLE cursos (
    id_cursos INT PRIMARY KEY,
    nombre VARCHAR(100),
    id_profesor INT,
    FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor)
);

-- Crear la tabla de inscripciones
CREATE TABLE inscripciones (
    id_inscripcion INT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    fecha DATE,
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_cursos)
);




-- Insertar datos iniciales
-- agrego muy pocos  datos  hizo uno solo por cada tabla con un solo dato asi que yo le agrege 4 mas acada insert  

INSERT INTO estudiantes VALUES 
(1, 'Ana Gomez', 20, 'Ingenieria'),
(2, 'Carlos Ruiz', 22, 'Medicina'),
(3, 'Maria Lopez', 21, 'Derecho'),
(4, 'Pedro Sanchez', 19, 'Arquitectura'),
(5, 'Luisa Fernandez', 23, 'Economia');

INSERT INTO profesores VALUES 
(1, 'Dr. Perez', 'Ciencias'),
(2, 'Dra. Martinez', 'Medicina'),
(3, 'Dr. Rodriguez', 'Derecho'),
(4, 'Dra. Garcia', 'Artes'),
(5, 'Dr. Jimenez', 'Economia');

INSERT INTO cursos VALUES 
(1, 'Fisica', 1),
(2, 'Anatomia', 2),
(3, 'Derecho Civil', 3),
(4, 'Historia del Arte', 4),
(5, 'Macroeconomia', 5);

INSERT INTO inscripciones VALUES 
(1, 1, 1, '2025-04-14'),
(2, 2, 2, '2025-04-15'),
(3, 3, 3, '2025-04-16'),
(4, 4, 4, '2025-04-17'),
(5, 5, 5, '2025-04-18');


-- Actualización de datos  "hizo solo un update "

UPDATE estudiantes SET edad = 21 WHERE id_estudiante = 1;
UPDATE cursos SET nombre = 'Física Avanzada' WHERE id_cursos = 1;

-- Consultas SELECT "solo hizo el select con el join "

-- 1. Mostrar todos los estudiantes
SELECT * FROM estudiantes;

-- 2. Mostrar estudiantes de ingeniería
SELECT nombre, edad FROM estudiantes WHERE carrera = 'Ingenieria';

-- 3. Consulta compleja con JOINs
SELECT 
    E.nombre AS estudiante,
    C.nombre AS curso,
    P.nombre AS profesor,
    P.departamento
FROM inscripciones I  
JOIN estudiantes E ON I.id_estudiante = E.id_estudiante 
JOIN cursos C ON I.id_curso = C.id_cursos
JOIN profesores P ON C.id_profesor = P.id_profesor;


-- Eliminación de dato " hizo uno  el primero "
DELETE FROM inscripciones WHERE id_inscripcion = 1;
DELETE FROM estudiantes WHERE id_estudiante = 1;

-- ALTER TABLES  "no hizo alert " 

-- 1. Añadir columna de email  a estudiantes
ALTER TABLE estudiantes ADD  email VARCHAR(100);

-- 2. Modificar columna departamento en profesores
ALTER TABLE profesores ALTER COLUMN departamento VARCHAR(150);

-- TRUNCATE TABLES " No hizo "
TRUNCATE TABLE inscripciones;
 

  
  --DROP TABLES "no hizo " 
DROP TABLE inscripciones;
DROP TABLE cursos;
DROP TABLE estudiantes;
DROP TABLE profesores;