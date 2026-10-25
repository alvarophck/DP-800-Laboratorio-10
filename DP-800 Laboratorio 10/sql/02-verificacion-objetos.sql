-- 02. Comprobar que existen la clave maestra, la credencial y el modelo externo
SELECT 'Master key' AS Objeto, name AS Nombre FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##'
UNION ALL
SELECT 'Credencial', name FROM sys.database_scoped_credentials
UNION ALL
SELECT 'Modelo externo', name FROM sys.external_models;
GO
