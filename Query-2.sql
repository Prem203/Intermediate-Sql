SELECT DISTINCT(Title), name
FROM albums a
INNER JOIN artists b ON a.ArtistId = b.ArtistId
WHERE Title IS NOT NULL
AND name IS NOT NULL;