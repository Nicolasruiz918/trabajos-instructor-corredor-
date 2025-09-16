CREATE DATABASE Museo;
USE Museo;
GO

CREATE PROCEDURE CrearBaseDeDatosMuseo
AS
BEGIN
    -- Eliminar tablas si existen, en orden inverso para evitar conflictos de claves foráneas
    IF OBJECT_ID('Donaciones', 'U') IS NOT NULL DROP TABLE Donaciones;
    IF OBJECT_ID('Visitas', 'U') IS NOT NULL DROP TABLE Visitas;
    IF OBJECT_ID('Eventos', 'U') IS NOT NULL DROP TABLE Eventos;
    IF OBJECT_ID('Obras', 'U') IS NOT NULL DROP TABLE Obras;
    IF OBJECT_ID('Visitantes', 'U') IS NOT NULL DROP TABLE Visitantes;
    IF OBJECT_ID('Artistas', 'U') IS NOT NULL DROP TABLE Artistas;
    IF OBJECT_ID('Colecciones', 'U') IS NOT NULL DROP TABLE Colecciones;

    -- Tabla 1: Colecciones
    CREATE TABLE Colecciones (
        id_coleccion INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );
      
    -- Tabla 2: Artistas
    CREATE TABLE Artistas (
        id_artista INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );

    -- Tabla 3: Visitantes
    CREATE TABLE Visitantes (
        id_visitante INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) NOT NULL
    );

    -- Tabla 4: Obras
    CREATE TABLE Obras (
        id_obra INT PRIMARY KEY IDENTITY(1,1),
        titulo VARCHAR(100) NOT NULL,
        id_coleccion INT FOREIGN KEY REFERENCES Colecciones(id_coleccion),
        id_artista INT FOREIGN KEY REFERENCES Artistas(id_artista)
    );

    -- Tabla 5: Visitas
    CREATE TABLE Visitas (
        id_visita INT PRIMARY KEY IDENTITY(1,1),
        id_visitante INT FOREIGN KEY REFERENCES Visitantes(id_visitante),
        id_obra INT FOREIGN KEY REFERENCES Obras(id_obra),
        fecha_visita DATE NOT NULL
    );

    -- Tabla 6: Eventos
    CREATE TABLE Eventos (
        id_evento INT PRIMARY KEY IDENTITY(1,1),
        id_coleccion INT FOREIGN KEY REFERENCES Colecciones(id_coleccion),
        nombre VARCHAR(100) NOT NULL,
        fecha_evento DATE NOT NULL
    );

    -- Tabla 7: Donaciones
    CREATE TABLE Donaciones (
        id_donacion INT PRIMARY KEY IDENTITY(1,1),
        id_visitante INT FOREIGN KEY REFERENCES Visitantes(id_visitante),
        monto DECIMAL(7,2) NOT NULL
    );

    -- Insertar 10 registros en cada tabla

    -- Insertar en Colecciones
    INSERT INTO Colecciones (nombre) VALUES 
    ('Arte Moderno'),
    ('Renacimiento'),
    ('Impresionismo'),
    ('Escultura Clásica'),
    ('Arte Contemporáneo'),
    ('Fotografía'),
    ('Arte Precolombino'),
    ('Pintura Barroca'), 
    ('Minimalismo'), 
    ('Expresionismo');

    -- Insertar en Artistas
    INSERT INTO Artistas (nombre) VALUES 
    ('Pablo Picasso'),
    ('Leonardo da Vinci'), 
    ('Claude Monet'),
    ('Miguel Ángel'),
    ('Banksy'),
    ('Ansel Adams'), 
    ('Unknown Precolombino'), 
    ('Caravaggio'), 
    ('Mark Rothko'), 
    ('Edvard Munch');
INSERT INTO Visitantes (nombre, email) VALUES 
('María López', 'maria.lopez@email.com'),
('Carlos Gómez', 'carlos.gomez@email.com'),
('Ana Torres', 'ana.torres@email.com'),
('Luis Fernández', 'luis.fernandez@email.com'),
('Elena Ramírez', 'elena.ramirez@email.com'),
('Javier Morales', 'javier.morales@email.com'),
('Lucía Herrera', 'lucia.herrera@email.com'),
('Diego Sánchez', 'diego.sanchez@email.com'),
('Paula Castillo', 'paula.castillo@email.com'),
('Andrés Navarro', 'andres.navarro@email.com');

    -- Insertar en Obras
    INSERT INTO Obras (titulo, id_coleccion, id_artista) VALUES 
    ('Guernica', 1, 1), 
    ('Mona Lisa', 2, 2), 
    ('Nenúfares', 3, 3),
    ('David', 4, 4),
    ('Balloon Girl', 5, 5),
    ('Yosemite', 6, 6),
    ('Estela Maya', 7, 7), 
    ('La Vocación de San Mateo', 8, 8),
    ('No. 5, 1948', 9, 9), 
    ('El Grito', 10, 10);

    -- Insertar en Visitas
    INSERT INTO Visitas (id_visitante, id_obra, fecha_visita) VALUES 
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

    -- Insertar en Eventos
    INSERT INTO Eventos (id_coleccion, nombre, fecha_evento) VALUES 
    (1, 'Exposición Arte Moderno', '2025-10-01'), 
    (2, 'Noche Renacentista', '2025-10-02'),
    (3, 'Impresionismo al Atardecer', '2025-10-03'),
    (4, 'Esculturas Clásicas', '2025-10-04'),
    (5, 'Arte Urbano', '2025-10-05'),
    (6, 'Fotografía en Foco', '2025-10-06'),
    (7, 'Cultura Precolombina', '2025-10-07'),
    (8, 'Barroco Iluminado', '2025-10-08'),
    (9, 'Minimalismo en Debate', '2025-10-09'),
    (10, 'Expresionismo Vivo', '2025-10-10');

    -- Insertar en Donaciones
    INSERT INTO Donaciones (id_visitante, monto) VALUES 
    (1, 500.000),
    (2, 750.000),
    (3, 200.000),
    (4, 100.000),
    (5, 300.000),
    (6, 250.000), 
    (7, 800.000), 
    (8, 450.000), 
    (9, 600.000),
    (10, 900.000);

    -- Consultas para verificar los datos
