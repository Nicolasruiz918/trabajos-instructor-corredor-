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
-- agrego muy pocos datos hizo uno solo por cada tabla con un solo dato asi que yo le agrege 4 mas acada insert  
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

-- Actualización de datos "hizo solo un update el primero "
UPDATE estudiantes SET edad = 21 WHERE id_estudiante = 1;
UPDATE cursos SET nombre = 'Física Avanzada' WHERE id_cursos = 1;

-- Consultas SELECT "solo hizo el select con el join "
-- 1. Mostrar todos los estudiantes
SELECT * FROM estudiantes;

-- 2. Mostrar estudiantes de ingeniería
SELECT nombre, edad FROM estudiantes WHERE carrera = 'Ingenieria';

-- 3. Consulta con JOINs
SELECT 
    E.nombre AS estudiante,
    C.nombre AS curso,
    P.nombre AS profesor,
    P.departamento
FROM inscripciones I  
JOIN estudiantes E ON I.id_estudiante = E.id_estudiante 
JOIN cursos C ON I.id_curso = C.id_cursos
JOIN profesores P ON C.id_profesor = P.id_profesor;

-- Eliminación de dato " hizo uno el primero "
DELETE FROM inscripciones WHERE id_inscripcion = 1;
DELETE FROM estudiantes WHERE id_estudiante = 1;

-- ALTER TABLES "no hizo alert " 
-- 1. Añadir columna de email a estudiantes
ALTER TABLE estudiantes ADD email VARCHAR(100);

-- 2. Modificar columna departamento en profesores
ALTER TABLE profesores ALTER COLUMN departamento VARCHAR(150);

-- TRUNCATE TABLES " No hizo "
TRUNCATE TABLE inscripciones;
 
-- DROP TABLES "no hizo " 
DROP TABLE inscripciones;
DROP TABLE cursos;
DROP TABLE estudiantes;
DROP TABLE profesores;

-- MER 2 : HOSPITAL 
-- no puso el create database 
-- Create database
CREATE DATABASE hospital;
USE hospital;

-- Crear la tabla Especialidad 
CREATE TABLE Especialidades (
    id_especialidad INT PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Crear la tabla Doctores 
CREATE TABLE Doctores (
    id_doctor INT PRIMARY KEY,
    nombre VARCHAR(100),
    id_especialidad INT,
    FOREIGN KEY (id_especialidad) REFERENCES Especialidades(id_especialidad)
);

-- Crear la tabla Paciente
CREATE TABLE Pacientes (
    id_paciente INT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT
);

-- Crear la tabla Consultas
CREATE TABLE Consultas (
    id_consulta INT PRIMARY KEY,
    id_paciente INT,
    id_doctor INT,
    fecha DATE,
    diagnostico TEXT,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_doctor) REFERENCES Doctores(id_doctor)
);

-- Insertar datos iniciales
-- agrego muy pocos datos hizo uno solo por cada tabla con un solo dato asi que yo le agrege 4 mas acada insert 
INSERT INTO Especialidades VALUES 
(1, 'Cardiología'),
(2, 'Pediatría'),
(3, 'Neurología'),
(4, 'Ortopedia'),
(5, 'Dermatología');

INSERT INTO Doctores VALUES 
(1, 'Dr. Gómez', 1),
(2, 'Dra. Martínez', 2),
(3, 'Dr. Rodríguez', 3),
(4, 'Dra. García', 4),
(5, 'Dr. López', 5);

INSERT INTO Pacientes VALUES 
(1, 'Juan Pérez', 40),
(2, 'Ana García', 35),
(3, 'Carlos Ruiz', 28),
(4, 'María López', 65),
(5, 'Luisa Fernández', 12);

INSERT INTO Consultas VALUES 
(1, 1, 1, '2025-05-26', 'Hipertensión'),
(2, 2, 2, '2025-05-27', 'Control pediátrico'),
(3, 3, 3, '2025-05-28', 'Migraña crónica'),
(4, 4, 4, '2025-05-29', 'Fractura de cadera'),
(5, 5, 5, '2025-05-30', 'Dermatitis atópica');

-- Actualización de datos "hizo solo un update "
UPDATE Consultas SET diagnostico = 'Hipertensión leve' WHERE id_consulta = 1;
UPDATE Pacientes SET edad = 41 WHERE id_paciente = 1;

-- Consultas SELECT "solo hizo el select con el join "
-- 1. Consulta básica mostrando todos los pacientes
SELECT * FROM Pacientes;

-- 2. Buscar médicos por especialidad
SELECT D.nombre AS Doctor, E.nombre AS Especialidad
FROM Doctores D
JOIN Especialidades E ON D.id_especialidad = E.id_especialidad
ORDER BY E.nombre;  

