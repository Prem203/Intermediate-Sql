SELECT COUNT(ArtistCount) as ArtistCount FROM
(SELECT COUNT(DISTINCT a.ArtistId) AS ArtistCount
FROM artists a
JOIN albums b ON a.ArtistId = b.ArtistId
JOIN tracks c ON c.AlbumId = b.AlbumId
JOIN media_types d ON d.MediaTypeId = c.MediaTypeId
WHERE d.Name LIKE '%MPEG%'
AND a.ArtistId IS NOT NULL
GROUP BY a.ArtistId
HAVING COUNT(c.TrackId) >= 10);