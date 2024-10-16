SELECT a.Name AS ArtistName, al.Title
FROM artists a
JOIN albums al ON a.ArtistId = al.ArtistId
WHERE al.Title LIKE '%symphony%'
AND ArtistName IS NOT NULL
AND al.Title IS NOT NULL;