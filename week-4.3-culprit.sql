Joaquin Sandoval 
-- Week 4.3 - Who’s the culprit?
SELECT P.Name, COUNT(*) AS Num_floated_nests
FROM Bird_nests BN
-- Join to Personnel table to acquire full name
JOIN Personnel P ON BN.Observer = P.Abbreviation
WHERE BN.Site = 'nome'                    -- filter to nome site
  AND BN.Year BETWEEN 1998 AND 2008       -- year range 
  AND BN.ageMethod = 'float'              -- only nests which egg age was determined via floating
GROUP BY P.Name                          -- one row per observer
HAVING COUNT(*) = 36;                    -- keep the observer who floated eggs from 36 nests