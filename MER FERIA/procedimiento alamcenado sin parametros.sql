-- . Listar todas las ferias
CREATE PROCEDURE sp_ListarFerias
AS
BEGIN
    SELECT * FROM Feria;
END;

EXEC sp_ListarFerias;

-- . Listar todas las empresas
CREATE PROCEDURE sp_ListarEmpresas
AS
BEGIN
    SELECT * FROM Empresa;
END;
EXEC sp_ListarEmpresas;

-- . Listar todos los productos con sus stands
CREATE PROCEDURE sp_ListarProductos
AS
BEGIN
    SELECT p.id_producto, p.nombre AS Producto, s.nombre AS Stand, e.nombre AS Empresa
    FROM Producto p
    INNER JOIN Stand s ON p.id_stand = s.id_stand
    INNER JOIN Empresa e ON s.id_empresa = e.id_empresa;
END;

EXEC sp_ListarProductos;
