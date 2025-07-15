
-- Creación de la base de datos
CREATE DATABASE Biblioteca;
USE Biblioteca;

-- Tabla Bibliotecarios 
CREATE TABLE Bibliotecarios (
    id_bibliotecario INT PRIMARY KEY,
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
    direccion VARCHAR(100  ),
    telefono VARCHAR(15)
);

-- Tabla Libros
CREATE TABLE Libros (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    fecha_publicacion DATE,
    id_miembro INT,
    FOREIGN KEY (id_miembro) REFERENCES Miembros(id_miembro)
);

-- Tabla Prestamos 
CREATE TABLE Prestamos (
    id_prestamo INT PRIMARY KEY,
    codigo_prestamo VARCHAR(20) UNIQUE,
    motivo VARCHAR(500),
    fecha_prestamo DATETIME,
    id_libro INT,
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

-- Tabla Equipos
CREATE TABLE Equipos (
    id_equipo INT PRIMARY KEY,
    codigo_equipo VARCHAR(10) UNIQUE,
    tipo_equipo VARCHAR(30),
    marca VARCHAR(30),
    id_bibliotecario INT,
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecarios(id_bibliotecario)
);

-- Tabla Pivote: Asignaciones_Prestamos (Bibliotecarios asignados a préstamos)
CREATE TABLE Asignaciones_Prestamos (
    id_asignacion INT PRIMARY KEY,
    id_bibliotecario INT,
    id_prestamo INT,
    fecha_asignacion DATE,
    FOREIGN KEY (id_bibliotecario) REFERENCES Bibliotecarios(id_bibliotecario),
    FOREIGN KEY (id_prestamo) REFERENCES Prestamos(id_prestamo)
);

-- Tabla Pivote: Devoluciones_Libros (Relación entre Libros y Devoluciones)
CREATE TABLE Devoluciones_Libros (
    id_devolucion INT PRIMARY KEY,
    id_libro INT,
    descripcion_devolucion VARCHAR(500),
    tipo_devolucion VARCHAR(50),
    fecha_devolucion DATETIME,
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro)
);

-- Inserción de datos iniciales
INSERT INTO Miembros  VALUES
(1, 'Clara', 'Rodríguez', 'Calle 12 #34-56', '3009876543'),
(2, 'Juan', 'Pérez', 'Avenida 7 #89-12', '3101234567'),
(3, 'Lucía', 'Gómez', 'Carrera 20 #45-78', '3016549876');

INSERT INTO Bibliotecarios  VALUES
(1, 'María', 'López', 'Catalogación', '2020-03-15'),
(2, 'Andrés', 'Martínez', 'Atención al Público', '2021-08-10'),
(3, 'Sofía', 'Ramírez', 'Archivos Digitales', '2019-11-05');

INSERT INTO Libros VALUES
(1, 'Cien Años de Soledad', 'Gabriel García Márquez', 'Realismo Mágico', '1967-05-30', 1),
(2, '1984', 'George Orwell', 'Distopía', '1949-06-08', 2),
(3, 'El Hobbit', 'J.R.R. Tolkien', 'Fantasía', '1937-09-21', 3);

INSERT INTO Prestamos  VALUES
(1, 'PRES-001', 'Préstamo para lectura personal', '2025-07-10 09:00:00', 1),
(2, 'PRES-002', 'Préstamo para investigación', '2025-06-20 14:00:00', 2),
(3, 'PRES-003', 'Préstamo para club de lectura', '2025-07-15 11:00:00', 3);

INSERT INTO Asignaciones_Prestamos  VALUES
(1, 1, 1, '2025-07-01'),
(2, 2, 2, '2025-06-15'),
(3, 3, 3, '2025-07-10');

INSERT INTO Equipos  VALUES
(1, 'EQP-001', 'Escáner de Libros', 'Fujitsu', 1),
(2, 'EQP-002', 'Computadora', 'Dell', 2),
(3, 'EQP-003', 'Impresora', 'HP', 3);

INSERT INTO Devoluciones_Libros  VALUES
(1, 1, 'Devolución en buen estado', 'Normal', '2025-07-20 10:00:00'),
(2, 2, 'Devolución con retraso', 'Tardía', '2025-07-01 15:00:00'),
(3, 3, 'Devolución para renovación', 'Renovación', '2025-07-25 12:00:00');

-- 10 Sentencias SQL con funciones aplicadas al MER

-- 1. Concatenar nombre y apellido de bibliotecarios
SELECT CONCAT(nombre, ' ', apellido) AS nombre_completo
FROM Bibliotecarios;

-- 2. Calcular antigüedad de bibliotecarios en años
SELECT nombre, apellido,
       DATEDIFF(YEAR, fecha_contratacion, GETDATE()) AS añ    os_servicio
FROM Bibliotecarios;

