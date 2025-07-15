
-- Creación de la base de datos
CREATE DATABASE RentaCarros;
USE RentaCarros;

-- Tabla Agentes 
CREATE TABLE Agentes (
    id_agente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    rol VARCHAR(50),
    fecha_contratacion DATE
);

-- Tabla Clientes
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(150),
    telefono VARCHAR(15)
);

-- Tabla Vehiculos
CREATE TABLE Vehiculos (
    id_vehiculo INT PRIMARY KEY,
    modelo VARCHAR(150) NOT NULL,
    agente VARCHAR(100) NOT NULL,
    tipo VARCHAR(50),
    fecha_fabricacion DATE,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

-- Tabla Rentas 
CREATE TABLE Rentas (
    id_renta INT PRIMARY KEY,
    codigo_renta VARCHAR(20) UNIQUE,
    motivo VARCHAR(500),
    fecha_renta DATETIME,
    id_vehiculo INT,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_agente INT,
    FOREIGN KEY (id_agente) REFERENCES Agentes(id_agente)
);

-- Tabla Pivote: Asignaciones_Rentas (Agentes asignados a rentas)
CREATE TABLE Asignaciones_Rentas (
    id_asignacion INT PRIMARY KEY,
    id_agente INT,
    id_renta INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_agente) REFERENCES Agentes(id_agente),
    FOREIGN KEY (id_renta) REFERENCES Rentas(id_renta)
);

-- Tabla Pivote: Mantenimientos_Vehiculos (Relación entre Vehiculos y Mantenimientos)
CREATE TABLE Mantenimientos_Vehiculos (
    id_mantenimiento INT PRIMARY KEY,
    id_vehiculo INT,
    descripcion_mantenimiento VARCHAR(500),
    tipo_mantenimiento VARCHAR(50),
    fecha_mantenimiento DATETIME,
    FOREIGN KEY (id_vehiculo) REFERENCES Vehiculos(id_vehiculo)
);

-- Inserción de datos iniciales
INSERT INTO Clientes  VALUES
(1, 'Sofía', 'Rodríguez', 'Calle 10 #23-45', '3001234567'),
(2, 'Juan', 'Pérez', 'Avenida 5 #67-89', '3109876543'),
(3, 'María', 'Gómez', 'Carrera 15 #12-34', '3014567890');

INSERT INTO Agentes  VALUES
(1, 'Ana', 'Martínez', 'Atención al Cliente', '2020-06-10'),
(2, 'Carlos', 'López', 'Mantenimiento', '2021-04-15'),
(3, 'Luis', 'Ramírez', 'Ventas', '2019-09-20');

INSERT INTO Vehiculos VALUES
(1, 'Toyota Corolla', 'Ana Martínez', 'Sedán', '2020-01-15', 1),
(2, 'Ford Escape', 'Carlos López', 'SUV', '2021-02-10', 2),
(3, 'Honda Civic', 'Luis Ramírez', 'Compacto', '2019-03-05', 3);

INSERT INTO Rentas  VALUES
(1, 'REN-001', 'Renta para viaje', '2025-07-12 09:00:00', 1),
(2, 'REN-002', 'Renta para negocios', '2025-06-25 14:00:00', 2),
(3, 'REN-003', 'Renta para paseo familiar', '2025-07-15 10:00:00', 3);

INSERT INTO Asignaciones_Rentas  VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos  VALUES
(1, 'EQP-001', 'Escáner OBD', 'Bosch', 1),
(2, 'EQP-002', 'Elevador Hidráulico', 'Hunter', 2),
(3, 'EQP-003', 'Limpieza a Vapor', 'Karcher', 3);

INSERT INTO Mantenimientos_Vehiculos  VALUES
(1, 1, 'Cambio de aceite', 'Preventivo', '2025-07-10 08:00:00'),
(2, 2, 'Revisión de frenos', 'Correctivo', '2025-06-20 15:00:00'),
(3, 3, 'Alineación y balanceo', 'Preventivo', '2025-07-12 11:00:00');

