Assignment 4 Submission by Prem Vora

# Music Video Queries

Some fun intermediate queries for a music database.

## Step 1. Start the Sqllite3 DB Browser and download the Database:

Downlaod the Sample Relational DB called Media Database from the link: https://www.sqlitetutorial.net/sqlite-sample-database/ 
and unzip it in the root folder of your project.

## Step 2. Run the Queries:

Open the Database in your Sqllite Browser and run the .sql file one by one.

### Query 1: Queries what are the last names and emails of all customer who made purchased in the store.

```
SELECT DISTINCT(Email), LastName
FROM customers c
INNER JOIN invoices i ON c.CustomerId = i.CustomerId
WHERE Email IS NOT NULL
AND LastName IS NOT NULL;
```

### Query 2: Queries what are the names of each album and the artist who created it.

```
SELECT DISTINCT(Title), name
FROM albums a
INNER JOIN artists b ON a.ArtistId = b.ArtistId
WHERE Title IS NOT NULL
AND name IS NOT NULL;
```

### Query 3: Queries what are the total number of unique customers for each state, ordered alphabetically by state.

```
SELECT State, COUNT(DISTINCT CustomerId) AS TotalCustomers
FROM customers
WHERE State IS NOT NULL
AND CustomerId IS NOT NULL
GROUP BY State
ORDER BY State;
```

### Query 4: Queries which states have more than 10 unique customers?

```
SELECT State, COUNT(DISTINCT CustomerId) AS TotalCustomers
FROM customers
WHERE State IS NOT NULL
AND CustomerId IS NOT NULL
GROUP BY State
HAVING COUNT(DISTINCT CustomerId) > 10
ORDER BY State;
```

### Query 5: Queries what are the names of the artists who made an album containing the substring "symphony" in the album title?

```
SELECT a.Name AS ArtistName, al.Title
FROM artists a
JOIN albums al ON a.ArtistId = al.ArtistId
WHERE al.Title LIKE '%symphony%'
AND ArtistName IS NOT NULL
AND al.Title IS NOT NULL;
```

### Query 6: Queries what are the names of all artists who performed MPEG (video or audio) tracks in either the "Brazilian Music" or the "Grunge" playlists?

```
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
```

### Query 7: Queries how many artists published at least 10 MPEG tracks?

```
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
```

### Query 8: Lists the playlist id and name of only those playlists that are longer than 2 hours, along with the length in hours rounded to two decimals.

```
SELECT a.PlaylistId, a.Name, ROUND(SUM(c.Milliseconds) / 3600000.0, 2) AS LengthInHours
FROM playlists a
JOIN playlist_track b ON a.PlaylistId = b.PlaylistId
JOIN tracks c ON b.TrackId = c.TrackId
WHERE a.PlaylistId IS NOT NULL
AND a.name IS NOT NULL
AND c.Milliseconds IS NOT NULL
GROUP BY a.PlaylistId, a.Name
HAVING SUM(c.Milliseconds) > 7200000;
```

### Query 9: Creative addition: Define a new meaningful query using at least three tables, and some window function. Explain clearly what your query achieves, and what the results mean.

This query lists the top 3 longest tracks for each artist, sorted by the duration of the track in descending order. The query uses the ROW_NUMBER() window function to assign a rank to each track based on its duration within the group of tracks for each artist.

```
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
```
