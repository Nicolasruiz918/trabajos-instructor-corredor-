
-- Creación de la base de datos
CREATE DATABASE Gimnasio;
USE Gimnasio;

-- Tabla Entrenadores 
CREATE TABLE Entrenadores (
    id_entrenador INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    especialidad VARCHAR(50),
    fecha_contratacion DATE
);

-- Tabla Miembros
CREATE TABLE Miembros (
    id_miembro INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Rutinas
CREATE TABLE Rutinas (
    id_rutina INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    entrenador VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    fecha_creacion DATE,
    id_miembro INT,
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);

-- Tabla Clases
CREATE TABLE Clases (
    id_clase INT PRIMARY KEY,
    codigo_clase VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    fecha_clase DATETIME,
    id_rutina INT,
    FOREIGN KEY (id_rutina) REFERENCES Rutinas(id_rutina)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_entrenador INT,
    FOREIGN KEY (id_entrenador) REFERENCES Entrenadores(id_entrenador)
);

-- Tabla Pivote: Asignaciones_Clases
CREATE TABLE Asignaciones_Clases (
    id_asignacion INT PRIMARY KEY,
    id_entrenador INT,
    id_clase INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_entrenador) REFERENCES Entrenadores(id_entrenador),
    FOREIGN KEY (id_clase) REFERENCES Clases(id_clase)
);

-- Tabla Pivote: Sesiones_Miembros
CREATE TABLE Sesiones_Miembros (
    id_sesion INT PRIMARY KEY,
    id_rutina INT,
    descripcion_sesion VARCHAR(500),
    tipo_sesion VARCHAR(50),
    fecha_sesion DATETIME,
    FOREIGN KEY (id_rutina) REFERENCES Rutinas(id_rutina)
);

-- Inserción de datos iniciales
INSERT INTO Miembros  VALUES
(1, 'Sofía', 'López', 'Calle 5 #45-67', '3001234567'),
(2, 'Juan', 'Martínez', 'Avenida 12 #23-45', '3109876543'),
(3, 'Ana', 'Rodríguez', 'Carrera 15 #78-90', '3041567890');

INSERT INTO Entrenadores  VALUES
(1, 'Carlos', 'Pérez', 'Fuerza', '2020-06-10'),
(2, 'María', 'Gómez', 'Cardio', '2021-03-15'),
(3, 'Luis', 'Ramírez', 'Yoga', '2019-09-20');

INSERT INTO Rutinas  VALUES
(1, 'Fuerza Básica', 'Carlos Pérez', 'Fuerza', '2025-01-10', 1),
(2, 'Cardio Intensivo', 'María Gómez', 'Cardio', '2025-02-15', 2),
(3, 'Yoga Relajante', 'Luis Ramírez', 'Yoga', '2025-03-01', 3);

INSERT INTO Clases VALUES
(1, 'CLAS-001', 'Entrenamiento de fuerza', '2025-07-10 08:00:00', 1),
(2, 'CLAS-002', 'Sesión de cardio', '2025-06-25 16:00:00', 2),
(3, 'CLAS-003', 'Clase de yoga', '2025-07-15 10:00:00', 3);

INSERT INTO Asignaciones_Clases  VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos  VALUES
(1, 'EQP-001', 'Cinta de Correr', 'Precor', 1),
(2, 'EQP-002', 'Máquina de Pesas', 'Technogym', 2),
(3, 'EQP-003', 'Esterilla Yoga', 'Manduka', 3);

INSERT INTO Sesiones_Miembros VALUES
(1, 1, 'Entrenamiento de fuerza supervisado', 'Fuerza', '2025-07-12 09:00:00'),
(2, 2, 'Sesión de cardio de alta intensidad', 'Cardio', '2025-06-27 17:00:00'),
(3, 3, 'Sesión de yoga para relajación', 'Yoga', '2025-07-16 11:00:00');

--  Sentencias SQL con funciones aplicadas al MER
-- . Concatenar nombre y tipo de rutina
SELECT CONCAT(nombre, ' - ', tipo) AS rutina_completa
FROM Rutinas;

