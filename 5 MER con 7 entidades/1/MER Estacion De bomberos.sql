-- Creación de la base de datos
CREATE DATABASE EstacionBomberos;
USE EstacionBomberos;

-- Tabla Bomberos
CREATE TABLE Bomberos (
    id_bombero INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    rango VARCHAR(30),
    fecha_ingreso DATE,
    estado VARCHAR(10) DEFAULT 'Activo' CHECK (estado IN ('Activo', 'Inactivo'))
);

-- Tabla Ciudadanos
CREATE TABLE Ciudadanos (
    id_ciudadano INT PRIMARY KEY,
    cedula VARCHAR(20) UNIQUE,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Emergencias
CREATE TABLE Emergencias (
    id_emergencia INT PRIMARY KEY,
    tipo_emergencia VARCHAR(50),
    descripcion VARCHAR(500),
    fecha_emergencia DATETIME,
    id_ciudadano INT,
    FOREIGN KEY (id_ciudadano) REFERENCES Ciudadanos(id_ciudadano)
);

-- Tabla Incidentes
CREATE TABLE Incidentes (
    id_incidente INT PRIMARY KEY,
    codigo_incidente VARCHAR(20) UNIQUE,
    descripcion VARCHAR(500),
    estado_incidente VARCHAR(15) DEFAULT 'Abierto' CHECK (estado_incidente IN ('Abierto', 'Cerrado', 'En Proceso')),
    fecha_apertura DATE,
    id_emergencia INT,
    FOREIGN KEY (id_emergencia) REFERENCES Emergencias(id_emergencia)
);

-- Tabla Vehiculos
CREATE TABLE Vehiculos (
    id_vehiculo INT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE,
    tipo_vehiculo VARCHAR(30),
    modelo VARCHAR(30),
    id_bombero INT,
    FOREIGN KEY (id_bombero) REFERENCES Bomberos(id_bombero)
);

-- Tabla Pivote: Asignaciones_Incidentes (Bomberos asignados a Incidentes).
CREATE TABLE Asignaciones_Incidentes (
    id_asignacion INT PRIMARY KEY,
    id_bombero INT,
    id_incidente INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_bombero) REFERENCES Bomberos(id_bombero),
    FOREIGN KEY (id_incidente) REFERENCES Incidentes(id_incidente)
);

-- Tabla Pivote: Equipos_Emergencias (Relación entre Emergencias y Equipos utilizados)
CREATE TABLE Equipos_Emergencias (
    id_equipo INT PRIMARY KEY,
    id_emergencia INT,
    descripcion_equipo VARCHAR(500),
    tipo_equipo VARCHAR(50),
    fecha_registro DATETIME,
    FOREIGN KEY (id_emergencia) REFERENCES Emergencias(id_emergencia)
);

-- Inserción de datos iniciales
INSERT INTO Ciudadanos (id_ciudadano, cedula, nombre, apellido, direccion, telefono) VALUES
(1, '1029144515', 'Juan', 'Pérez', 'Calle 123', '3001234567'),
(2, '1075311234', 'María', 'Gómez', 'Avenida 45', '3109876543'),
(3, '1045637892', 'Carlos', 'López', 'Carrera 78', '3012468102'),
(4, '1009876543', 'Ana', 'Martínez', 'Calle 56', '3157891234'),
(5, '1123456789', 'Luis', 'Rodríguez', 'Avenida 12', '3012468102');

INSERT INTO Bomberos (id_bombero, nombre, apellido, rango, fecha_ingreso, estado) VALUES
(1, 'Juan', 'Sánchez', 'Sargento', '2020-01-15', 'Activo'),
(2, 'Laura', 'Ramírez', 'Teniente', '2018-06-20', 'Activo'),
(3, 'Diego', 'Torres', 'Bombero', '2021-03-10', 'Activo'),
(4, 'Sofía', 'Vargas', 'Capitán', '2015-11-05', 'Activo'),
(5, 'Andrés', 'Castro', 'Cabo', '2019-08-25', 'Activo');

INSERT INTO Emergencias (id_emergencia, tipo_emergencia, descripcion, fecha_emergencia, id_ciudadano) VALUES
(1, 'Incendio', 'Incendio en vivienda', '2025-05-10 14:30:00', 1),
(2, 'Rescate', 'Rescate de persona atrapada', '2025-04-01 09:15:00', 2),
(3, 'Fuga de gas', 'Fuga de gas en edificio', '2025-05-20 22:00:00', 3),
(4, 'Accidente vehicular', 'Colisión con atrapamiento', '2025-03-15 18:45:00', 4),
(5, 'Inundación', 'Inundación en sótano', '2025-02-28 11:00:00', 5);

