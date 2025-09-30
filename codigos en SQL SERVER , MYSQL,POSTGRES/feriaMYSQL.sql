-- Crear la base de datos
CREATE DATABASE FeriaColombiaDB;
USE FeriaColombiaDB;

-- Tablas principales
CREATE TABLE Feria (
    id_feria INT PRIMARY KEY,
    ciudad VARCHAR(100),
    nombre VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Tematica (
    id_tematica INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Pabellon (
    id_pabellon INT PRIMARY KEY,
    nombre VARCHAR(100),
    id_feria INT,
    id_tematica INT,
    FOREIGN KEY (id_feria) REFERENCES Feria (id_feria),
    FOREIGN KEY (id_tematica) REFERENCES Tematica (id_tematica)
);

CREATE TABLE Empresa (
    id_empresa INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Stand (
    id_stand INT PRIMARY KEY,
    nombre VARCHAR(100),
    id_pabellon INT,
    id_empresa INT,
    FOREIGN KEY (id_pabellon) REFERENCES Pabellon (id_pabellon),
    FOREIGN KEY (id_empresa) REFERENCES Empresa (id_empresa)
);

CREATE TABLE Persona (
    id_persona INT PRIMARY KEY,
    nombre VARCHAR(100),
    edad INT,
    telefono VARCHAR(15)
);

CREATE TABLE Responsable (
    id_responsable INT PRIMARY KEY,
    id_persona INT,
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona)
);

CREATE TABLE Ponente (
    id_ponente INT PRIMARY KEY,
    id_persona INT,
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona)
);

CREATE TABLE Tipo_Visitante (
    id_tipo_visitante INT PRIMARY KEY,
    tipo_entrada VARCHAR(100)
);

CREATE TABLE Visitante (
    id_visitante INT PRIMARY KEY,
    id_persona INT,
    id_tipo_visitante INT,
    FOREIGN KEY (id_persona) REFERENCES Persona (id_persona),
    FOREIGN KEY (id_tipo_visitante) REFERENCES Tipo_Visitante (id_tipo_visitante)
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    id_stand INT,
    id_responsable INT,
    nombre VARCHAR(100),
    FOREIGN KEY (id_stand) REFERENCES Stand (id_stand),
    FOREIGN KEY (id_responsable) REFERENCES Responsable (id_responsable)
);

CREATE TABLE Charla (
    id_charla INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Demostraciones (
    id_demostraciones INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Registo (
    id_registro INT PRIMARY KEY,
    id_feria INT,
    id_charla INT,
    id_visitante INT,
    id_ponente INT,
    id_empresa INT,
    id_demostraciones INT,
    online BOOLEAN,
    FOREIGN KEY (id_feria) REFERENCES Feria (id_feria),
    FOREIGN KEY (id_charla) REFERENCES Charla (id_charla),
    FOREIGN KEY (id_visitante) REFERENCES Visitante (id_visitante),
    FOREIGN KEY (id_ponente) REFERENCES Ponente (id_ponente),
    FOREIGN KEY (id_empresa) REFERENCES Empresa (id_empresa),
    FOREIGN KEY (id_demostraciones) REFERENCES Demostraciones (id_demostraciones)
);

-- ========================
-- INSERCIÓN DE DATOS
-- ========================

INSERT INTO Feria VALUES
(1, 'Bogotá', 'Feria Tecnológica Colombia 2025', '2025-09-01', '2025-09-10'),
(2, 'Medellín', 'Feria de Innovación Antioquia', '2025-10-01', '2025-10-05'),
(3, 'Cali', 'Feria de Arte Vallecaucano', '2025-11-01', '2025-11-07'),
(4, 'Barranquilla', 'Feria Industrial Caribe', '2025-12-01', '2025-12-05'),
(5, 'Cartagena', 'Feria de Moda Caribeña', '2026-01-01', '2026-01-10'),
(6, 'Cúcuta', 'Feria Agrícola Norte', '2026-02-01', '2026-02-07'),
(7, 'Bucaramanga', 'Feria Digital Santander', '2026-03-01', '2026-03-05'),
(8, 'Pereira', 'Feria Cultural Eje Cafetero', '2026-04-01', '2026-04-10'),
(9, 'Manizales', 'Feria de Salud Cafetera', '2026-05-01', '2026-05-07'),
(10, 'Santa Marta', 'Feria Educativa Caribe', '2026-06-01', '2026-06-05');

INSERT INTO Tematica VALUES
(1, 'Tecnología'),
(2, 'Innovación'),
(3, 'Arte'),
(4, 'Industria'),
(5, 'Moda'),
(6, 'Agricultura'),
(7, 'Digital'),
(8, 'Cultura'),
(9, 'Salud'),
(10, 'Educación');

INSERT INTO Pabellon VALUES
(1, 'Pabellón Norte', 1, 1),
(2, 'Pabellón Sur', 2, 2),
(3, 'Pabellón Este', 3, 3),
(4, 'Pabellón Oeste', 4, 4),
(5, 'Pabellón Central', 5, 5),
(6, 'Pabellón Rural', 6, 6),
(7, 'Pabellón Digital', 7, 7),
(8, 'Pabellón Cultural', 8, 8),
(9, 'Pabellón Salud', 9, 9),
(10, 'Pabellón Educativo', 10, 10);

INSERT INTO Empresa VALUES
(1, 'TecnoCol'),
(2, 'InnoMed'),
(3, 'ArteCali'),
(4, 'IndustriaCaribe'),
(5, 'ModaCartagena'),
(6, 'AgroNorte'),
(7, 'DigitalSantander'),
(8, 'CulturaEje'),
(9, 'SaludCafé'),
(10, 'EduCaribe');

INSERT INTO Stand VALUES
(1, 'Stand Bogotá 1', 1, 1),
(2, 'Stand Medellín 2', 2, 2),
(3, 'Stand Cali 3', 3, 3),
(4, 'Stand Barranquilla 4', 4, 4),
(5, 'Stand Cartagena 5', 5, 5),
(6, 'Stand Cúcuta 6', 6, 6),
(7, 'Stand Bucaramanga 7', 7, 7),
(8, 'Stand Pereira 8', 8, 8),
(9, 'Stand Manizales 9', 9, 9),
(10, 'Stand Santa Marta 10', 10, 10);

INSERT INTO Persona VALUES
(1, 'Juan Gómez', 30, '3101234567'),
(2, 'María Rodríguez', 25, '3119876543'),
(3, 'Pedro Vargas', 35, '3124567890'),
(4, 'Ana Martínez', 28, '3133216549'),
(5, 'Luis Pérez', 40, '3147891234'),
(6, 'Sofía López', 22, '3156543217'),
(7, 'Carlos Díaz', 33, '3161472583'),
(8, 'Laura Torres', 27, '3173692581'),
(9, 'Miguel Ruiz', 38, '3182583691'),
(10, 'Elena Sánchez', 29, '3197418529');

INSERT INTO Responsable VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Ponente VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO Tipo_Visitante VALUES
(1, 'Entrada General'),
(2, 'VIP'),
(3, 'Estudiante'),
(4, 'Profesional'),
(5, 'Invitado'),
(6, 'Prensa'),
(7, 'Patrocinador'),
(8, 'Expositor'),
(9, 'VIP'),
(10, 'Estudiante');

INSERT INTO Visitante VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

INSERT INTO Producto VALUES
(1, 1, 1, 'Café Colombiano A'),
(2, 2, 2, 'Innovación B'),
(3, 3, 3, 'Arte C'),
(4, 4, 4, 'Maquinaria D'),
(5, 5, 5, 'Ropa E'),
(6, 6, 6, 'Semillas F'),
(7, 7, 7, 'Software G'),
(8, 8, 8, 'Música H'),
(9, 9, 9, 'Equipo Médico I'),
(10, 10, 10, 'Libro J');

INSERT INTO Charla VALUES
(1, 'Tecnología en Colombia'),
(2, 'Innovación Antioqueña'),
(3, 'Arte Vallecaucano'),
(4, 'Industria Caribeña'),
(5, 'Moda Cartagena'),
(6, 'Agricultura Norte'),
(7, 'Digital Santander'),
(8, 'Cultura Eje Cafetero'),
(9, 'Salud Cafetera'),
(10, 'Educación Caribe');

INSERT INTO Demostraciones VALUES
(1, 'Demo de Café Robótico'),
(2, 'Innovación en Diseño'),
(3, 'Arte Digital'),
(4, 'Maquinaria Industrial'),
(5, 'Desfile de Moda'),
(6, 'Técnicas Agrícolas'),
(7, 'Realidad Virtual'),
(8, 'Danza Cultural'),
(9, 'Tecnología Médica'),
(10, 'Clases Interactivas');

INSERT INTO Registo VALUES
(1, 1, 1, 1, 1, 1, 1, FALSE),
(2, 2, 2, 2, 2, 2, 2, FALSE),
(3, 3, 3, 3, 3, 3, 3, FALSE),
(4, 4, 4, 4, 4, 4, 4, TRUE),
(5, 5, 5, 5, 5, 5, 5, FALSE),
(6, 6, 6, 6, 6, 6, 6, FALSE),
(7, 7, 7, 7, 7, 7, 7, TRUE),
(8, 8, 8, 8, 8, 8, 8, FALSE),
(9, 9, 9, 9, 9, 9, 9, FALSE),
(10, 10, 10, 10, 10, 10, 10, TRUE);