-- . Calcular semanas desde creación de rutina
SELECT nombre, entrenador,
       DATEDIFF(WEEK, fecha_creacion, GETDATE()) AS semanas_creacion
FROM Rutinas;

-- . Contar clases por día de la semana
SELECT descripcion,
       DATENAME(WEEKDAY, fecha_clase) AS dia_semana,
       COUNT(*) AS total_clases
FROM Clases
GROUP BY descripcion, DATENAME(WEEKDAY, fecha_clase);

-- . Extraer primeros 30 caracteres de descripciones de sesiones
SELECT id_sesion,
       LEFT(COALESCE(descripcion_sesion, 'SIN DESCRIPCIÓN'), 30) AS descripcion_corta
FROM Sesiones_Miembros;



-- . Mostrar apellidos de miembros en mayúsculas
SELECT apellido,
       UPPER(apellido) AS apellido_mayusculas
FROM Miembros;

-- . Reemplazar 'Entrenamiento' por 'Ses!’
SELECT descripcion,
       REPLACE(descripcion, 'Entrenamiento', 'Sesión') AS descripcion_modificada
FROM Clases;

-- . Obtener longitud de marcas de equipos
SELECT marca,
       LEN(marca) AS longitud_marca
FROM Equipos;

-- . Formatear fecha de clase como mes y año
SELECT descripcion,
       CONVERT(VARCHAR, fecha_clase, 107) AS fecha_texto
FROM Clases;

-- . Contar palabras en nombres de rutinas
SELECT nombre,
       LEN(nombre) - LEN(REPLACE(nombre, ' ', '')) + 1 AS numero_palabras
FROM Rutinas;

--  Sentencias SELECT adicionales
-- 1. Listar rutinas creadas en 2025
SELECT nombre, entrenador, tipo
FROM Rutinas
WHERE YEAR(fecha_creacion) = 2025;

-- 2. Obtener clases con información del miembro
SELECT c.codigo_clase, c.descripcion, m.nombre, m.apellido
FROM Clases c
JOIN Rutinas r ON c.id_rutina = r.id_rutina
JOIN Miembros m ON r.id_miembro = m.id_miembro;

-- 3. Mostrar equipos utilizados por entrenadores de cardio
SELECT e.codigo_equipo, e.tipo_equipo, e.marca
FROM Equipos e
JOIN Entrenadores t ON e.id_entrenador = t.id_entrenador
WHERE t.especialidad = 'Cardio';

--  Subconsultas
SELECT nombre, apellido
FROM Entrenadores
WHERE id_entrenador IN (SELECT id_entrenador FROM Asignaciones_Clases WHERE id_clase = 1);

SELECT codigo_clase
FROM Clases
WHERE id_rutina IN (
    SELECT id_rutina FROM Rutinas WHERE tipo = 'Cardio'
);

SELECT nombre
FROM Miembros
WHERE id_miembro NOT IN (
    SELECT id_miembro FROM Rutinas WHERE fecha_creacion > '2025-01-01'
);

-- UPDATE
UPDATE Entrenadores SET nombre = UPPER(nombre);
UPDATE Miembros SET direccion = 'Calle 50 #10-20' WHERE id_miembro = 1;
UPDATE Asignaciones_Clases SET fecha_asignacion = DATEADD(DAY, 2, fecha_asignacion);

--  ALTER
ALTER TABLE Entrenadores ADD correo VARCHAR(50);
ALTER TABLE Rutinas ADD duracion_minutos INT;
ALTER TABLE Equipos ALTER COLUMN tipo_equipo VARCHAR(50);

--  DELETE
DELETE FROM Sesiones_Miembros;
DELETE FROM Asignaciones_Clases;
DELETE FROM Equipos;



--  TRUNCATE
TRUNCATE TABLE Sesiones_Miembros;
TRUNCATE TABLE Asignaciones_Clases;
TRUNCATE TABLE Equipos;


--  DROP
DROP TABLE Sesiones_Miembros;
DROP TABLE Asignaciones_Clases;
DROP TABLE Equipos;

