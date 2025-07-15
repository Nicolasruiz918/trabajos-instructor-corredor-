
-- Creación de la base de datos
CREATE DATABASE Hotel;
USE Hotel;

-- Tabla Personal 
CREATE TABLE Personal (
    id_personal INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50), 
    rol VARCHAR(50),
    fecha_contratacion DATE
);

-- Tabla Huespedes
CREATE TABLE Huespedes (
    id_huesped INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(255),
    telefono VARCHAR(15)
);

-- Tabla Habitaciones
CREATE TABLE Habitaciones (
    id_habitacion INT PRIMARY KEY,
    numero VARCHAR(10) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    piso INT,
    fecha_ultima_limpieza DATE,
    id_huesped INT,
    FOREIGN KEY (id_huesped) REFERENCES Huespedes(id_huesped)
);

-- Tabla Reservas 
CREATE TABLE Reservas (
    id_reserva INT PRIMARY KEY,
    codigo_reserva VARCHAR(20) UNIQUE,
    motivo VARCHAR(500),
    fecha_reserva DATETIME,
    id_habitacion INT,
    FOREIGN KEY (id_habitacion) REFERENCES Habitaciones(id_habitacion)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_personal INT,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal)
);

-- Tabla Pivote: Asignaciones_Reservas
CREATE TABLE Asignaciones_Reservas (
    id_asignacion INT PRIMARY KEY,
    id_personal INT,
    id_reserva INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_personal) REFERENCES Personal(id_personal),
    FOREIGN KEY (id_reserva) REFERENCES Reservas(id_reserva)
);

-- Tabla Pivote: Servicios_Habitaciones
CREATE TABLE Servicios_Habitaciones (
    id_servicio INT PRIMARY KEY,
    id_habitacion INT,
    descripcion_servicio VARCHAR(500),
    tipo_servicio VARCHAR(50),
    fecha_servicio DATETIME,
    FOREIGN KEY (id_habitacion) REFERENCES Habitaciones(id_habitacion)
);

-- Inserción de datos iniciales
INSERT INTO Huespedes VALUES
(1, 'Laura', 'Gómez', 'Calle 20 #34-56', '3001234567'),
(2, 'Pedro', 'Martínez', 'Avenida 5 #67-89', '3109876543'),
(3, 'Sofía', 'Rodríguez', 'Carrera 10 #12-34', '3014567890');

INSERT INTO Personal VALUES
(1, 'Ana', 'López', 'Recepción', '2020-04-10'),
(2, 'Carlos', 'Pérez', 'Limpieza', '2021-07-15'),
(3, 'María', 'Ramírez', 'Gerencia', '2019-10-20');

INSERT INTO Habitaciones  VALUES
(1, '101', 'Suite', 1, '2025-07-01', 1),
(2, '202', 'Estándar', 2, '2025-06-20', 2),
(3, '303', 'Deluxe', 3, '2025-07-10', 3);

INSERT INTO Reservas  VALUES
(1, 'RES-001', 'Estancia de vacaciones', '2025-07-12 14:00:00', 1),
(2, 'RES-002', 'Viaje de negocios', '2025-06-25 12:00:00', 2),
(3, 'RES-003', 'Estancia familiar', '2025-07-15 10:00:00', 3);

INSERT INTO Asignaciones_Reservas  VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos  VALUES
(1, 'EQP-001', 'Aspiradora', 'Dyson', 1),
(2, 'EQP-002', 'Computadora', 'HP', 2),
(3, 'EQP-003', 'Carro de Limpieza', 'Rubbermaid', 3);

INSERT INTO Servicios_Habitaciones  VALUES
(1, 1, 'Limpieza diaria', 'Limpieza', '2025-07-13 09:00:00'),
(2, 2, 'Servicio de habitación', 'Room Service', '2025-06-26 15:00:00'),
(3, 3, 'Cambio de sábanas', 'Limpieza', '2025-07-16 11:00:00');

--  Sentencias SQL con funciones aplicadas al MER

-- . Contar reservas por mes
SELECT motivo,
       MONTH(fecha_reserva) AS mes,
       COUNT(*) AS total_reservas
