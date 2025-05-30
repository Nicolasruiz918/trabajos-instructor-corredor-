

CREATE DATABASE Restaurante;
USE Restaurante;



-- 1. Tabla Mesero (no depende de ninguna otra)
CREATE TABLE Mesero (
    id_mesero INT PRIMARY KEY NOT NULL ,
    nombre VARCHAR(100)NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    gmail VARCHAR(50)NOT NULL,
    direccion TEXT NOT NULL,
    sueldo INT NOT NULL
);

-- 2. Tabla Plato (no depende de otras tablas)
CREATE TABLE Plato (
    id_plato INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(100) NOT NULL ,
    precio DECIMAL(10,2)NOT NULL,
    detalle TEXT NOT NULL ,
    cantidad INT DEFAULT 0 NOT NULL 
);

-- 3. Tabla Orden (depende de Mesero)
CREATE TABLE Orden (
    id_orden INT PRIMARY KEY NOT NULL ,
    fecha DATETIME NOT NULL,
    id_mesero INT NOT NULL,
    numero_orden VARCHAR(20) NOT NULL  UNIQUE ,
    FOREIGN KEY (id_mesero) REFERENCES Mesero(id_mesero)
);

-- 4. Tabla DetalleOrden (depende de Plato y Orden - debe ser la última)
CREATE TABLE DetalleOrden (
    id_detalleOrden INT PRIMARY KEY NOT NULL,
    id_plato INT NOT NULL,
    valor  INT  NOT NULL,
    id_orden INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    FOREIGN KEY (id_plato) REFERENCES Plato(id_plato),
    FOREIGN KEY (id_orden) REFERENCES Orden(id_orden)
);

INSERT INTO Mesero VALUES
(1,'santiago Rodriguez', '321455432', 'SantiagoR@gmail.com', 'Av. Principal 123', 1200000),
(2,'María ', '3123211245', 'MariaG@gmail.com', 'Calle42', 1200000),
(3,'Carlos López', '3134567654', 'Carloslopez@gmail.com', 'prado norte ', 1250000),
(4,'Ana Martínez', '321307402', 'Martinez@gmail.com', 'Avenida Sur 321', 1300000);


INSERT INTO Plato VALUES
(1,'Pasta Carbonara', 32000, 'Pasta con salsa cremosa de huevo, queso y tocino', 50),
(2,'Ensalada César', 18000, 'Lechuga romana, croutones, queso parmesano y aderezo', 30),
(3,'Filete Mignon', 55000, 'Corte de res premium con guarniciones', 20),
(4,'Tiramisú', 15000, 'Postre italiano con café y mascarpone', 40);

INSERT INTO Orden  VALUES
(1,'2023-11-15 12:30:00', 1, 'ORD-001'),
(2,'2023-11-15 13:15:00', 2, 'ORD-002'),
(3,'2023-11-15 14:00:00', 3, 'ORD-003'),
(4,'2023-11-15 15:45:00', 4, 'ORD-004');


INSERT INTO DetalleOrden VALUES
(1,1, 32000, 1, 2),
(2,3, 55000, 1, 1),  
(3,2, 18000, 2, 1),  
(4,4, 15000, 3, 3); 



UPDATE Plato SET precio = 35000
WHERE id_plato = 1;  


UPDATE Mesero SET sueldo = 1300000
WHERE id_mesero = 2;  


SELECT 
    o.numero_orden AS #orden , 
    m.nombre AS mesero,           
    o.fecha,                      
    p.nombre AS plato,            
    do.valor AS precio_unitario,  
    do.cantidad,                 
    (do.valor * do.cantidad) AS subtotal,  
    (SELECT SUM(d2.valor * d2.cantidad) 
    FROM DetalleOrden d2 
    WHERE d2.id_orden = o.id_orden ) AS total_orden              
    FROM Orden o
    INNER JOIN Mesero m  ON o.id_mesero = m.id_mesero
    INNER JOIN DetalleOrden do  ON o.id_orden = do.id_orden
    INNER JOIN Plato p  ON do.id_plato = p.id_plato
    ORDER BY o.fecha DESC, o.numero_orden;



	SELECT 
    o.numero_orden AS #orden, 
    m.nombre AS mesero,           
    o.fecha,                      
    p.nombre AS plato,            
    do.valor AS precio_unitario,  
    do.cantidad,                 
    (SELECT SUM(d2.valor * d2.cantidad) 
     FROM DetalleOrden d2 
     WHERE d2.id_orden = o.id_orden) AS total_orden              
FROM Orden o
INNER JOIN Mesero m  ON o.id_mesero = m.id_mesero
INNER JOIN DetalleOrden do  ON o.id_orden = do.id_orden
INNER JOIN Plato p  ON do.id_plato = p.id_plato
ORDER BY o.fecha DESC, o.numero_orden;

DELETE FROM DetalleOrden WHERE id_orden = 3;
DELETE FROM Orden WHERE id_orden = 3;
DELETE FROM Mesero WHERE id_mesero = 3;


ALTER TABLE Plato ADD categoria VARCHAR(100);  
ALTER TABLE Mesero ALTER COLUMN  telefono VARCHAR(20);  



TRUNCATE TABLE DetalleOrden;
 
DROP TABLE DetalleOrden;
DROP TABLE Orden;
DROP TABLE Plato ;
DROP TABLE Mesero;

