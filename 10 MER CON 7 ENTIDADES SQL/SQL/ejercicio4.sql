
-- Creación de la base de datos
CREATE DATABASE Hospital;
USE Hospital;

-- Tabla Doctores 
CREATE TABLE Doctores (
    id_doctor INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    especialidad VARCHAR(50),
    fecha_contratacion DATE
);

-- Tabla Pacientes
CREATE TABLE Pacientes (
    id_paciente INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    direccion VARCHAR(100),
    telefono VARCHAR(15)
);

-- Tabla Diagnosticos
CREATE TABLE Diagnosticos (
    id_diagnostico INT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    medico VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50),
    fecha_diagnostico DATE,
    id_paciente INT,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)
);

-- Tabla Citas 
CREATE TABLE Citas (
    id_cita INT PRIMARY KEY,
    codigo_cita VARCHAR(20) UNIQUE,
    motivo VARCHAR(500),
    fecha_cita DATETIME,
    id_diagnostico INT,
    FOREIGN KEY (id_diagnostico) REFERENCES Diagnosticos(id_diagnostico)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_doctor INT,
    FOREIGN KEY (id_doctor) REFERENCES Doctores(id_doctor)
);

-- Tabla Pivote: Asignaciones_Citas (Doctores asignados a citas)
CREATE TABLE Asignaciones_Citas (
    id_asignacion INT PRIMARY KEY,
    id_doctor INT,
    id_cita INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_doctor) REFERENCES Doctores(id_doctor),
    FOREIGN KEY (id_cita) REFERENCES Citas(id_cita)
);

-- Tabla Pivote: Tratamientos_Pacientes (Relación entre Diagnosticos y Tratamientos)
CREATE TABLE Tratamientos_Pacientes (
    id_tratamiento INT PRIMARY KEY,
    id_diagnostico INT,
    descripcion_tratamiento VARCHAR(500),
    tipo_tratamiento VARCHAR(50),
    fecha_tratamiento DATETIME,
    FOREIGN KEY (id_diagnostico) REFERENCES Diagnosticos(id_diagnostico)
);

-- Inserción de datos iniciales
INSERT INTO Pacientes  VALUES
(1, 'Luis', 'Gómez', 'Calle 8 #12-34', '3001234567'),
(2, 'María', 'Rodríguez', 'Avenida 3 #56-78', '3109876543'),
(3, 'Pedro', 'López', 'Carrera 10 #23-45', '3014567890');

INSERT INTO Doctores  VALUES
(1, 'Ana', 'Martínez', 'Cardiología', '2019-05-10'),
(2, 'Carlos', 'Pérez', 'Neurología', '2020-11-20'),
(3, 'Sofía', 'Ramírez', 'Pediatría', '2018-07-15');

INSERT INTO Diagnosticos  VALUES
(1, 'Hipertensión', 'Dr. Ana Martínez', 'Cardiología', '2025-01-15', 1),
(2, 'Migraña', 'Dr. Carlos Pérez', 'Neurología', '2025-02-10', 2),
(3, 'Infección respiratoria', 'Dra. Sofía Ramírez', 'Pediatría', '2025-03-05', 3);

INSERT INTO Citas  VALUES
(1, 'CITA-001', 'Control de hipertensión', '2025-07-10 09:00:00', 1),
(2, 'CITA-002', 'Evaluación neurológica', '2025-06-25 14:00:00', 2),
(3, 'CITA-003', 'Consulta pediátrica', '2025-07-15 11:00:00', 3);

INSERT INTO Asignaciones_Citas VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-20'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos VALUES
(1, 'EQP-001', 'Electrocardiógrafo', 'Philips', 1),
(2, 'EQP-002', 'Resonancia Magnética', 'Siemens', 2),
(3, 'EQP-003', 'Oxímetro', 'GE Healthcare', 3);

