---First review ite: tri-value logic 
---Expressios can have a value (if Boolean, TRUE or FALSE), they can also be NULL
---In selecting rows, NULL doesn't cut it, NULL doesnt count as TRUE

SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge < 7 OR floatAge >= 7; 

SELECT COUNT(*) FROM Bird_nests
    WHERE floatAge IS NULL;

-- Review item: relational algebra 
-- Everything is a table. Every operation returns a table
-- Even a simple COUNT(*) returns a table 

SELECT COUNT(*) FROM Bird_nests;

We looked at one example of nesting SELECTs 

SELECT Scientific_name 
    FROM Species
    WHERE Code NOT IN ( SELECT DISTINCT Species FROM Bird_nests);

Let's pretend that SQL didnt have a HAVING clause. Could we somehow get the same functionality?
Let's go back to the example where we used a HAVING clause

SELECT Location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada' -- % pattern matching: if Location contains Canada 
    GROUP BY Location
    HAVING Max_area > 200;  -- Having clause applies to groups. WHERE applies to rows 

As a reminder, the Site table: 
SELECT * FROM Site LIMIT 5; 


SELECT * FROM 
        (SELECT Location, MAX(Area) AS Max_area
        FROM Site
        WHERE Location LIKE '%Canada' -- % pattern matching: if Location contains Canada 
        GROUP BY Location)
    WHERE Max_area > 200; 


    REVIEW AND CONTINUE DISCUSSION OF JOINS 