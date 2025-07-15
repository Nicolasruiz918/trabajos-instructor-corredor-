
-- Creación de la base de datos
CREATE DATABASE Museo;
USE Museo;

-- Tabla Curadores
CREATE TABLE Curadores (
    id_curador INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    especialidad VARCHAR(50),
    fecha_contratacion DATE
);

-- Tabla Visitantes
CREATE TABLE Visitantes (
    id_visitante INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Artefactos
CREATE TABLE Artefactos (
    id_artefacto INT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    creador VARCHAR(100) NOT NULL,
    periodo VARCHAR(50),
    fecha_creacion DATE,
    id_visitante INT,
    FOREIGN KEY (id_visitante) REFERENCES Visitantes(id_visitante)
);

-- Tabla Exhibiciones 
CREATE TABLE Exhibiciones (
    id_exhibicion INT PRIMARY KEY,
    codigo_exhibicion VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    fecha_exhibicion DATETIME,
    id_artefacto INT,
    FOREIGN KEY (id_artefacto) REFERENCES Artefactos(id_artefacto)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_curador INT,
    FOREIGN KEY (id_curador) REFERENCES Curadores(id_curador)
);

-- Tabla Pivote: Asignaciones_Exhibiciones (Curadores asignados a exhibiciones)
CREATE TABLE Asignaciones_Exhibiciones (
    id_asignacion INT PRIMARY KEY,
    id_curador INT,
    id_exhibicion INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_curador) REFERENCES Curadores(id_curador),
    FOREIGN KEY (id_exhibicion) REFERENCES Exhibiciones(id_exhibicion)
);

-- Tabla Pivote: Restauraciones_Artefactos (Relación entre Artefactos y Restauraciones)
CREATE TABLE Restauraciones_Artefactos (
    id_restauracion INT PRIMARY KEY,
    id_artefacto INT,
    descripcion_restauracion VARCHAR(500),
    tipo_restauracion VARCHAR(50),
    fecha_restauracion DATETIME,
    FOREIGN KEY (id_artefacto) REFERENCES Artefactos(id_artefacto)
);

-- Inserción de datos iniciales
INSERT INTO Visitantes  VALUES
(1, 'Elena', 'Martínez', 'Calle 15 #23-45', '3006543210'),
(2, 'Miguel', 'García', 'Avenida 10 #67-89', '3107891234'),
(3, 'Sofía', 'López', 'Carrera 25 #12-34', '3014567890');

INSERT INTO Curadores  VALUES
(1, 'Ana', 'Rodríguez', 'Arte Antiguo', '2018-04-20'),
(2, 'Carlos', 'Pérez', 'Arte Moderno', '2020-09-15'),
(3, 'Lucía', 'Gómez', 'Restauración', '2019-12-01');

INSERT INTO Artefactos  VALUES
(1, 'Estatua de Nefertiti', 'Desconocido', 'Antiguo Egipto', '1345-01-01', 1),
(2, 'Guernica', 'Pablo Picasso', 'Siglo XX', '1937-04-26', 2),
(3, 'Máscara de Tutankamón', 'Desconocido', 'Antiguo Egipto', '1323-01-01', 3);

INSERT INTO Exhibiciones  VALUES
(1, 'EXH-001', 'Exhibición de arte egipcio', '2025-07-12 10:00:00', 1),
(2, 'EXH-002', 'Exhibición de arte moderno', '2025-06-25 14:00:00', 2),
(3, 'EXH-003', 'Exhibición de tesoros faraónicos', '2025-07-18 11:00:00', 3);

INSERT INTO Asignaciones_Exhibiciones VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos  VALUES
(1, 'EQP-001', 'Escáner 3D', 'Artec', 1),
(2, 'EQP-002', 'Microscopio', 'Zeiss', 2),
(3, 'EQP-003', 'Lámpara UV', 'Philips', 3);

INSERT INTO Restauraciones_Artefactos  VALUES
(1, 1, 'Limpieza de superficie', 'Conservación', '2025-07-15 09:00:00'),
(2, 2, 'Restauración de pigmentos', 'Reparación', '2025-06-30 13:00:00'),
(3, 3, 'Refuerzo estructural', 'Reforzamiento', '2025-07-20 10:00:00');

-- 10 Sentencias SQL con funciones aplicadas al MER

-- 1. Obtener iniciales y apellido de curadores
SELECT CONCAT(LEFT(nombre, 1), '. ', apellido) AS nombre_formato
FROM Curadores;

-- 2. Calcular meses de antigüedad de curadores
SELECT nombre, apellido,
       DATEDIFF(MONTH, fecha_contratacion, GETDATE()) AS meses_servicio
FROM Curadores;

-- 3. Contar exhibiciones por año
SELECT descripcion,
       YEAR(fecha_exhibicion) AS ano,
       COUNT(*) AS total_exhibiciones
FROM Exhibiciones
GROUP BY descripcion, YEAR(fecha_exhibicion);

