SELECT a.PlaylistId, a.Name, ROUND(SUM(c.Milliseconds) / 3600000.0, 2) AS LengthInHours
FROM playlists a
JOIN playlist_track b ON a.PlaylistId = b.PlaylistId
JOIN tracks c ON b.TrackId = c.TrackId
WHERE a.PlaylistId IS NOT NULL
AND a.name IS NOT NULL
AND c.Milliseconds IS NOT NULL
GROUP BY a.PlaylistId, a.Name
HAVING SUM(c.Milliseconds) > 7200000;