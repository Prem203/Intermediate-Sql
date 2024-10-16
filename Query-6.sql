SELECT DISTINCT(a.name), d.name, f.name
FROM artists a
INNER JOIN albums b ON a.ArtistId = b.ArtistId
INNER JOIN tracks c ON c.AlbumId = b.AlbumId
INNER JOIN media_types d ON d.MediaTypeId = c.MediaTypeId
INNER JOIN playlist_track e ON e.TrackId = c.TrackId
INNER JOIN playlists f ON f.PlaylistId = e.PlaylistId
WHERE d.name like "%MPEG%"
AND (f.name == 'Brazilian Music' OR f.name == 'Grunge')
AND a.name IS NOT NULL
AND d.name IS NOT NULL
AND f.name IS NOT NULL;