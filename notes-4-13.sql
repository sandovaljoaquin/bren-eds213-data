

SELECT DISTINCT Location 
    FROM Site 
    ORDER BY Location
    LIMIT 3;

-- FILTERING 
-- looks just like in R or Python 
SELECT * FROM Site WHERE Area < 200;
SELECT * FROM Site WHERE Area < 200 AND latitude > 60;

-- older style operators 

SELECT * FROM Site WHERE Code != 'iglo'; 

SELECT * FROM Site WHERE Code <> 'iglo'; == older style 

-- expression: the usual operators, plus lots functions like regex 

## EXPRESSIONS 
SELECT Site_name, Area*2.47 FROM Site;
SELECT Site_name, Area * 2.47 FROM Site;


SELECT Site_name, Area * 2.47 AS Area_acres FROM Site;

-- string concatenation 
-- old-style operator: ||
SELECT Site_name || ', ' || Location AS Full_name FROM Site;

-- there are probably other operators, lets see 

SELECT Site_name + Location FROM Site; <- doesnt work 

-- You have another fancy calculator 

SELECT 2 + 2;

-- adding "AS.." needs to come right after thing you want to name 
SELECT Site_name AS some_other_name FROM Site LIMIT 1;


## AGGREGATION & GROUPING 

-- How many rows are in this table?

SELECT COUNT(*) FROM Bird_nests;
-- The "*" in the above means, count rows 
-- We can also ask how many non_NULL values are there?

SELECT COUNT(*) FROM Species;

SELECT Count(Scientific_name) FROM Species;

-- Very handy to count number of distinct things 

SELECT COUNT(*) FROM Site; -- just an idiom, doesnt make sense 
SELECT COUNT(DISTINCT Location) FROM Site; 
SELECT COUNT(Location) FROM Site; -- number of non_NULL locations

-- Reminder from Monday 

SELECT DISTINCT Location FROM Site; 

-- The usual aggregation functions

SELECT AVG(Area) FROM Site;
SELECT MIN(Area) FROM Site;

-- This wont work but suppose we want to list 7 locations that occur in site table, along with average areas 

SELECT Location, AVG(Area) FROM Site; -- This doesnt work because its not grouped by anything 

-- enter grouping 

SELECT Location, AVG(Area) FROM Site GROUP BY Location;

-- Similar for counting 

SELECT Location, Count(*) FROM Site GROUP By Location; -- means number of rows 
-- for comparison 

- site, groupby(location) summarize(count = n())

-- We can site WHERE clauses:
SELECT Location, COUNT(*)
    FROM Site
    WHERE Location LIKE '%Canada' -- old-style patter-matching, NOT full regex, just wildcard (%)
    GROUP BY Location;

-- the order of the clauses relects the order of the processing but what if you want to do some filtering on your groups, i.e., after you've done grouping?

SELECT Location, MAX(Area) AS Max_area 
    FROM Site
    WHERE Location LIKE '%Canada' -- filter; subset of rows 
    GROUP BY Location -- by Location attribute in Site table 
    HAVING Max_area > 200 -- rows are collapsed 
    ORDER BY Max_area DESC;  -- order 

## RELATIONAL ALGEBRA 

-- Everything is a table 
-- EVery query, every statement actually, returns a table 

SELECT COUNT(*) FROM Site;
-- you can save tables, you can nest queries 

SELECT COUNT(*) FROM (SELECT COUNT(*) FROM Site);

-- You can nest queries 

SELECT DISTINCT Species FROM Bird_nests;

SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

## NULL processing 
-- NULL is infecious 
-- In a table, NULL means no data, the absence of a value
-- In an expression, NULL means unknown 

SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = 'float';
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod <> 'float'; 

-- This wont work but you will try it anyways 

SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = NULL; 
-- The only way to: 

SELECT COUNT(*) FROM Bird_nests WHERE ageMethod IS NULL;
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod IS NOT NULL;
-- soc alled tri value logic 

-- JOINS 
-- 90% of the time, we'll join tables based on a foreign key relationship

SELECT * FROM Camp_assignment;
SELECT * FROM Camp_assignment JOIN Personnel 
     ON Observer = Abbreviation 
     LIMIT 10;

-- Join is a very gentle operation, can be applied to any tables, with any expression joining them 
-- fundamentally, joins always start from Cartesian product of the table
-- CROSS JOIN = Cartesian product

SELECT * FROM Site CROSS JOIN Species;
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) FROM Species; 

SELECT 99*16; 

-- any condition can be expression, we have complete freedom here

-- But when there is a foreign key relationship, then 
-- what happens?
-- the result is the same as a table with a foreign key but augmented with additional columns 

SELECT * FROM Bird_nests BN JOIN Species S
    ON BN.Species = S.Code
    LIMIT 5;

SELECT COUNT(*) FROM Bird_nests BN JOIN Species S 
    ON BN.Species = S.Code; 

-- Table aliases

-- Sometimes, if column names are ambiguous where theyre coming from, need to qualify them

SELECT * FROM Bird_nests JOIN Species
    ON Bird_nests.Species = Species.Code;


SELECT * FROM Bird_nests AS BN JOIN Species AS S
    ON BN.Species = S.Code;

-- even more compact, leave out AS 

SELECT * FROM Bird_nests BN JOIN Species S
    ON BN.Species = S.Code;