
-- Creación de la base de datos
CREATE DATABASE Eventos;
USE Eventos;

-- Tabla Organizadores 
CREATE TABLE Organizadores (
    id_organizador INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    especialidad VARCHAR(50),
    fecha_contratacion DATE
); 

-- Tabla Asistentes
CREATE TABLE Asistentes (
    id_asistente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Eventos
CREATE TABLE Eventos (
    id_evento INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    organizador VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    fecha_creacion DATE,
    id_asistente INT,
    FOREIGN KEY (id_asistente) REFERENCES Asistentes(id_asistente)
);

-- Tabla Reservas 
CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY,
    codigo_reserva VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    fecha_reserva DATETIME,
    id_evento INT,
    FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_organizador INT,
    FOREIGN KEY (id_organizador) REFERENCES Organizadores(id_organizador)
);

-- Tabla Pivote: Asignaciones_Reservas
CREATE TABLE Asignaciones_Reservas (
    id_asignacion INT PRIMARY KEY,
    id_organizador INT,
    id_reserva INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_organizador) REFERENCES Organizadores(id_organizador),
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva)
);

-- Tabla Pivote: Servicios_Eventos
CREATE TABLE Servicios_Eventos (
    id_servicio INT PRIMARY KEY,
    id_evento INT,
    descripcion_servicio VARCHAR(500),
    tipo_servicio VARCHAR(50),
    fecha_servicio DATETIME,
    FOREIGN KEY (id_evento) REFERENCES Eventos(id_evento)
);

-- Inserción de datos iniciales
INSERT INTO Asistentes  VALUES
(1, 'María', 'Rodríguez', 'Calle 12 #34-56', '3001234567'),
(2, 'Juan', 'Pérez', 'Avenida 5 #67-89', '3109876543'),
(3, 'Sofía', 'Gómez', 'Carrera 10 #12-34', '3014567890');

INSERT INTO Organizadores VALUES
(1, 'Ana', 'López', 'Eventos Corporativos', '2020-06-10'),
(2, 'Carlos', 'Martínez', 'Bodas', '2021-04-15'),
(3, 'Luis', 'Ramírez', 'Conciertos', '2019-09-20');

INSERT INTO Eventos  VALUES
(1, 'Conferencia Tech', 'Ana López', 'Corporativo', '2025-01-15', 1),
(2, 'Boda Pérez-Gómez', 'Carlos Martínez', 'Boda', '2025-02-10', 2),
(3, 'Concierto Rock', 'Luis Ramírez', 'Concierto', '2025-03-05', 3);

INSERT INTO Reservas  VALUES
(1, 'RES-001', 'Reserva para conferencia', '2025-07-12 10:00:00', 1),
(2, 'RES-002', 'Reserva para boda', '2025-06-25 14:00:00', 2),
(3, 'RES-003', 'Reserva para concierto', '2025-07-15 18:00:00', 3);

INSERT INTO Asignaciones_Reservas  VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos  VALUES
(1, 'EQP-001', 'Proyector', 'Epson', 1),
(2, 'EQP-002', 'Sistema de Sonido', 'Bose', 2),
(3, 'EQP-003', 'Iluminación', 'Philips', 3);

INSERT INTO Servicios_Eventos  VALUES
(1, 1, 'Montaje de escenario', 'Logística', '2025-07-12 09:00:00'),
(2, 2, 'Decoración floral', 'Decoración', '2025-06-25 15:00:00'),
(3, 3, 'Configuración de luces', 'Iluminación', '2025-07-15 17:00:00');

--  Sentencias SQL con funciones aplicadas al MER
-- . Concatenar especialidad y nombre del organizador
SELECT CONCAT(especialidad, ': ', nombre, ' ', apellido) AS organizador_especialidad
FROM Organizadores;


-- . Contar reservas por día de la semana
SELECT descripcion,
       DATENAME(WEEKDAY, fecha_reserva) AS dia_semana,
       COUNT(*) AS total_reservas
FROM Reservas
GROUP BY descripcion, DATENAME(WEEKDAY, fecha_reserva);


-- . Obtener longitud de tipos de equipos
SELECT tipo_equipo,
       LEN(tipo_equipo) AS longitud_tipo
FROM Equipos;

-- . Formatear fecha de reserva como texto corto
SELECT descripcion,
       CONVERT(VARCHAR, fecha_reserva, 1) AS fecha_texto
FROM Reservas;

-- . Contar palabras en nombres de eventos
SELECT nombre,
       LEN(nombre) - LEN(REPLACE(nombre, ' ', '')) + 1 AS numero_palabras
FROM Eventos;

--  Sentencias SELECT adicionales
-- . Listar eventos creados en 2025
SELECT nombre, organizador, tipo
FROM Eventos
WHERE YEAR(fecha_creacion) = 2025;

-- . Obtener reservas con información del asistente
SELECT r.codigo_reserva, r.descripcion, a.nombre, a.apellido
FROM Reservas r
JOIN Eventos e ON r.id_evento = e.id_evento
JOIN Asistentes a ON e.id_asistente = a.id_asistente;


--  Subconsultas
SELECT nombre, apellido
FROM Organizadores
WHERE id_organizador IN (SELECT id_organizador FROM Asignaciones_Reservas WHERE id_reserva = 1);

SELECT codigo_reserva
FROM Reservas
WHERE id_evento IN (
    SELECT id_evento FROM Eventos WHERE tipo = 'Boda'
);

SELECT nombre
FROM Asistentes
WHERE id_asistente NOT IN (
    SELECT id_asistente FROM Eventos WHERE fecha_creacion > '2025-01-01'
);


SELECT id_reserva, codigo_reserva
FROM Reservas
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Reservas WHERE id_reserva = Reservas.id_reserva AND id_organizador = 2
);

--  UPDATE
UPDATE Organizadores SET nombre = UPPER(nombre);
UPDATE Reservas SET descripcion = 'Reserva actualizada';
UPDATE Asignaciones_Reservas SET fecha_asignacion = DATEADD(DAY, 2, fecha_asignacion);

--  ALTER
ALTER TABLE Organizadores ADD correo VARCHAR(50);
ALTER TABLE Eventos ADD capacidad INT;
ALTER TABLE Equipos ALTER COLUMN tipo_equipo VARCHAR(50);

--  DELETE
DELETE FROM Servicios_Eventos;
DELETE FROM Asignaciones_Reservas;
DELETE FROM Equipos;


--  TRUNCATE
TRUNCATE TABLE Servicios_Eventos;
TRUNCATE TABLE Asignaciones_Reservas;
TRUNCATE TABLE Equipos;


--  DROP
DROP TABLE Servicios_Eventos;
DROP TABLE Asignaciones_Reservas;
DROP TABLE Equipos;
