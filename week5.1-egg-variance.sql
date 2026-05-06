Joaquin Sandoval 
-- PART 1 -- 
-- STEP 1 
CREATE TABLE Nests_big AS SELECT * FROM 'nests_big.csv';
CREATE TABLE Eggs_big AS SELECT * FROM 'eggs_big.csv';

-- Investigate 
SELECT * FROM Eggs_big;     -- **Nest_ID**, Egg_num, Length, Width 
SELECT * FROM Nests_big;    -- Site, **Nest_ID**, **Species**
SELECT * FROM Species;      -- **Code**, Common_name, Scientific_name, Relevance 
SELECT * FROM Site;         -- **Code** Site_name, Location, Latitude, Longitude, Area

-- STEP 2 
-- 3-way join between Eggs_big, Nests_big, and Species tables 
SELECT * FROM Eggs_big                                              -- all rows from whole table 
  JOIN Nests_big USING (Nest_ID)                                    -- Join Nests_big on Egg_big using Nest_ID column 
  JOIN Species ON Nests_big.Species = Species.Code                  -- JOIN Species table on Nests_big Species column on Species Code column 
WHERE Species.Scientific_name = 'Calidris alpina';                  -- Filter for C. alpina

-- STEP 3
-- Modifying above code 
SELECT Site, 3.14/6 * Width * Width * Length AS Volume
FROM Eggs_big
  JOIN Nests_big USING (Nest_ID)
  JOIN Species ON Nests_big.Species = Species.Code
WHERE Species.Scientific_name = 'Calidris alpina'; 

-- STEP 4 
-- Modifying above code 
SELECT Longitude, 3.14/6 * Width * Width * Length AS Volume,        -- Select Longitude columnn and Volume column 
FROM Eggs_big
  JOIN Nests_big USING (Nest_ID)
  JOIN Species ON Nests_big.Species = Species.Code
  JOIN Site ON Nests_big.Site = Site.Code                           -- Joining site table to the mix 
WHERE Species.Scientific_name = 'Calidris alpina'; 

-- Step 5 
-- Modifying above code 
SELECT 
  CASE WHEN Longitude > 0 THEN Longitude - 360 ELSE Longitude END AS Longitude,
  Nests_big.Site,
  PI()/6 * Width * Width * Length AS volume
FROM Eggs_big
  JOIN Nests_big USING (Nest_ID)
  JOIN Species ON Nests_big.Species = Species.Code
  JOIN Site ON Nests_big.Site = Site.Code
WHERE Species.Scientific_name = 'Calidris alpina';

-- Step 6 Save above code to temporary table 
CREATE TEMP TABLE C_alpina_eggs AS
SELECT 
  CASE WHEN Longitude > 0 THEN Longitude - 360 ELSE Longitude END AS Longitude,
  Nests_big.Site,
  PI()/6 * Width * Width * Length AS volume
FROM Eggs_big
  JOIN Nests_big USING (Nest_ID)
  JOIN Species ON Nests_big.Species = Species.Code
  JOIN Site ON Nests_big.Site = Site.Code
WHERE Species.Scientific_name = 'Calidris alpina';

-- Step 7 
SELECT 
  regr_slope(volume, Longitude) AS Slope,
  corr(volume, Longitude) AS PCC
FROM C_alpina_eggs;

-- PART 2 -- 
1. Do the tables created automatically by DuckDB guarantee that a nest ID mentioned in the Eggs_big 
table actually exists in the Nests_big table? If yes, explain how that is guaranteed, if not, explain why not. (6pts)

No because we read in tables from a csv file and there were no explicit foreign key constraints. If an egg was in a nest_id that 
did not exist in the Big_nests table, they would be dropped. 

2. What queries did you use (or could you use) to find the minimum and maximum longitude values in the Site table? (2pts)

SELECT MIN(Longitude), MAX(Longitude) FROM Site;

3. The interpretation of the Pearson correlation coefficient is: +1 is a perfect positive correlation, -1 is a perfect negative 
correlation, and 0 is no correlation at all. How would you characterize the correlation between egg volume and longitude for the 
eggs of Calidris alpina in the Arctic above Canada? (2pts)

There was a very weak negative correlation between egg volume and longitude (~ -0.108) for C. alpina. 



