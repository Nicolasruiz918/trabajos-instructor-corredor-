
-- Creación de la base de datos
CREATE DATABASE ClinicaVeterinaria;
USE ClinicaVeterinaria;

-- Tabla Veterinarios 
CREATE TABLE Veterinarios (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    especialidad VARCHAR(50),
    fecha_ingreso DATE
);

-- Tabla Propietarios
CREATE TABLE Propietarios (
    id_propietario INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(255),
    telefono VARCHAR(255)
);

-- Tabla Mascotas
CREATE TABLE Mascotas (
    id_mascota INT  PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    especie VARCHAR(255) NOT NULL,
    raza VARCHAR(100),
    fecha_nacimiento DATE,
    id_propietario INT,
    FOREIGN KEY (id_propietario) REFERENCES Propietarios(id_propietario)
);

-- Tabla Citas 
CREATE TABLE Citas (
    id_cita INT PRIMARY KEY,
    codigo_cita VARCHAR(20) UNIQUE,
    motivo VARCHAR(500),
    fecha_cita DATETIME,
    id_mascota INT,
    FOREIGN KEY (id_mascota) REFERENCES Mascotas(id_mascota)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_veterinario INT,
    FOREIGN KEY (id_veterinario) REFERENCES Veterinarios(id)
);

-- Tabla Pivote: Asignaciones_Citas (Veterinarios asignados a citas)
CREATE TABLE Asignaciones_Citas (
    id_asignacion INT PRIMARY KEY,
    id_veterinario INT,
    id_cita INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_veterinario) REFERENCES Veterinarios(id),
    FOREIGN KEY (id_cita) REFERENCES Citas(id_cita)
);

-- Tabla Pivote: Tratamientos_Mascotas (Relación entre Mascotas y Tratamientos realizados)
CREATE TABLE Tratamientos_Mascotas (
    id_tratamiento INT PRIMARY KEY,
    id_mascota INT,
    descripcion_tratamiento VARCHAR(500),
    tipo_tratamiento VARCHAR(50),
    fecha_tratamiento DATETIME,
    FOREIGN KEY (id_mascota) REFERENCES Mascotas(id_mascota)
);

-- Inserción de datos iniciales 
INSERT INTO Propietarios  VALUES
(1, 'Ana', 'López', 'Calle 10 #45-12', '3001234567'),
(2, 'Pedro', 'Martínez', 'Avenida 5 #23-45', '3136268983'),
(3, 'Sofía', 'García', 'Carrera 15 #67-89', '3103404920');

INSERT INTO Veterinarios  VALUES
(1, 'Carlos', 'Pérez', 'Cirugía', '2019-02-10'),
(2, 'Laura', 'Gómez', 'Medicina General', '2020-07-15'),
(3, 'Diego', 'Torres', 'Dentista ', '2021-04-20');

INSERT INTO Mascotas VALUES
(1, 'Max', 'Perro', 'Labrador', '2020-03-15', 1),
(2, 'Luna', 'Gato', 'Persa', '2021-06-10', 2),
(3, 'Rocky', 'Perro', 'Bulldog', '2019-12-01', 3);

INSERT INTO Citas VALUES 
(1, 'CITA-001', 'Vacunación anual', '2025-07-10 10:00:00', 1),
(2, 'CITA-002', 'Consulta por dermatitis', '2025-06-15 14:30:00', 2),
(3, 'CITA-003', 'Cirugía dental', '2025-07-20 09:00:00', 3);


INSERT INTO Asignaciones_Citas  VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-10'),
(3, 3, 3, '2025-07-15');

INSERT INTO Equipos  VALUES
(1, 'EQP-001', 'Ecógrafo', 'Sonosite', 1),
(2, 'EQP-002', 'Máquina de rayos X', 'GE Healthcare', 2),
(3, 'EQP-003', 'Monitor cardíaco', 'Philips', 3);

INSERT INTO Tratamientos_Mascotas  VALUES
(1, 1, 'Aplicación de vacuna antirrábica', 'Vacunación', '2025-07-10 10:30:00'),
(2, 2, 'Tratamiento para dermatitis', 'Medicación', '2025-06-15 15:00:00'),
(3, 3, 'Limpieza dental', 'Odontología', '2025-07-20 09:30:00');

-- 10 Sentencias SQL con funciones aplicadas al MER

-- 1. Concatenar nombre y apellido de veterinarios
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM Veterinarios;

-- 2. Calcular antigüedad de veterinarios en años
SELECT nombre, apellido,
       DATEDIFF(YEAR, fecha_ingreso, GETDATE()) AS años_servicio
FROM Veterinarios;

-- 3. Obtener citas agrupadas por mes
SELECT motivo,
       MONTH(fecha_cita) AS mes,
       COUNT(*) AS total_citas
