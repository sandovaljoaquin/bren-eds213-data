Joaquin Sandoval

-- Part 1 
SELECT Site_name, MAX(Area) FROM Site;

The above errors out: 
Binder Error:
column "Site_name" must appear in the GROUP BY clause or must be part of an aggregate function.
Either add it to the GROUP BY list, or use "ANY_VALUE(Site_name)" if the exact value of "Site_name" is not important.


MAX(Area) collapses the entire table down to a single value but Site_name has one 
value per row. DuckDB has no way to know which site name to display alongside that single max value. 

-- Part 2 using LIMIT to solve issue

SELECT Site_name, Area FROM Site -- select Site_name and Area from Site table
ORDER BY Area DESC LIMIT 1; -- sort by largest area & return top row 

-- Part 3 using nested query to solve issue

SELECT Site_name, Area FROM Site -- select Site_name and Area from Site table
WHERE Area = (SELECT MAX(Area) FROM Site); -- filter to rows where area = max area across whole table