-- Sentencias SQL con funciones aplicadas al MER
-- . Concatenar rol y nombre completo del agente
SELECT CONCAT(rol, ': ', nombre, ' ', apellido) AS agente_rol
FROM Agentes;

-- . Calcular años desde contratación con redondeo
SELECT nombre, apellido,
       ROUND(DATEDIFF(YEAR, fecha_contratacion, GETDATE()), 0) AS anos_contratado
FROM Agentes;

-- . Contar rentas por mes
SELECT motivo,
       MONTH(fecha_renta) AS mes,
       COUNT(*) AS total_rentas
FROM Rentas
GROUP BY motivo, MONTH(fecha_renta);

-- . Extraer últimos 30 caracteres de descripciones de mantenimientos
SELECT id_mantenimiento,
       RIGHT(COALESCE(descripcion_mantenimiento, 'SIN DESCRIPCIÓN'), 30) AS descripcion_final
FROM Mantenimientos_Vehiculos;

-- . Mostrar nombres de clientes en título
SELECT nombre,
       UPPER(LEFT(nombre, 1)) + LOWER(SUBSTRING(nombre, 2, LEN(nombre))) AS nombre_titulo
FROM Clientes;

-- . Reemplazar 'Renta' por 'Alquiler' en motivos
SELECT motivo,
       REPLACE(motivo, 'Renta', 'Alquiler') AS motivo_modificado
FROM Rentas;

-- . Obtener longitud de tipos de equipos
SELECT tipo_equipo,
       LEN(tipo_equipo) AS longitud_tipo
FROM Equipos;


--  Sentencias SELECT adicionales
-- . Listar vehículos fabricados antes de 2021
SELECT modelo, agente, tipo
FROM Vehiculos
WHERE fecha_fabricacion < '2021-01-01';

-- . Obtener rentas con información del cliente
SELECT r.codigo_renta, r.motivo, c.nombre, c.apellido
FROM Rentas r
JOIN Vehiculos v ON r.id_vehiculo = v.id_vehiculo
JOIN Clientes c ON v.id_cliente = c.id_cliente;

-- . Mostrar equipos utilizados por agentes de mantenimiento
SELECT e.codigo_equipo, e.tipo_equipo, e.marca
FROM Equipos e
JOIN Agentes a ON e.id_agente = a.id_agente
WHERE a.rol = 'Mantenimiento';


--  Subconsultas
SELECT nombre, apellido
FROM Agentes
WHERE id_agente IN (SELECT id_agente FROM Asignaciones_Rentas WHERE id_renta = 1);

SELECT codigo_renta
FROM Rentas
WHERE id_vehiculo IN (
    SELECT id_vehiculo FROM Vehiculos WHERE tipo = 'Sedán'
);

SELECT nombre
FROM Clientes
WHERE id_cliente NOT IN (
    SELECT id_cliente FROM Vehiculos WHERE fecha_fabricacion > '2020-01-01'
);


-- UPDATE
UPDATE Agentes SET nombre = UPPER(nombre);
UPDATE Clientes SET direccion = 'Calle 50 #10-20' WHERE id_cliente = 1;
UPDATE Rentas SET motivo = 'Renta actualizada';


--  ALTER
ALTER TABLE Agentes ADD correo VARCHAR(50);
ALTER TABLE Rentas ADD prioridad VARCHAR(20) CHECK (prioridad IN ('Baja', 'Media', 'Alta'));
ALTER TABLE Mantenimientos_Vehiculos ADD estado_mantenimiento VARCHAR(20) DEFAULT 'Completado';

--  DELETE
DELETE FROM Mantenimientos_Vehiculos;
DELETE FROM Asignaciones_Rentas;
DELETE FROM Equipos;

--  TRUNCATE
TRUNCATE TABLE Mantenimientos_Vehiculos;
TRUNCATE TABLE Asignaciones_Rentas;
TRUNCATE TABLE Equipos;


--  DROP
DROP TABLE Mantenimientos_Vehiculos;
DROP TABLE Asignaciones_Rentas;
DROP TABLE Equipos;