INSERT INTO Tratamientos_Pacientes  VALUES
(1, 1, 'Prescripción de antihipertensivos', 'Medicación', '2025-07-12 10:00:00'),
(2, 2, 'Terapia para migraña', 'Terapia', '2025-06-27 15:00:00'),
(3, 3, 'Antibióticos para infección', 'Medicación', '2025-07-16 12:00:00');

--  Sentencias SQL con funciones aplicadas al MER
-- 1. Concatenar iniciales y especialidad de doctores
SELECT CONCAT(LEFT(nombre, 1), '. ', apellido, ' - ', especialidad) AS doctor_especialidad
FROM Doctores;

-- 2. Calcular años desde contratación con redondeo
SELECT nombre, apellido,
       ROUND(DATEDIFF(YEAR, fecha_contratacion, GETDATE()), 0) AS anos_contratado
FROM Doctores;

-- 3. Contar citas por trimestre
SELECT motivo,
       DATEPART(QUARTER, fecha_cita) AS trimestre,
       COUNT(*) AS total_citas
FROM Citas
GROUP BY motivo, DATEPART(QUARTER, fecha_cita);

-- 4. Extraer últimos 50 caracteres de descripciones de tratamientos
SELECT id_tratamiento,
       RIGHT(COALESCE(descripcion_tratamiento, 'SIN DESCRIPCIÓN'), 50) AS descripcion_final
FROM Tratamientos_Pacientes;



-- 5. Mostrar nombres de pacientes en título
SELECT nombre,
       UPPER(LEFT(nombre, 1)) + LOWER(SUBSTRING(nombre, 2, LEN(nombre))) AS nombre_titulo
FROM Pacientes;

-- 6. Reemplazar 'Consulta' por 'Revisión' en motivos
SELECT motivo,
       REPLACE(motivo, 'Consulta', 'Revisión') AS motivo_modificado
FROM Citas;

-- 7. Obtener longitud de nombres de equipos
SELECT tipo_equipo,
       LEN(tipo_equipo) AS longitud_nombre
FROM Equipos;

-- 8. Formatear fecha de cita como texto
SELECT motivo,
       CONVERT(VARCHAR, fecha_cita, 103) AS fecha_texto
FROM Citas;


--  Sentencias SELECT adicionales
-- 1. Listar diagnósticos realizados en 2025
SELECT nombre, medico, especialidad
FROM Diagnosticos
WHERE YEAR(fecha_diagnostico) = 2025;

-- 2. Obtener citas con información del paciente
SELECT c.codigo_cita, c.motivo, p.nombre, p.apellido
FROM Citas c
JOIN Diagnosticos d ON c.id_diagnostico = d.id_diagnostico
JOIN Pacientes p ON d.id_paciente = p.id_paciente;

-- 3. Mostrar equipos utilizados por doctores de neurología
SELECT e.codigo_equipo, e.tipo_equipo, e.marca
FROM Equipos e
JOIN Doctores d ON e.id_doctor = d.id_doctor
WHERE d.especialidad = 'Neurología';



SELECT nombre, apellido
FROM Doctores
WHERE id_doctor IN (SELECT id_doctor FROM Asignaciones_Citas WHERE id_cita = 1);


--  UPDATE
UPDATE Doctores SET nombre = UPPER(nombre);

UPDATE Asignaciones_Citas SET fecha_asignacion = DATEADD(DAY, 2, fecha_asignacion);

-- ALTER
ALTER TABLE Doctores ADD correo VARCHAR(50);
ALTER TABLE Equipos ALTER COLUMN tipo_equipo VARCHAR(50);
0

-- DELETE
DELETE FROM Tratamientos_Pacientes;
DELETE FROM Asignaciones_Citas;
DELETE FROM Equipos;


-- 5 TRUNCATE
TRUNCATE TABLE Tratamientos_Pacientes;
TRUNCATE TABLE Asignaciones_Citas;
TRUNCATE TABLE Equipos;


-- 5 DROP
DROP TABLE Tratamientos_Pacientes;
DROP TABLE Asignaciones_Citas;
DROP TABLE Equipos;