INSERT INTO Incidentes (id_incidente, codigo_incidente, descripcion, estado_incidente, fecha_apertura, id_emergencia) VALUES
(1, 'INC-001', 'Investigación de incendio', 'En Proceso', '2025-05-11', 1),
(2, 'INC-002', 'Rescate en curso', 'Abierto', '2025-06-02', 2),
(3, 'INC-003', 'Control de fuga', 'Cerrado', '2025-04-21', 3),
(4, 'INC-004', 'Atención de accidente', 'En Proceso', '2025-03-16', 4),
(5, 'INC-005', 'Mitigación de inundación', 'Abierto', '2025-03-01', 5);

INSERT INTO Asignaciones_Incidentes (id_asignacion, id_bombero, id_incidente, fecha_asignacion) VALUES
(1, 1, 1, '2025-05-12'),
(2, 2, 2, '2025-06-03'),
(3, 3, 3, '2025-04-22'),
(4, 4, 4, '2025-03-17'),
(5, 5, 5, '2025-03-02');

INSERT INTO Vehiculos (id_vehiculo, placa, tipo_vehiculo, modelo, id_bombero) VALUES
(1, 'ABC123', 'Camión de bomberos', '2020', 1),
(2, 'XYZ789', 'Ambulancia', '2019', 2),
(3, 'DEF456', 'Vehículo de rescate', '2021', 3),
(4, 'GHI789', 'Camión de bomberos', '2018', 4),
(5, 'JKL012', 'Vehículo de apoyo', '2020', 5);

INSERT INTO Equipos_Emergencias (id_equipo, id_emergencia, descripcion_equipo, tipo_equipo, fecha_registro) VALUES
(1, 1, 'Extintores utilizados', 'Extintor', '2025-05-10 15:00:00'),
(2, 2, 'Cuerdas de rescate', 'Cuerda', '2025-06-01 10:00:00'),
(3, 3, 'Detectores de gas', 'Sensor', '2025-04-20 23:00:00'),
(4, 4, 'Herramientas de extracción', 'Herramienta', '2025-03-15 19:00:00'),
(5, 5, 'Bombas de agua', 'Bomba', '2025-02-28 12:00:00');
go
-- Procedimiento almacenado sencillo: Actualizar estado de un incidente
CREATE PROCEDURE ActualizarEstadoIncidente
    @id_incidente INT,
    @nuevo_estado VARCHAR(15)
AS
BEGIN
    -- Validar que el nuevo estado sea válido
    IF @nuevo_estado NOT IN ('Abierto', 'Cerrado', 'En Proceso')
    BEGIN
        RAISERROR('Estado no válido. Solo se permiten: Abierto, Cerrado, En Proceso.', 16, 1);
        RETURN;
    END;

    -- Actualizar el estado del incidente
    UPDATE Incidentes
    SET estado_incidente = @nuevo_estado
    WHERE id_incidente = @id_incidente;
END;

-- Ejemplo de ejecución del procedimiento
EXEC ActualizarEstadoIncidente @id_incidente = 1, @nuevo_estado = 'Cerrado';

-- 10 Sentencias SQL con funciones aplicadas al MER

-- 1. Concatenar nombre y apellido de bomberos
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM Bomberos;

-- 2. Calcular antigüedad de bomberos en meses
SELECT nombre, apellido,
       DATEDIFF(MONTH, fecha_ingreso, GETDATE()) AS meses_servicio
FROM Bomberos;

-- 3. Obtener emergencias agrupadas por día
SELECT tipo_emergencia,
       DAY(fecha_emergencia) AS dia,
       COUNT(*) AS total_emergencias
FROM Emergencias
GROUP BY tipo_emergencia, DAY(fecha_emergencia);

-- 4. Convertir descripciones de incidentes a minúsculas
SELECT codigo_incidente,
       LOWER(COALESCE(descripcion, 'SIN DESCRIPCIÓN')) AS descripcion_minusculas
FROM Incidentes;

-- 5. Contar incidentes abiertos por bombero asignado
SELECT b.nombre, b.apellido,
       COUNT(ai.id_incidente) AS incidentes_asignados
FROM Bomberos b
LEFT JOIN Asignaciones_Incidentes ai ON b.id_bombero = ai.id_bombero
WHERE ai.id_incidente IN (SELECT id_incidente FROM Incidentes WHERE estado_incidente = 'Abierto')
GROUP BY b.id_bombero, b.nombre, b.apellido;

-- 6. Mostrar nombres de ciudadanos en mayúsculas
SELECT nombre,
       UPPER(nombre) AS nombre_mayusculas
FROM Ciudadanos;

-- 7. Mostrar tipos de emergencias en mayúsculas
SELECT tipo_emergencia,
       UPPER(tipo_emergencia) AS tipo_mayusculas
FROM Emergencias;

-- 8. Obtener placa de vehículos en minúsculas
SELECT LOWER(placa) AS placa_minus
FROM Vehiculos;

