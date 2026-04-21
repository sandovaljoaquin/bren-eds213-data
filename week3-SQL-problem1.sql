Joaquin Sandoval 

-- Part 1 
Does SQL abort with some kind of error? Does it ignore NULL values? Do the NULL values somehow factor into the calculation, and if so, how?

-- Create table with single column REAL data type
CREATE TEMP TABLE mytable (val REAL);

-- Insert real numbers and NULL value into column 
INSERT INTO mytable (val) VALUES (1.5), (2.3), (NULL);

-- Viewing table
SELECT * FROM mytable;

-- Running AVG on val column from table
SELECT AVG(val) FROM mytable;

If AVG ignored NULLS, the value would be: (1.5 + 2.3)/2 = 1.9
If it somehow fatored in the NULL values, the value might be (1.5 + 2.3)/3 = 1.26

The value 1.899999976158142 is returned, AVG ignores NULL values in its calculation

-- Part 2

-- If SQL didn't have AVG function, compute manually: 

SELECT SUM(val)/COUNT(*) FROM mytable;
SELECT SUM(val)/COUNT(val) FROM mytable;

The second is correct. The first query sums the non-null values and divides by number of rows in val column (3).
The second query sums non-null values and divides by the real values in the val column (2). 


-- Delete table 
DROP TABLE mytable;