FROM Reservas
GROUP BY motivo, MONTH(fecha_reserva);

-- . Extraer últimos 20 caracteres de descripciones de servicios
SELECT id_servicio,
       RIGHT(COALESCE(descripcion_servicio, 'SIN DESCRIPCIÓN'), 20) AS descripcion_final
FROM Servicios_Habitaciones;

-- . Contar reservas por personal con nombre completo
SELECT CONCAT(p.nombre, ' ', p.apellido) AS personal,
       COUNT(ar.id_reserva) AS reservas_asignadas
FROM Personal p
LEFT JOIN Asignaciones_Reservas ar ON p.id_personal = ar.id_personal
GROUP BY p.id_personal, p.nombre, p.apellido;

-- . Mostrar nombres de huéspedes en minúsculas
SELECT nombre,
       LOWER(nombre) AS nombre_minusculas
FROM Huespedes;

-- . Reemplazar 'Estancia' por 'Alojamiento' en motivos
SELECT motivo,
       REPLACE(motivo, 'Estancia', 'Alojamiento') AS motivo_modificado
FROM Reservas;

-- . Obtener longitud de tipos de equipos
SELECT tipo_equipo,
       LEN(tipo_equipo) AS longitud_tipo
FROM Equipos;

-- . Formatear fecha de reserva como texto corto
SELECT motivo,
       CONVERT(VARCHAR, fecha_reserva, 1) AS fecha_texto
FROM Reservas;

--  Sentencias SELECT adicionales
-- . Listar habitaciones limpiadas en julio 2025
SELECT numero, tipo, piso
FROM Habitaciones
WHERE MONTH(fecha_ultima_limpieza) = 7 AND YEAR(fecha_ultima_limpieza) = 2025;

-- . Obtener reservas con información del huésped
SELECT r.codigo_reserva, r.motivo, h.nombre, h.apellido
FROM Reservas r
JOIN Habitaciones hab ON r.id_habitacion = hab.id_habitacion
JOIN Huespedes h ON hab.id_huesped = h.id_huesped;

-- . Listar servicios por tipo con número de habitación
SELECT s.tipo_servicio, hab.numero AS numero_habitacion, COUNT(*) AS total_servicios
FROM Servicios_Habitaciones s
JOIN Habitaciones hab ON s.id_habitacion = hab.id_habitacion
GROUP BY s.tipo_servicio, hab.numero
ORDER BY s.tipo_servicio;

--  Subconsultas
SELECT nombre, apellido
FROM Personal
WHERE id_personal IN (SELECT id_personal FROM Asignaciones_Reservas WHERE id_reserva = 1);

SELECT codigo_reserva
FROM Reservas
WHERE id_habitacion IN (
    SELECT id_habitacion FROM Habitaciones WHERE tipo = 'Suite'
);

SELECT nombre
FROM Huespedes
WHERE id_huesped NOT IN (
    SELECT id_huesped FROM Habitaciones WHERE fecha_ultima_limpieza > '2025-01-01'
);


SELECT id_reserva, codigo_reserva
FROM Reservas
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Reservas WHERE id_reserva = Reservas.id_reserva AND id_personal = 2
);

--  UPDATE
UPDATE Personal SET nombre = UPPER(nombre);
UPDATE Reservas SET motivo = 'Reserva actualizada';
UPDATE Asignaciones_Reservas SET fecha_asignacion = DATEADD(DAY, 2, fecha_asignacion);

--  ALTER
ALTER TABLE Personal ADD correo VARCHAR(50);
ALTER TABLE Habitaciones ADD capacidad INT;
ALTER TABLE Equipos ALTER COLUMN tipo_equipo VARCHAR(50);


-- DELETE
DELETE FROM Servicios_Habitaciones;
DELETE FROM Asignaciones_Reservas;

--  TRUNCATE
TRUNCATE TABLE Servicios_Habitaciones;
TRUNCATE TABLE Asignaciones_Reservas;

--  DROP
DROP TABLE Servicios_Habitaciones;
DROP TABLE Asignaciones_Reservas;




