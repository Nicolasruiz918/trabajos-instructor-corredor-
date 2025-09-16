CREATE DATABASE Biblioteca;
GO
 
USE Biblioteca;
GO

CREATE PROCEDURE Crear_Base_De_Datos_Biblioteca
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Multas', 'U') IS NOT NULL DROP TABLE Multas;
    IF OBJECT_ID('Devoluciones', 'U') IS NOT NULL DROP TABLE Devoluciones;
    IF OBJECT_ID('Prestamos', 'U') IS NOT NULL DROP TABLE Prestamos;
    IF OBJECT_ID('Libros', 'U') IS NOT NULL DROP TABLE Libros;
    IF OBJECT_ID('Usuarios', 'U') IS NOT NULL DROP TABLE Usuarios;
    IF OBJECT_ID('Autores', 'U') IS NOT NULL DROP TABLE Autores;
    IF OBJECT_ID('Categorias', 'U') IS NOT NULL DROP TABLE Categorias;



    -- Tabla 1: Categorias
    CREATE TABLE Categorias (
        id_categoria INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 2: Autores
    CREATE TABLE Autores (
        id_autor INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 3: Usuarios
    CREATE TABLE Usuarios (
        id_usuario INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL 
    );

    -- Tabla 4: Libros
    CREATE TABLE Libros (
        id_libro INT PRIMARY KEY IDENTITY(1,1),
        titulo VARCHAR(100) NOT NULL,
        id_categoria INT FOREIGN KEY REFERENCES Categorias(id_categoria),
        id_autor INT FOREIGN KEY REFERENCES Autores(id_autor)
    );

    -- Tabla 5: Prestamos
    CREATE TABLE Prestamos (
        id_prestamo INT PRIMARY KEY IDENTITY(1,1),
        id_usuario INT FOREIGN KEY REFERENCES Usuarios(id_usuario),
        id_libro INT FOREIGN KEY REFERENCES Libros(id_libro),
        fecha_prestamo DATE NOT NULL
    );

    -- Tabla 6: Devoluciones
    CREATE TABLE Devoluciones (
        id_devolucion INT PRIMARY KEY IDENTITY(1,1),
        id_prestamo INT FOREIGN KEY REFERENCES Prestamos(id_prestamo),
        fecha_devolucion DATE NOT NULL
    );

    -- Tabla 7: Multas
    CREATE TABLE Multas (
        id_multa INT PRIMARY KEY IDENTITY(1,1),
        id_prestamo INT FOREIGN KEY REFERENCES Prestamos(id_prestamo),
        monto DECIMAL(5,2) NOT NULL
    );





    -- Insertar 10 registros en cada tabla

    -- Insertar en Categorias
    INSERT INTO Categorias (nombre) VALUES 
    ('Novela'), 
    ('Ciencia Ficción'), 
    ('Historia'), 
    ('Poesía'), 
    ('Biografía'),
    ('Fantasía'), 
    ('Ensayo'), 
    ('Misterio'), 
    ('Autoayuda'), 
    ('Técnico');

    -- Insertar en Autores
    INSERT INTO Autores (nombre) VALUES 
    ('Gabriel García Márquez'),
    ('Isaac Asimov'), 
    ('Yuval Noah Harari'), 
    ('Pablo Neruda'),
    ('Walter Isaacson'),
    ('J.R.R. Tolkien'), 
    ('Umberto Eco'), 
    ('Agatha Christie'),
    ('Robin Sharma'), 
    ('Donald Knuth');

    -- Insertar en Usuarios
 INSERT INTO Usuarios (nombre, email) VALUES
('Mateo Torres', 'mateo.torres@email.com'),
('Camila Ríos', 'camila.rios@email.com'),
('Julián Herrera', 'julian.herrera@email.com'),
('Valentina Cruz', 'valentina.cruz@email.com'),
('Sofía Navarro', 'sofia.navarro@email.com'),
('Emilio Vargas', 'emilio.vargas@email.com'),
('Isabela Romero', 'isabela.romero@email.com'),
('Lucas Méndez', 'lucas.mendez@email.com'),
('Renata Salas', 'renata.salas@email.com'),
('Tomás Paredes', 'tomas.paredes@email.com');
    -- Insertar en Libros
    INSERT INTO Libros (titulo, id_categoria, id_autor) VALUES 
    ('Cien Años de Soledad', 1, 1), 
    ('Fundación', 2, 2),
    ('Sapiens', 3, 3), 
    ('Veinte Poemas', 4, 4),
    ('Steve Jobs', 5, 5), 
    ('El Hobbit', 6, 6),
    ('El Nombre de la Rosa', 7, 7), 
    ('Asesinato en el Orient Express', 8, 8),
    ('El Monje que Vendió su Ferrari', 9, 9),
    ('The Art of Computer Programming', 10, 10);

    -- Insertar en Prestamos
    INSERT INTO Prestamos (id_usuario, id_libro, fecha_prestamo) VALUES 
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

    -- Insertar en Devoluciones
    INSERT INTO Devoluciones (id_prestamo, fecha_devolucion) VALUES 
    (1, '2025-09-10'),
    (2, '2025-09-11'),
    (3, '2025-09-12'),
    (4, '2025-09-13'),
    (5, '2025-09-14'), 
    (6, '2025-09-15'), 
    (7, '2025-09-16'), 
    (8, '2025-09-17'),
    (9, '2025-09-18'), 
    (10, '2025-09-19');

    -- Insertar en Multas
    INSERT INTO Multas (id_prestamo, monto) VALUES 
    (1, 5.000), 
    (2, 3.800), 
    (3, 2.000), 
    (4, 4.000), 
    (5, 6.500),
    (6, 1.500), 
    (7, 2.500), 
    (8, 3.000), 
    (9, 4.500), 
    (10, 5.500);

   

SELECT * FROM Categorias;
SELECT * FROM Autores;
SELECT * FROM Usuarios;
SELECT * FROM Libros;
SELECT * FROM Prestamos;
SELECT * FROM Devoluciones;
SELECT * FROM Multas;


END;
GO

-- Ejecutar el procedimiento
EXEC Crear_Base_De_Datos_Biblioteca;
GO

    -- Vista 1: Préstamos por usuario
    CREATE VIEW Vista_Prestamos_Por_Usuario AS
    SELECT u.nombre AS Usuario, l.titulo AS Libro, p.fecha_prestamo AS Fecha_Prestamo
    FROM Usuarios u
    INNER JOIN Prestamos p ON u.id_usuario = p.id_usuario
    INNER JOIN Libros l ON p.id_libro = l.id_libro;

    -- Vista 2: Libros por categoría
    CREATE VIEW Vista_Libros_Por_Categoria AS
    SELECT c.nombre AS Categoria, l.titulo AS Libro, a.nombre AS Autor
    FROM Categorias c
    INNER JOIN Libros l ON c.id_categoria = l.id_categoria
    INNER JOIN Autores a ON l.id_autor = a.id_autor;

    -- Vista 3: Autores y sus libros
    CREATE VIEW Vista_Autores_Y_Libros AS
    SELECT a.nombre AS Autor, COUNT(l.id_libro) AS Numero_Libros
    FROM Autores a
    LEFT JOIN Libros l ON a.id_autor = l.id_autor
    GROUP BY a.id_autor, a.nombre;

    -- Vista 4: Multas pendientes por usuario
    CREATE VIEW Vista_Multas_Pendientes AS
    SELECT u.nombre AS Usuario, SUM(m.monto) AS Total_Multas
    FROM Usuarios u
    INNER JOIN Prestamos p ON u.id_usuario = p.id_usuario
    INNER JOIN Multas m ON p.id_prestamo = m.id_prestamo
    GROUP BY u.id_usuario, u.nombre;

    -- Vista 5: Préstamos por categoría
    CREATE VIEW Vista_Prestamos_Por_Categoria AS
    SELECT c.nombre AS Categoria, COUNT(p.id_prestamo) AS Numero_Prestamos
    FROM Categorias c
    INNER JOIN Libros l ON c.id_categoria = l.id_categoria
    INNER JOIN Prestamos p ON l.id_libro = p.id_libro
    GROUP BY c.id_categoria, c.nombre;


    
SELECT * FROM Vista_Prestamos_Por_Usuario;
SELECT * FROM Vista_Libros_Por_Categoria;
SELECT * FROM Vista_Autores_Y_Libros;
SELECT * FROM Vista_Multas_Pendientes;
SELECT * FROM Vista_Prestamos_Por_Categoria;



    
  --1 acelera los filtros por materia 
  CREATE NONCLUSTERED INDEX IX_Multas_id_prestamo 
  ON Multas (id_prestamo);
   

   --2 mejora la busqueda de  los prestamos con el id del usuario 
   CREATE NONCLUSTERED INDEX   IX_Prestamos_id_usuario
   ON Prestamos (id_usuario);

   --3 
   CREATE NONCLUSTERED INDEX IX_Usuario_nombres
   ON Usuarios (nombre);
    
    
    --1
    SELECT * FROM Multas WHERE id_prestamo = 1 ;

     --2
    SELECT * FROM  Prestamos WHERE id_usuario = 1  ;


    --3 
    SELECT * FROM Usuarios WHERE  nombre like 'Mateo%';
   
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
    WHERE t.name IN ('Multas ', 'Devolucion', 'Usuarios ','Prestamos ','Libros ' , 'Autores');