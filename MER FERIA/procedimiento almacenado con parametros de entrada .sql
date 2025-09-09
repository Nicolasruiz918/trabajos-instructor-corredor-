-- . Consultar ferias por ciudad
CREATE PROCEDURE sp_ConsultarFeriaPorCiudad
    @ciudad VARCHAR(100)
AS
BEGIN
    SELECT * FROM Feria WHERE ciudad = @ciudad;
END;

EXEC sp_ConsultarFeriaPorCiudad @ciudad = 'Bogotá';

-- . Consultar productos de un stand
CREATE PROCEDURE sp_ConsultarProductosPorStand
    @id_stand INT
AS
BEGIN
    SELECT nombre FROM Producto WHERE id_stand = @id_stand;
END;

EXEC sp_ConsultarProductosPorStand @id_stand = 1;


-- . Consultar visitantes por tipo de entrada
CREATE PROCEDURE sp_ConsultarVisitantesPorTipo
    @tipo VARCHAR(100)
AS
BEGIN
    SELECT v.id_visitante, p.nombre, tv.tipo_entrada
    FROM Visitante v
    INNER JOIN Persona p ON v.id_persona = p.id_persona
    INNER JOIN Tipo_Visitante tv ON v.id_tipo_visitante = tv.id_tipo_visitante
    WHERE tv.tipo_entrada = @tipo;
END;

EXEC sp_ConsultarVisitantesPorTipo @tipo = 'VIP';