-- 9. Calcular total de días desde la apertura de incidentes por estado
SELECT estado_incidente,
       SUM(DATEDIFF(DAY, fecha_apertura, GETDATE())) AS total_dias
FROM Incidentes
GROUP BY estado_incidente;

-- 10. Reemplazar espacios en apellidos de ciudadanos por guiones bajos
SELECT apellido,
       REPLACE(apellido, ' ', '_') AS apellido_modificado
FROM Ciudadanos;

-- 5 Sentencias SELECT adicionales
-- 1. Listar ciudadanos sin emergencias reportadas
SELECT nombre, apellido, cedula
FROM Ciudadanos
WHERE id_ciudadano NOT IN (SELECT id_ciudadano FROM Emergencias);

-- 2. Obtener incidentes cerrados con su emergencia asociada
SELECT i.codigo_incidente, e.tipo_emergencia
FROM Incidentes i
JOIN Emergencias e ON i.id_emergencia = e.id_emergencia
WHERE i.estado_incidente = 'Cerrado';

-- 3. Listar bomberos con más de 1 año de servicio
SELECT nombre, apellido, rango
FROM Bomberos
WHERE DATEDIFF(DAY, fecha_ingreso, GETDATE()) > 365;

-- 4. Mostrar equipos registrados en la última semana
SELECT descripcion_equipo, tipo_equipo
FROM Equipos_Emergencias
WHERE fecha_registro >= DATEADD(WEEK, -1, GETDATE());

-- 5. Listar vehículos por bombero asignado
SELECT v.placa, v.tipo_vehiculo, b.nombre, b.apellido
FROM Vehiculos v
JOIN Bomberos b ON v.id_bombero = b.id_bombero
ORDER BY b.apellido;

-- 5 Subconsultas
SELECT nombre, apellido
FROM Bomberos
WHERE id_bombero IN (SELECT id_bombero FROM Asignaciones_Incidentes WHERE id_incidente = 1);

SELECT codigo_incidente
FROM Incidentes
WHERE id_emergencia IN (
    SELECT id_emergencia FROM Emergencias WHERE tipo_emergencia = 'Incendio'
);

SELECT cedula, nombre
FROM Ciudadanos
WHERE id_ciudadano NOT IN (
    SELECT id_ciudadano FROM Emergencias WHERE fecha_emergencia > '2025-06-01'
);

SELECT tipo_emergencia, COUNT(*) AS total
FROM Emergencias
WHERE id_ciudadano IN (
    SELECT id_ciudadano FROM Ciudadanos WHERE direccion LIKE '%Avenida%'
)
GROUP BY tipo_emergencia;

SELECT id_incidente, codigo_incidente
FROM Incidentes
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Incidentes WHERE id_incidente = Incidentes.id_incidente AND id_bombero = 2
);

-- 5 UPDATE
-- 1. Convertir apellidos de bomberos a mayúsculas
UPDATE Bomberos
SET apellido = UPPER(apellido);

-- 2. Actualizar apellido de ciudadano 
UPDATE Ciudadanos
SET apellido ='Ramirez'
WHERE id_ciudadano = 2 ;

-- 3. Establecer descripción fija en incidentes
UPDATE Incidentes
SET descripcion = 'Incidente actualizado';

-- 4. Reemplazar descripciones nulas en emergencias
UPDATE Emergencias
SET descripcion = COALESCE(descripcion, 'Sin detalles');

-- 5. Aumentar fecha de asignación en dos días
UPDATE Asignaciones_Incidentes
SET fecha_asignacion = DATEADD(DAY, 2, fecha_asignacion);

-- 5 ALTER
ALTER TABLE Bomberos ADD correo VARCHAR(50);

ALTER TABLE Emergencias ADD nivel_urgencia VARCHAR(20) CHECK (nivel_urgencia IN ('Baja', 'Media', 'Alta'));

ALTER TABLE Incidentes ADD severidad INT DEFAULT 1;

ALTER TABLE Vehiculos ALTER COLUMN tipo_vehiculo VARCHAR(50);

ALTER TABLE Equipos_Emergencias ADD condicion VARCHAR(20) DEFAULT 'Operativo';

-- 5 DELETE
DELETE FROM Equipos_Emergencias;

DELETE FROM Asignaciones_Incidentes;

DELETE FROM Vehiculos;

DELETE FROM Incidentes;

DELETE FROM Emergencias;

-- 5 TRUNCATE
TRUNCATE TABLE Equipos_Emergencias;

TRUNCATE TABLE Asignaciones_Incidentes;

TRUNCATE TABLE Vehiculos;

TRUNCATE TABLE Incidentes;

TRUNCATE TABLE Emergencias;

-- 5 DROP
DROP TABLE Equipos_Emergencias;

DROP TABLE Asignaciones_Incidentes;

DROP TABLE Vehiculos;

DROP TABLE Incidentes;

DROP TABLE Emergencias;