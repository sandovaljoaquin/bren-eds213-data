In some databases to do a Cartesian product you just do a JOIN without a condition, e.g., 
SELECT * FROM A JOIN B; 
**But** in DuckDB you have to say: 
SELECT * FROM A CROSS JOIN B; 


-- Let's a join condition, which can be any expression 

SELECT * FROM A JOIN B ON acol1 < bcol1; 

-- This is what's called an INNER JOIN 

SELECT * FROM A INNER JOIN B ON acol1 < bcol1;

-- Outer join: we're adding rows from one table that never got matched.

SELECT * FROM A RIGHT JOIN B ON acol1 < bcol1;

SELECT * FROM A LEFT JOIN B ON acol1 < bcol1; 

--Just for completeness(this is way more rare that you would want to do this): 

SELECT * FROM A FULL OUTER JOIN B ON acol1 < bcol1;

Now, joining on a foreign key relationship is way more common 
.schema


SELECT * FROM House; 
SELECT * FROM Student;

Typical thing to do: 

SELECT * FROM Student S Join House H ON S.House_ID = H.House_ID;

As an aside, without aliases: 

SELECT * FROM Student JOIN House ON Student.House_ID = House.House_ID

One nice benefit of joining on a column that has. the same name (i,e., House_ID here)

SELECT * FROM Student JOIN House USING (House_ID); -- default join is inner 

Meanwhile, back in the bird database:

SELECT COUNT(*) FROM Bird_eggs;

For better viewing: 
.mode line


SELECT * FROM Bird_eggs LIMIT 1;
SELECT * FROM Bird_eggs JOIN Bird_nests USING (Nest_ID) LIMIT 1;

SELECT COUNT(*) FROM Bird_eggs JOIN Bird_nests USING (Nest_ID);

.mode duckbox

Important point!!! Ordering is assuredly lost doing a JOIN. So dont say this: 
Ordering should always only be the very last thing 

-- Will run but order is lost, order clause should be last line

SELECT * FROM 
    (SELECT * FROM Bird_eggs ORDER BY Width)
    JOIN Bird_nests
    USING (Nest_ID); 


Gotcha with duckDB ... not as smart as some other databases

SELECT Nest_ID, COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    GROUP BY Nest_ID;


Some databases allow you to say: 
-- This gives an error, duckdb not smart enough 
SELECT Nest_ID, Species,  COUNT(*)
    FROM Bird_nests JOIN Bird_eggs USING (Nest_ID)
    GROUP BY Nest_ID;

-- Workaround 

SELECT Nest_ID, ANY_VALUE(Species), COUNT(*)
    FROM Bird_eggs JOIN Bird_nests USING (Nest_ID)
    GROUP BY Nest_ID; 

SELECT Nest_ID, Species, COUNT(*)
    FROM Bird_eggs JOIN Bird_nests USING (Nest_ID)
    GROUP BY Nest_ID, Species; 


SELECT Nest_ID, Species, Width, Length FROM 
    Bird_eggs JOIN Bird_nests USING (Nest_ID)
    ORDER BY Nest_ID, Egg_num
    LIMIT 10;

Can two species inhabit the same nest?
.table Bird_nests


CREATE TEMP TABLE mytable (val REAL);

INSERT INTO mytable (val) VALUES (1.5), (2.3), (NULL);

SELECT AVG(val) FROM mytable;