-- 3. Obtener préstamos agrupados por mes
SELECT motivo,
       MONTH(fecha_prestamo) AS mes,
       COUNT(*) AS total_prestamos
FROM Prestamos
GROUP BY motivo, MONTH(fecha_prestamo);

-- 4. Convertir descripciones de devoluciones a minúsculas
SELECT id_devolucion,
       LOWER(COALESCE(descripcion_devolucion, 'SIN DESCRIPCIÓN')) AS descripcion_minusculas
FROM Devoluciones_Libros;

-- 5. Contar préstamos por bibliotecario asignado
SELECT b.nombre, b.apellido,
       COUNT(ap.id_prestamo) AS prestamos_asignados
FROM Bibliotecarios b
LEFT JOIN Asignaciones_Prestamos ap ON b.id_bibliotecario = ap.id_bibliotecario
GROUP BY b.id_bibliotecario, b.nombre, b.apellido;

-- 6. Mostrar nombres de miembros en mayúsculas
SELECT nombre,
       UPPER(nombre) AS nombre_mayusculas
FROM Miembros;

-- 7. Mostrar motivos de préstamos en mayúsculas
SELECT motivo,
       UPPER(motivo) AS motivo_mayusculas
FROM Prestamos;

-- 8. Obtener código de equipos en minúsculas
SELECT LOWER(codigo_equipo) AS codigo_minus
FROM Equipos;

-- 9. Calcular total de días desde la fecha de préstamo
SELECT motivo,
       SUM(DATEDIFF(DAY, fecha_prestamo, GETDATE())) AS total_dias
FROM Prestamos
GROUP BY motivo;

-- 10. Reemplazar espacios en títulos de libros por guiones bajos
SELECT titulo,
       REPLACE(titulo, ' ', '_') AS titulo_modificado
FROM Libros;

--  Sentencias SELECT adicionales


-- 1. Obtener préstamos con el nombre del miembro
SELECT p.codigo_prestamo, p.motivo, m.nombre, m.apellido
FROM Prestamos p
JOIN Libros l ON p.id_libro = l.id_libro
JOIN Miembros m ON l.id_miembro = m.id_miembro;




-- 2. Listar devoluciones agrupadas por tipo con el título del libro
SELECT d.tipo_devolucion, l.titulo AS titulo_libro, COUNT(*) AS total_devoluciones
FROM Devoluciones_Libros d
JOIN Libros l ON d.id_libro = l.id_libro
GROUP BY d.tipo_devolucion, l.titulo
ORDER BY d.tipo_devolucion;

-- 5 Subconsultas
SELECT nombre, apellido
FROM Bibliotecarios
WHERE id_bibliotecario IN (SELECT id_bibliotecario FROM Asignaciones_Prestamos WHERE id_prestamo = 1);

SELECT codigo_prestamo
FROM Prestamos
WHERE id_libro IN (
    SELECT id_libro FROM Libros WHERE genero = 'Fantasía'
);

SELECT nombre
FROM Miembros
WHERE id_miembro NOT IN (
    SELECT id_miembro FROM Libros WHERE fecha_publicacion > '2000-01-01'
);

SELECT motivo, COUNT(*) AS total
FROM Prestamos
WHERE id_libro IN (
    SELECT id_libro FROM Libros WHERE autor LIKE '%García Márquez%'
)
GROUP BY motivo;

SELECT id_prestamo, codigo_prestamo
FROM Prestamos
WHERE EXISTS (
    SELECT 1 FROM Asignaciones_Prestamos WHERE id_prestamo = Prestamos.id_prestamo AND id_bibliotecario = 2
);

-- UPDATE
-- 1. Convertir nombres de bibliotecarios a mayúsculas
UPDATE Bibliotecarios
SET nombre = UPPER(nombre);

-- 2. Actualizar dirección de miembro
UPDATE Miembros
SET direccion = 'Calle 50 #10-20'
WHERE id_miembro = 1;

-- 3. Establecer motivo fijo en préstamos
UPDATE Prestamos
SET motivo = 'Préstamo actualizado';



--  ALTER
ALTER TABLE Bibliotecarios ADD email VARCHAR(50);

ALTER TABLE Prestamos ADD prioridad VARCHAR(20) CHECK (prioridad IN ('Baja', 'Media', 'Alta'));

ALTER TABLE Libros ADD isbn VARCHAR(13);


-- DELETE
DELETE FROM Devoluciones_Libros;

DELETE FROM Asignaciones_Prestamos;

DELETE FROM Equipos;

--  TRUNCATE
TRUNCATE TABLE Devoluciones_Libros;

TRUNCATE TABLE Asignaciones_Prestamos;

TRUNCATE TABLE Equipos;


--  DROP
DROP TABLE Devoluciones_Libros;

DROP TABLE Asignaciones_Prestamos;

DROP TABLE Equipos;
