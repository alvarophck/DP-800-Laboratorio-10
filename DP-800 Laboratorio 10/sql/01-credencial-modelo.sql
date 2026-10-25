-- 01. Clave maestra, credencial con identidad administrada y modelo externo de embeddings
-- Sustituir <contrasena-compleja> por una contraseña real (mayúsculas, minúsculas, números y símbolo).

IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<contrasena-compleja>';
GO

CREATE DATABASE SCOPED CREDENTIAL [https://proj-sqlailab-agql-resource.openai.azure.com]
WITH IDENTITY = 'Managed Identity', SECRET = '{"resourceid":"https://cognitiveservices.azure.com"}';
GO

CREATE EXTERNAL MODEL my_embedding_model
WITH (
    LOCATION = 'https://proj-sqlailab-agql-resource.openai.azure.com/openai/deployments/text-embedding-3-small/embeddings?api-version=2024-10-21',
    API_FORMAT = 'Azure OpenAI',
    MODEL_TYPE = EMBEDDINGS,
    MODEL = 'text-embedding-3-small',
    CREDENTIAL = [https://proj-sqlailab-agql-resource.openai.azure.com]
);
GO
