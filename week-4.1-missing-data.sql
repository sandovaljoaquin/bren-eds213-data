
Joaquin Sandoval 

-- Which sites have no egg data? Answer this question using two techniques demonstrated in class 

-- Need to work with the Bird_eggs table and Site table or both 
-- Techniques: Using a Code NOT IN (subquery) clause 
-- Using an outer join with a WHERE clause that selects desired rows. Need to make sure IS NULL test is performed against column not ordinarily allowed to be NULL


-- Technique 1: Code NOT IN (subquery) clause 

SELECT Code FROM Site                                       -- Selecting site codes from Site table 
  WHERE Code NOT IN (SELECT DISTINCT Site FROM Bird_eggs);  -- that do not have egg observations


-- Tecnique 2: Using an outer join with a WHERE clause that selects desired rows.

SELECT Code                         -- site codes via Site table
    FROM Bird_eggs RIGHT JOIN Site  -- Right join: Bird_eggs table on Site table; all sites included 
    ON Site = Code                  -- Bird_eggs site column w/ Site code column 
    WHERE Site IS NULL              -- Selecting sites which have null values 
    ORDER BY Code;                  -- Alphabetical ordering 