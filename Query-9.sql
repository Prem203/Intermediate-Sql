SELECT a.name AS ArtistName, c.name AS TrackName, c.Milliseconds / 1000 AS TrackDurationInSeconds, d.TrackRank
FROM artists a
JOIN albums b ON a.ArtistId = b.ArtistId
JOIN tracks c ON b.AlbumId = c.AlbumId
JOIN (
    SELECT c.TrackId, 
           ROW_NUMBER() OVER (PARTITION BY a.ArtistId ORDER BY c.Milliseconds DESC) AS TrackRank
    FROM artists a
    JOIN albums b ON a.ArtistId = b.ArtistId
    JOIN tracks c ON b.AlbumId = c.AlbumId
) d ON c.TrackId = d.TrackId
WHERE d.TrackRank <= 3
AND a.name IS NOT NULL
AND c.name IS NOT NULL
AND c.Milliseconds IS NOT NULL
ORDER BY a.name, d.TrackRank;
