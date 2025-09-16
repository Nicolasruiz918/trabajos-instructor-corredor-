CREATE DATABASE Hospital;
USE Hospital;
go
CREATE PROCEDURE Crear_Base_De_Datos_Hospital
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Facturas', 'U') IS NOT NULL DROP TABLE Facturas;
    IF OBJECT_ID('Tratamientos', 'U') IS NOT NULL DROP TABLE Tratamientos;
    IF OBJECT_ID('Diagnosticos', 'U') IS NOT NULL DROP TABLE Diagnosticos;
    IF OBJECT_ID('Citas', 'U') IS NOT NULL DROP TABLE Citas;
    IF OBJECT_ID('Pacientes', 'U') IS NOT NULL DROP TABLE Pacientes;
    IF OBJECT_ID('Medicos', 'U') IS NOT NULL DROP TABLE Medicos;
    IF OBJECT_ID('Especialidades', 'U') IS NOT NULL DROP TABLE Especialidades;

 

    -- Tabla 1: Especialidades
    CREATE TABLE Especialidades (
        id_especialidad INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 2: Medicos
    CREATE TABLE Medicos (
        id_medico INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        id_especialidad INT FOREIGN KEY REFERENCES Especialidades(id_especialidad)
    );

    -- Tabla 3: Pacientes
    CREATE TABLE Pacientes (
        id_paciente INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Tabla 4: Citas
    CREATE TABLE Citas (
        id_cita INT PRIMARY KEY IDENTITY(1,1),
        id_paciente INT FOREIGN KEY REFERENCES Pacientes(id_paciente),
        id_medico INT FOREIGN KEY REFERENCES Medicos(id_medico),
        fecha_cita DATE NOT NULL
    );

    -- Tabla 5: Diagnosticos
    CREATE TABLE Diagnosticos (
        id_diagnostico INT PRIMARY KEY IDENTITY(1,1),
        id_cita INT FOREIGN KEY REFERENCES Citas(id_cita),
        descripcion VARCHAR(200) NOT NULL
    );

    -- Tabla 6: Tratamientos
    CREATE TABLE Tratamientos (
        id_tratamiento INT PRIMARY KEY IDENTITY(1,1),
        id_diagnostico INT FOREIGN KEY REFERENCES Diagnosticos(id_diagnostico),
        descripcion VARCHAR(200) NOT NULL
    );

    -- Tabla 7: Facturas
    CREATE TABLE Facturas (
        id_factura INT PRIMARY KEY IDENTITY(1,1),
        id_cita INT FOREIGN KEY REFERENCES Citas(id_cita),
        monto DECIMAL(7,2) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Especialidades
    INSERT INTO Especialidades (nombre) VALUES 
    ('Cardiología'),
    ('Pediatría'),
    ('Neurología'), 
    ('Ortopedia'), 
    ('Dermatología'),
    ('Oncología'), 
    ('Ginecología'),
    ('Psiquiatría'), 
    ('Oftalmología'),
    ('Endocrinología');

    -- Insertar en Medicos
    INSERT INTO Medicos (nombre, id_especialidad) VALUES 
    ('Dr. Juan Pérez', 1),
    ('Dra. María García', 1),
    ('Dr. Carlos López', 2), 
    ('Dra. Ana Martínez', 2),
    ('Dr. Luis Rodríguez', 3), 
    ('Dra. Sofía Hernández', 3),
    ('Dr. Pedro Gómez', 4), 
    ('Dra. Laura Díaz', 4),
    ('Dr. Miguel Torres', 5), 
    ('Dra. Elena Ruiz', 5);

 -- Insertar en Pacientes con nombres reales
INSERT INTO Pacientes (nombre, email) VALUES 
('María López', 'maria.lopez@email.com'),
('Carlos Ramírez', 'carlos.ramirez@email.com'),
('Ana Torres', 'ana.torres@email.com'),
('José Martínez', 'jose.martinez@email.com'),
('Lucía Fernández', 'lucia.fernandez@email.com'),
('Diego Castro', 'diego.castro@email.com'),
('Valeria Ruiz', 'valeria.ruiz@email.com'),
('Fernando Gómez', 'fernando.gomez@email.com'),
('Isabel Morales', 'isabel.morales@email.com'),
('Andrés Pineda', 'andres.pineda@email.com');

    -- Insertar en Citas
    INSERT INTO Citas (id_paciente, id_medico, fecha_cita) VALUES 
    (1, 1, '2025-09-01'),
    (2, 2, '2025-09-02'), 
    (3, 3, '2025-09-03'), 
    (4, 4, '2025-09-04'),
    (5, 5, '2025-09-05'), 
    (6, 6, '2025-09-06'), 
    (7, 7, '2025-09-07'), 
    (8, 8, '2025-09-08'),
    (9, 9, '2025-09-09'),
    (10, 10, '2025-09-10');

    -- Insertar en Diagnosticos
    INSERT INTO Diagnosticos (id_cita, descripcion) VALUES 
    (1, 'Hipertensión arterial'),
    (2, 'Gripe común'),
    (3, 'Migraña crónica'),
    (4, 'Fractura de tobillo'),
    (5, 'Dermatitis atópica'),
    (6, 'Cáncer de piel'),
    (7, 'Infección urinaria'),
    (8, 'Depresión leve'),
    (9, 'Cataratas'), 
    (10, 'Diabetes tipo 2');

    -- Insertar en Tratamientos
    INSERT INTO Tratamientos (id_diagnostico, descripcion) VALUES 
    (1, 'Medicación antihipertensiva'), 
    (2, 'Reposo y antipiréticos'),
    (3, 'Triptanes'), 
    (4, 'Inmovilización y fisioterapia'),
    (5, 'Cremas corticoides'),
    (6, 'Quimioterapia'),
    (7, 'Antibióticos'), 
    (8, 'Terapia y antidepresivos'),
    (9, 'Cirugía de cataratas'),
    (10, 'Insulina y dieta');

    -- Insertar en Facturas
    INSERT INTO Facturas (id_cita, monto) VALUES 
    (1, 150.000), 
    (2, 50.000), 
    (3, 200.000), 
    (4, 300.000), 
    (5, 100.000),
    (6, 500.000), 
    (7, 80.000), 
    (8, 120.000), 
    (9, 400.000), 
    (10, 250.000);

    -- Crear 5 vistas (reportes adaptados al contexto de hospital)


    
-- Consultas para verificar los datos
SELECT * FROM Especialidades;
SELECT * FROM Medicos;
SELECT * FROM Pacientes;
SELECT * FROM Citas;
SELECT * FROM Diagnosticos;
SELECT * FROM Tratamientos;
SELECT * FROM Facturas;


END;
GO

-- Ejecutar el procedimiento
EXEC Crear_Base_De_Datos_Hospital;
GO

    -- Vista 1: Citas por paciente
    CREATE VIEW Vista_Citas_Por_Paciente AS
    SELECT p.nombre AS Paciente, m.nombre AS Medico, c.fecha_cita AS Fecha_Cita
    FROM Pacientes p
    INNER JOIN Citas c ON p.id_paciente = c.id_paciente
    INNER JOIN Medicos m ON c.id_medico = m.id_medico;

    -- Vista 2: Médicos por especialidad
    CREATE VIEW Vista_Medicos_Por_Especialidad AS
    SELECT e.nombre AS Especialidad, m.nombre AS Medico
    FROM Especialidades e
    INNER JOIN Medicos m ON e.id_especialidad = m.id_especialidad;

    -- Vista 3: Diagnósticos por paciente
    CREATE VIEW Vista_Diagnosticos_Por_Paciente AS
    SELECT p.nombre AS Paciente, d.descripcion AS Diagnostico, m.nombre AS Medico
    FROM Pacientes p
    INNER JOIN Citas c ON p.id_paciente = c.id_paciente
    INNER JOIN Diagnosticos d ON c.id_cita = d.id_cita
    INNER JOIN Medicos m ON c.id_medico = m.id_medico;

    -- Vista 4: Tratamientos por médico
    CREATE VIEW Vista_Tratamientos_Por_Medico AS
    SELECT m.nombre AS Medico, t.descripcion AS Tratamiento, p.nombre AS Paciente
    FROM Medicos m
    INNER JOIN Citas c ON m.id_medico = c.id_medico
    INNER JOIN Diagnosticos d ON c.id_cita = d.id_cita
    INNER JOIN Tratamientos t ON d.id_diagnostico = t.id_diagnostico
    INNER JOIN Pacientes p ON c.id_paciente = p.id_paciente;

    -- Vista 5: Facturas pendientes por paciente
    CREATE VIEW Vista_Facturas_Pendientes AS
    SELECT p.nombre AS Paciente, SUM(f.monto) AS Total_Facturas
    FROM Pacientes p
    INNER JOIN Citas c ON p.id_paciente = c.id_paciente
    INNER JOIN Facturas f ON c.id_cita = f.id_cita
    GROUP BY p.id_paciente, p.nombre;

SELECT * FROM Vista_Citas_Por_Paciente;
SELECT * FROM Vista_Medicos_Por_Especialidad;
SELECT * FROM Vista_Diagnosticos_Por_Paciente;
SELECT * FROM Vista_Tratamientos_Por_Medico;
SELECT * FROM Vista_Facturas_Pendientes;


--1 mejora la busqueda de las especialidades 
 CREATE NONCLUSTERED INDEX IX_Especialidades_Nombre 
   ON Especialidades (nombre);
  
 SELECT * FROM Especialidades WHERE  nombre like 'Oftalmología%';
   


   -- 2 que no se repitan los datos 
   CREATE UNIQUE NONCLUSTERED INDEX IX_Pacientes_email
ON Pacientes (email);

    INSERT INTO Pacientes  (nombre,email) VALUES
 
    ('María López', 'maria.lopez@email.com');

    -- 3   acelera los filtros 
  CREATE NONCLUSTERED INDEX IX_Facturas_monto
  ON Facturas (monto );


    SELECT * FROM  Facturas  WHERE monto > 120.000 ;


   -- 4 
   CREATE NONCLUSTERED INDEX IX_Tratamientos_ID_diagnostico 
   on Tratamientos (id_diagnostico);

   SELECT* FROM  Tratamientos WHERE id_diagnostico= 1;

     
   -- MOSTRAR EL DATO DE CADA EJECUCION 
    SET STATISTICS TIME ON ; 




        -- verificar que los indices esten creados 
    SELECT 
    t.name AS Tabla,
    i.name AS Indice,
    C.name AS Columna 
    FROM SYS.indexes i 
    INNER JOIN sys.tables t ON i.object_id =t.object_id
    INNER JOIN SYS.index_columns ic  ON i.object_id = ic.object_id AND i.index_id= ic.index_id
    inner JOIN sys.columns c ON  ic.object_id = c.object_id AND  ic.column_id = c.column_id
    WHERE t.name IN ('Citas ', 'Diagnosticos', 'Especialidades ','Factura ','Tratamientos ' , 'Pacientes');