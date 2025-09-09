-- . Obtener cantidad de ferias
CREATE PROCEDURE sp_ContarFerias
    @total INT OUTPUT
AS
BEGIN
    SELECT @total = COUNT(*) FROM Feria;
END;


DECLARE @resultado INT;

EXEC sp_ContarFerias @total = @resultado OUTPUT;

SELECT @resultado AS NumeroFerias;





-- . Obtener cantidad de visitantes
CREATE PROCEDURE sp_ContarVisitantes
    @total INT OUTPUT
AS
BEGIN
    SELECT @total = COUNT(*) FROM Visitante;
END;

DECLARE @totalVisitantes INT;

EXEC sp_ContarVisitantes @total = @totalVisitantes OUTPUT;

SELECT 'Número de visitantes: ' + CAST(@totalVisitantes AS VARCHAR);






-- . Obtener cantidad de empresas
CREATE PROCEDURE sp_ContarEmpresas
    @total INT OUTPUT
AS
BEGIN
    SELECT @total = COUNT(*) FROM Empresa;
END;


DECLARE @totalEmpresas INT;

EXEC sp_ContarEmpresas @total = @totalEmpresas OUTPUT;

SELECT 'Número de empresas: ' + CAST(@totalEmpresas AS VARCHAR);
 