FROM Citas
GROUP BY motivo, MONTH(fecha_cita);

-- 4. Convertir descripciones de tratamientos a minúsculas
SELECT id_tratamiento,
       LOWER(COALESCE(descripcion_tratamiento, 'SIN DESCRIPCIÓN')) AS descripcion_minusculas
FROM Tratamientos_Mascotas;

-- 5. Contar citas por veterinario asignado 
SELECT v.nombre, v.apellido,
       COUNT(ac.id_cita) AS citas_asignadas
FROM Veterinarios v
LEFT JOIN Asignaciones_Citas ac ON v.id = ac.id_veterinario
GROUP BY v.id, v.nombre, v.apellido;

-- 6. Mostrar nombres de propietarios en mayúsculas
SELECT nombre,
       UPPER(nombre) AS nombre_mayusculas
FROM Propietarios;

-- 7. Mostrar motivos de citas en mayúsculas
SELECT motivo,
       UPPER(motivo) AS motivo_mayusculas
FROM Citas;

-- 8. Obtener código de equipos en minúsculas
SELECT LOWER(codigo_equipo) AS codigo_minus
FROM Equipos;

-- 9. Calcular total de días desde la fecha de cita 
SELECT motivo,
       SUM(DATEDIFF(DAY, fecha_cita, GETDATE())) AS total_dias 
FROM Citas
GROUP BY motivo;

-- 10. Reemplazar espacios en nombres de mascotas por guiones bajos
SELECT nombre,
       REPLACE(nombre, ' ', '_') AS nombre_modificado
FROM Mascotas;

--  Sentencias SELECT adicionales 


-- 1. Obtener citas con el nombre del propietario 
SELECT c.codigo_cita, c.motivo, p.nombre, p.apellido
FROM Citas c
JOIN Mascotas m ON c.id_mascota = m.id_mascota
JOIN Propietarios p ON m.id_propietario = p.id_propietario;



-- 2. Mostrar equipos utilizados por veterinarios de medicina general
SELECT e.codigo_equipo, e.tipo_equipo, e.marca
FROM Equipos e
JOIN Veterinarios v ON e.id_veterinario = v.id
WHERE v.especialidad = 'Medicina General';

-- 3. Listar tratamientos agrupados por tipo con el nombre de la mascota
SELECT t.tipo_tratamiento, m.nombre AS nombre_mascota, COUNT(*) AS total_tratamientos
FROM Tratamientos_Mascotas t
JOIN Mascotas m ON t.id_mascota = m.id_mascota
GROUP BY t.tipo_tratamiento, m.nombre
ORDER BY t.tipo_tratamiento;

-- Subconsultas
SELECT nombre, apellido
FROM Veterinarios
WHERE id IN (SELECT id_veterinario FROM Asignaciones_Citas WHERE id_cita = 1);

SELECT codigo_cita
FROM Citas
WHERE id_mascota IN (
    SELECT id_mascota FROM Mascotas WHERE especie = 'Perro'
);

SELECT nombre
FROM Propietarios
WHERE id_propietario NOT IN (
    SELECT id_propietario FROM Mascotas WHERE fecha_nacimiento > '2021-01-01'
);

SELECT motivo, COUNT(*) AS total
FROM Citas
WHERE id_mascota IN (
    SELECT id_mascota FROM Mascotas WHERE raza LIKE '%Labrador%'
)
GROUP BY motivo;

SELECT id_cita, codigo_cita
FROM Citas
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Citas WHERE id_cita = Citas.id_cita AND id_veterinario = 2
);

--  UPDATE


-- 1. Establecer motivo fijo en citas
UPDATE Citas
SET motivo = 'Consulta actualizada';

-- 2. Reemplazar descripciones nulas en tratamientos
UPDATE Tratamientos_Mascotas
SET descripcion_tratamiento = COALESCE(descripcion_tratamiento, 'Sin detalles');

-- 3. Aumentar fecha de asignación en un día
UPDATE Asignaciones_Citas
SET fecha_asignacion = DATEADD(DAY, 1, fecha_asignacion);

-- ALTER
ALTER TABLE Veterinarios ADD telefono VARCHAR(15);

ALTER TABLE Mascotas ADD peso DECIMAL(5,2) DEFAULT 0.0;

ALTER TABLE Equipos ALTER COLUMN tipo_equipo VARCHAR(50);


--  DELETE
DELETE FROM Tratamientos_Mascotas;

DELETE FROM Asignaciones_Citas;

DELETE FROM Equipos;

--  TRUNCATE
TRUNCATE TABLE Tratamientos_Mascotas;

TRUNCATE TABLE Asignaciones_Citas;

TRUNCATE TABLE Equipos;

--  DROP
DROP TABLE Tratamientos_Mascotas;

DROP TABLE Asignaciones_Citas;

DROP TABLE Equipos;