SELECT * FROM Colecciones;
SELECT * FROM Artistas;
SELECT * FROM Visitantes;
SELECT * FROM Obras;
SELECT * FROM Visitas;
SELECT * FROM Eventos;
SELECT * FROM Donaciones;


    
END;
GO

-- Ejecutar el procedimiento
EXEC CrearBaseDeDatosMuseo;
GO


    -- Vista 1: Obras por colección
    CREATE VIEW Vista_Obras_Por_Coleccion AS
    SELECT c.nombre AS Coleccion, o.titulo AS Obra, a.nombre AS Artista
    FROM Colecciones c
    INNER JOIN Obras o ON c.id_coleccion = o.id_coleccion
    INNER JOIN Artistas a ON o.id_artista = a.id_artista;

    -- Vista 2: Visitas por visitante
    CREATE VIEW V_Visitas_Por_Visitante AS
    SELECT v.nombre AS Visitante, o.titulo AS Obra, vi.fecha_visita AS Fecha_Visita
    FROM Visitantes v
    INNER JOIN Visitas vi ON v.id_visitante = vi.id_visitante
    INNER JOIN Obras o ON vi.id_obra = o.id_obra;

    -- Vista 3: Artistas y número de obras
    CREATE VIEW Vista_Artistas_Y_Obras AS
    SELECT a.nombre AS Artista, COUNT(o.id_obra) AS Numero_Obras
    FROM Artistas a
    LEFT JOIN Obras o ON a.id_artista = o.id_artista
    GROUP BY a.id_artista, a.nombre;

    -- Vista 4: Donaciones por visitante
    CREATE VIEW Vista_Donaciones_Por_Visitante AS
    SELECT v.nombre AS Visitante, SUM(d.monto) AS Total_Donaciones
    FROM Visitantes v
    INNER JOIN Donaciones d ON v.id_visitante = d.id_visitante
    GROUP BY v.id_visitante, v.nombre;

    -- Vista 5: Eventos por colección
    CREATE VIEW Vista_Eventos_Por_Coleccion AS
    SELECT c.nombre AS Coleccion, e.nombre AS Evento, e.fecha_evento AS Fecha_Evento
    FROM Colecciones c
    INNER JOIN Eventos e ON c.id_coleccion = e.id_coleccion;

-- Consultas para verificar las vistas
SELECT * FROM Vista_Obras_Por_Coleccion;
SELECT * FROM V_Visitas_Por_Visitante;
SELECT * FROM Vista_Artistas_Y_Obras;
SELECT * FROM Vista_Donaciones_Por_Visitante;
SELECT   * FROM Vista_Eventos_Por_Coleccion;



   -- 1 mejora la busqueda de las colecciones por nombre 
   CREATE NONCLUSTERED INDEX IX_Colecciones_Nombre
   ON Colecciones  (nombre);
   

   SELECT * FROM Colecciones WHERE  nombre like 'Arte Moderno';
   

   -- 2 mejora la busqueda  de los artistas por nombre 
   CREATE NONCLUSTERED INDEX IX_Artistas_Nombre 
   ON Artistas (nombre);


SELECT * FROM Artistas WHERE  nombre like 'Edvard Munch';
   

   --  3 Mejora la búsqueda de eventos  por id_coleccion
CREATE NONCLUSTERED INDEX IX_Eventos_Idcoleccion
ON Eventos  (id_coleccion);

 SELECT * FROM Eventos WHERE id_coleccion = 1 ;



 --4 mejora la  busqueda de datos en la tabla donaciones 
   CREATE NONCLUSTERED INDEX IX_Donaciones_monto 
  ON Donaciones  (monto);
   SELECT * FROM  Donaciones WHERE monto > 250.000 ;


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
    WHERE t.name IN ('Cursos', 'Notas', 'Estudiantes ','Materias','Profesores' , 'Departamentos');