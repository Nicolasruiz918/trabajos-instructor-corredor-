-- Crear los esquemas (bases de datos en MySQL)
USE FeriaColombiaDB;
CREATE DATABASE ferias_schema;
CREATE DATABASE empresas_schema;
CREATE DATABASE visitantes_schema;
CREATE DATABASE admin_schema;

-- ==================================
-- Tablas de ferias_schema
-- ==================================
USE ferias_schema;

CREATE TABLE Feria (
    id_feria INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE Tematica (
    id_tematica INT PRIMARY KEY,
    nombre VARCHAR(20)
);

CREATE TABLE Pabellon (
    id_pabellon INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    capacidad_stand INT,
    id_tematica INT,
    id_feria INT,
    FOREIGN KEY (id_tematica) REFERENCES Tematica(id_tematica),
    FOREIGN KEY (id_feria) REFERENCES Feria(id_feria)
);

-- ==================================
-- Tablas de empresas_schema
-- ==================================
USE empresas_schema;

CREATE TABLE Empresa (
    id_empresa INT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    pais VARCHAR(20) NOT NULL
);

CREATE TABLE Stand (
    id_stand INT PRIMARY KEY,
    ubicacion VARCHAR(30) NOT NULL,
    id_empresa INT, 
    id_pabellon INT
  
);

CREATE TABLE Responsable (
    id_responsable INT PRIMARY KEY,
    id_persona INT
    -- Nota: esta FK apunta a visitantes_schema.Persona
);

CREATE TABLE Producto (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    categoria VARCHAR(30) NOT NULL,
    id_stand INT,
    id_responsable INT
);


-- Tablas de visitantes_schema

USE visitantes_schema;

CREATE TABLE Persona (
    id_persona INT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL,
    apellido VARCHAR(30) NOT NULL,
    dni VARCHAR(15) NOT NULL,
    correo VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE Ponente (
    id_ponente INT PRIMARY KEY,
    id_persona INT
);

CREATE TABLE TipoVisitante (
    id_tipoVisitante INT PRIMARY KEY,
    tipo_visitante VARCHAR(30)
);

CREATE TABLE Visitante (
    id_visitante INT PRIMARY KEY,
    id_tipoVisitante INT
);

CREATE TABLE Charla (
    id_charla INT PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE Demostracion (
    id_demostracion INT PRIMARY KEY,
    nombre VARCHAR(30)
);

CREATE TABLE Registro (
    id_registro INT PRIMARY KEY,
    id_feria INT,
    id_charla INT,
    id_visitante INT,
    id_ponente INT,
    id_empresa INT,
    id_demostracion INT,
    tipo VARCHAR(30)
);


-- Crear usuarios 

CREATE USER 'Camilo_Ferias'@'localhost' IDENTIFIED BY 'Camilo123$';
CREATE USER 'Alejandro_Empresas'@'localhost' IDENTIFIED BY 'Alejandro123$';
CREATE USER 'Kevin_Visitantes'@'localhost' IDENTIFIED BY 'Kevin123$';
CREATE USER 'Nicolas_Admin'@'localhost' IDENTIFIED BY 'Nicolas123$';

-- ==================================
-- Permisos
-- ==================================
-- Camilo solo ferias
GRANT ALL PRIVILEGES ON ferias_schema.* TO 'Camilo_Ferias'@'localhost';

-- Alejandro solo empresas
GRANT ALL PRIVILEGES ON empresas_schema.* TO 'Alejandro_Empresas'@'localhost';

-- Kevin solo visitantes
GRANT ALL PRIVILEGES ON visitantes_schema.* TO 'Kevin_Visitantes'@'localhost';

-- Nicolas administrador con control total
GRANT ALL PRIVILEGES ON *.* TO 'Nicolas_Admin'@'localhost' WITH GRANT OPTION;