-- 3. Consultas select join 
SELECT
    P.nombre AS Pacientes,
    P.edad,
    D.nombre AS Doctores,
    E.nombre AS Especialidades,
    C.fecha,
    C.diagnostico
FROM Consultas C
JOIN Pacientes P ON C.id_paciente = P.id_paciente
JOIN Doctores D ON C.id_doctor = D.id_doctor
JOIN Especialidades E ON D.id_especialidad = E.id_especialidad;

-- DELETE " hizo uno el primero "
DELETE FROM Consultas WHERE id_consulta = 1;
DELETE FROM Pacientes WHERE id_paciente = 1;

-- ALTER TABLES "no hizo alert "
-- 1. Añadir columna de correo electrónico a Paciente
ALTER TABLE Pacientes ADD email VARCHAR(100);

-- 2. Añadir tiempo de consulta a consulta 
ALTER TABLE Consultas ADD hora TIME;

-- TRUNCATE TABLES " No hizo "
TRUNCATE TABLE consultas;

DROP TABLE Consultas;
DROP TABLE Doctores;
DROP TABLE Pacientes;
DROP TABLE Especialidades;






-- MER 3 : TIENDA

--no creo el DATABASE 
CREATE DATABASE tienda;
USE tienda;

--Crear tabla cliente 
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100),
    correo VARCHAR(100)
);

-- crear tabla vendedor 
CREATE TABLE Vendedor (
    id_vendedor INT PRIMARY KEY,
    nombre VARCHAR(100),
    zona_venta VARCHAR(50)
);
--crear tabla producto 
CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100),
    precio DECIMAL(10,2)
);
-- crear tabla venta 
CREATE TABLE Venta (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    id_vendedor INT,
    fecha DATE,
    cantidad INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor)
);

-- 2. INSERT DATA

-- agrego muy pocos datos hizo uno solo por cada tabla con un solo dato asi que yo le agrege 4 mas acada insert  
INSERT INTO Clientes VALUES 
(1, 'Carlos Gomez', 'carlosj@gmail.com'),
(2, 'Maria Lopez', 'maria@email.com'),
(3, 'Pedro Sanchez', 'pedro@email.com'),
(4, 'Ana Rodriguez', 'ana@email.com');

INSERT INTO Vendedor VALUES 
(1, 'Juan Perez', 'Norte'),
(2, 'Luisa Fernandez', 'Sur'),
(3, 'Carlos Ruiz', 'Este'),
(4, 'Sofia Martinez', 'Oeste');

INSERT INTO Producto VALUES 
(1, 'Portatil HP', 900000.00),
(2, 'Smartphone Samsung', 1200000.00),
(3, 'Tablet Lenovo', 750000.00),
(4, 'Impresora Epson', 450000.00);

INSERT INTO Venta VALUES 
(1, 1, 1, 1, '2025-05-24', 2),
(2, 2, 2, 2, '2025-05-25', 1),
(3, 3, 3, 3, '2025-05-26', 3),
(4, 4, 4, 4, '2025-05-27', 1);

--- Actualización de datos "hizo solo un update "
UPDATE Producto SET precio = 880000.00 WHERE id_producto = 1;
UPDATE Vendedor SET zona_venta = 'Centro' WHERE id_vendedor = 1;


--Consultas SELECT "solo hizo el select con el join "
-- 1. Mostrar todos los clientes y vendedores 
SELECT * FROM Clientes;
SELECT * FROM Vendedor;

SELECT
    C.nombre AS cliente,
    P.nombre AS producto,
    V.nombre AS vendedor,
    Ve.fecha,
    Ve.cantidad,
    (P.precio * Ve.cantidad) AS total
FROM Venta Ve
JOIN Clientes C ON Ve.id_cliente = C.id_cliente
JOIN Producto P ON Ve.id_producto = P.id_producto
JOIN Vendedor V ON Ve.id_vendedor = V.id_vendedor;



-- DELETE " hizo uno el primero "
DELETE FROM Venta WHERE id_venta = 1;
DELETE FROM Producto WHERE id_producto = 4;

-- ALTER TABLES "no hizo alert "
-- Add new columns
ALTER TABLE Clientes ADD telefono VARCHAR(15);
ALTER TABLE Vendedor  ADD comision DECIMAL(5,2);

-- TRUNCATE TABLES " No hizo "
TRUNCATE TABLE Venta;
TRUNCATE TABLE Producto;


-- DROP TABlES " No hizo "
DROP TABLE Venta;
DROP TABLE Producto;
DROP TABLE Vendedor;
DROP TABLE Clientes;