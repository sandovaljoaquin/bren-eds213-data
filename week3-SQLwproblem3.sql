Joaquin Sandoval

-- List the scientific names of bird species in descending order of their maximum average egg volumes

-- group bird eggs by nest and compute average volumes

CREATE TEMP TABLE Averages AS  -- Create temporary table called Averages
    SELECT Nest_ID, AVG((3.14/6.0) * Width * Width * Length) AS Avg_volume  -- calculate average egg volume per nest
        FROM Bird_eggs  -- from the Bird_eggs table
        GROUP BY Nest_ID;  -- group rows by nest


-- Join table with Bird_nests & group by species 
SELECT Scientific_name, MAX(Avg_volume) AS Max_avg_volume  -- get scientific name and max average volume
    FROM Bird_nests
    JOIN Averages USING (Nest_ID)  -- join Averages temp table on Nest_ID
    JOIN Species ON Bird_nests.Species = Species.Code  -- join Species table to get scientific name
    GROUP BY Scientific_name  -- group results by species
    ORDER BY Max_avg_volume DESC;  -- sort by largest volume first
