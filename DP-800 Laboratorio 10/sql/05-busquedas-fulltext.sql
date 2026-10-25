-- 05. Búsquedas de texto completo

-- CONTAINS: palabra exacta
SELECT r.ReviewTitle, r.ReviewText, r.Rating, p.Name AS ProductName
FROM dbo.ProductReview r
INNER JOIN SalesLT.Product p ON r.ProductID = p.ProductID
WHERE CONTAINS(r.ReviewText, 'puncture');
GO

-- FREETEXT: frase con formas flexionadas
SELECT TOP 10 r.ReviewTitle, r.ReviewText, r.Rating, p.Name AS ProductName
FROM dbo.ProductReview r
INNER JOIN SalesLT.Product p ON r.ProductID = p.ProductID
WHERE FREETEXT(r.ReviewText, 'warm gloves for cold winter commuting');
GO

-- CONTAINSTABLE: resultados con puntuación
SELECT TOP 10
    r.ReviewTitle, r.ReviewText, r.Rating, p.Name AS ProductName,
    ft.[RANK] AS FullTextRank
FROM dbo.ProductReview r
INNER JOIN SalesLT.Product p ON r.ProductID = p.ProductID
INNER JOIN CONTAINSTABLE(dbo.ProductReview, (ReviewTitle, ReviewText),
    'FORMSOF(INFLECTIONAL, mountain) AND FORMSOF(INFLECTIONAL, trail)') AS ft
    ON r.ReviewID = ft.[KEY]
ORDER BY ft.[RANK] DESC;
GO

-- Búsqueda por prefijo
SELECT r.ReviewTitle, r.ReviewText, r.Rating, p.Name AS ProductName
FROM dbo.ProductReview r
INNER JOIN SalesLT.Product p ON r.ProductID = p.ProductID
WHERE CONTAINS(r.ReviewText, '"comfort*"');
GO
