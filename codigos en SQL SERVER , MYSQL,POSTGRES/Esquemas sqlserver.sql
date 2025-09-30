USE FeriaColombiaDB;
GO

CREATE SCHEMA ferias_schema;
GO
CREATE SCHEMA empresas_schema;
GO
CREATE SCHEMA visitantes_schema;
GO
CREATE SCHEMA admin_schema;
GO

ALTER SCHEMA ferias_schema TRANSFER dbo.Feria;
ALTER SCHEMA ferias_schema TRANSFER dbo.Pabellon;
ALTER SCHEMA ferias_schema TRANSFER dbo.Tematica;

ALTER SCHEMA empresas_schema TRANSFER dbo.Empresa;
ALTER SCHEMA empresas_schema TRANSFER dbo.Stand;
ALTER SCHEMA empresas_schema TRANSFER dbo.Producto;
ALTER SCHEMA empresas_schema TRANSFER dbo.Responsable;


ALTER SCHEMA visitantes_schema TRANSFER dbo.Persona;
ALTER SCHEMA visitantes_schema TRANSFER dbo.Ponente;
ALTER SCHEMA visitantes_schema TRANSFER dbo.Tipo_Visitante;
ALTER SCHEMA visitantes_schema TRANSFER dbo.Visitante;
ALTER SCHEMA visitantes_schema TRANSFER dbo.Charla;
ALTER SCHEMA visitantes_schema TRANSFER dbo.Demostraciones;
ALTER SCHEMA visitantes_schema TRANSFER dbo.Registo;


-- Usuario Ferias
CREATE LOGIN Carlos_Ferias WITH PASSWORD = 'Carlos123$';
CREATE USER Carlos_Ferias FOR LOGIN Carlos_Ferias WITH DEFAULT_SCHEMA = ferias_schema;

-- Usuario Empresas
CREATE LOGIN Laura_Empresas WITH PASSWORD = 'Laura123$';
CREATE USER Laura_Empresas FOR LOGIN Laura_Empresas WITH DEFAULT_SCHEMA = empresas_schema;

-- Usuario Visitantes
CREATE LOGIN Miguel_Visitantes WITH PASSWORD = 'Miguel123$';
CREATE USER Miguel_Visitantes FOR LOGIN Miguel_Visitantes WITH DEFAULT_SCHEMA = visitantes_schema;

-- Usuario Administrador
CREATE LOGIN Admin_FIT WITH PASSWORD = 'Admin123$';
CREATE USER Admin_FIT FOR LOGIN Admin_FIT WITH DEFAULT_SCHEMA = admin_schema;
GO


-- 4. PERMISOS

-- Permisos para Carlos 
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::ferias_schema TO Carlos_Ferias;

-- Permisos para Laura
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::empresas_schema TO Laura_Empresas;

-- Permisos para Miguel 
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::visitantes_schema TO Miguel_Visitantes;

-- Permisos para Admin 
GRANT CONTROL ON DATABASE::FeriaColombiaDB TO Admin_FIT;
GO