-- 4. Extraer primeros 50 caracteres de descripciones de restauraciones
SELECT id_restauracion,
       LEFT(COALESCE(descripcion_restauracion, 'SIN DESCRIPCIÓN'), 50) AS descripcion_corta
FROM Restauraciones_Artefactos;

-- 5. Calcular promedio de días desde asignación por curador
SELECT c.nombre, c.apellido,
       AVG(DATEDIFF(DAY, ae.fecha_asignacion, GETDATE())) AS promedio_dias
FROM Curadores c
LEFT JOIN Asignaciones_Exhibiciones ae ON c.id_curador = ae.id_curador
GROUP BY c.id_curador, c.nombre, c.apellido;

-- 6. Mostrar apellidos de visitantes en minúsculas
SELECT apellido,
       LOWER(apellido) AS apellido_minusculas
FROM Visitantes;

-- 7. Reemplazar 'Exhibición' por 'Muestra' en descripciones
SELECT descripcion,
       REPLACE(descripcion, 'Exhibición', 'Muestra') AS descripcion_modificada
FROM Exhibiciones;

-- 8. Obtener longitud de nombres de equipos
SELECT tipo_equipo,
       LEN(tipo_equipo) AS longitud_nombre
FROM Equipos;


-- 9 . Formatear nombres de artefactos a título
SELECT nombre,
       UPPER(LEFT(nombre, 1)) + LOWER(SUBSTRING(nombre, 2, LEN(nombre))) AS nombre_titulo
FROM Artefactos;

--  Sentencias SELECT adicionales 

-- 1. Obtener exhibiciones con el nombre del visitante asociado
SELECT e.codigo_exhibicion, e.descripcion, v.nombre, v.apellido
FROM Exhibiciones e
JOIN Artefactos a ON e.id_artefacto = a.id_artefacto
JOIN Visitantes v ON a.id_visitante = v.id_visitante;

-- 2. Listar curadores que manejan exhibiciones de arte egipcio
SELECT c.nombre, c.apellido, c.especialidad
FROM Curadores c
JOIN Asignaciones_Exhibiciones ae ON c.id_curador = ae.id_curador
JOIN Exhibiciones e ON ae.id_exhibicion = e.id_exhibicion
WHERE e.descripcion LIKE '%egipcio%';

-- 3. Mostrar equipos asignados a curadores de restauración
SELECT eq.codigo_equipo, eq.tipo_equipo, eq.marca
FROM Equipos eq
JOIN Curadores c ON eq.id_curador = c.id_curador
WHERE c.especialidad = 'Restauración';


-- 5 Subconsultas
SELECT nombre, apellido
FROM Curadores
WHERE id_curador IN (SELECT id_curador FROM Asignaciones_Exhibiciones WHERE id_exhibicion = 1);

SELECT codigo_exhibicion
FROM Exhibiciones
WHERE id_artefacto IN (
    SELECT id_artefacto FROM Artefactos WHERE periodo = 'Antiguo Egipto'
);

SELECT nombre
FROM Visitantes
WHERE id_visitante NOT IN (
    SELECT id_visitante FROM Artefactos WHERE fecha_creacion > '1900-01-01'
);

SELECT descripcion, COUNT(*) AS total
FROM Exhibiciones
WHERE id_artefacto IN (
    SELECT id_artefacto FROM Artefactos WHERE creador LIKE '%Picasso%' )
GROUP BY descripcion;

SELECT id_exhibicion, codigo_exhibicion
FROM Exhibiciones
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Exhibiciones WHERE id_exhibicion = Exhibiciones.id_exhibicion AND id_curador = 2
);

--  UPDATE

-- 1. Actualizar dirección de visitante
UPDATE Visitantes
SET direccion = 'Calle 40 #15-20'
WHERE id_visitante = 1;

-- 2. Establecer descripción fija en exhibiciones
UPDATE Exhibiciones
SET descripcion = 'Exhibición actualizada';

-- 3. Aumentar fecha de asignación en dos días
UPDATE Asignaciones_Exhibiciones
SET fecha_asignacion = DATEADD(DAY, 2, fecha_asignacion);

--  ALTER
ALTER TABLE Curadores ADD correo VARCHAR(50);

ALTER TABLE Artefactos ADD material VARCHAR(50);

ALTER TABLE Equipos ALTER COLUMN tipo_equipo VARCHAR(50);



--  DELETE
DELETE FROM Restauraciones_Artefactos;

DELETE FROM Asignaciones_Exhibiciones;

DELETE FROM Equipos;



--  TRUNCATE
TRUNCATE TABLE Restauraciones_Artefactos;

TRUNCATE TABLE Asignaciones_Exhibiciones;

TRUNCATE TABLE Equipos;



--  DROP
DROP TABLE Restauraciones_Artefactos;

DROP TABLE Asignaciones_Exhibiciones;

DROP TABLE Equipos;


