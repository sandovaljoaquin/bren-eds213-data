SELECT * FROM A;
SELECT * FROM B; 


SELECT * FROM A CROSS JOIN B;

-- CROSS JOIN REVIEW
SELECT acol1, acol2, FROM (SELECT * FROM A CROSS JOIN B); -- selects two columns from the CROSS JOIN 

-- SELECT always select columns from the output compyted after the FROM 
SELECT acol1, ANY_VALUE(acol2), COUNT(*) -- Counting number of rows in each group 
    FROM (SELECT * FROM A CROSS JOIN B)
    GROUP BY acol1;

-- Difference between COUNT (*) == number of rows & COUNT(column) == Non-NULL values in that column or group 
SELECT acol1, ANY_VALUE(acol2), COUNT(bcol3) -- Counting number of rows in each group, ignores NULL values 
    FROM (SELECT * FROM A CROSS JOIN B)
    GROUP BY acol1;

-- USING a condition 

SELECT * FROM A JOIN B ON acol1 < bcol1;

-- INNER or OUTER JOINS 
SELECT * FROM Student;
SELECT * FROM House;

-- INNER 

SELECT * FROM Student AS S JOIN House AS H ON S.House_ID = H.House_ID; -- JOIN does INNER JOIN 
-- Requires the same column names 
SELECT * FROM Student JOIN House USING (House_ID);


-- OUTER JOIN 

SELECT * FROM Student FULL JOIN House USING (House_ID); -- There is no student in HP

-- LEFT JOIN 
SELECT * FROM Student LEFT JOIN House USING (House_ID); -- keeps rows in left table (Student) and match

-- RIGHT JOIN 
SELECT * FROM Student LEFT JOIN House USING (House_ID); -- keeps rows in right table (House) and match  

SELECT * FROM Student CROSS JOIN 


-- Create table and set restrictions
CREATE TABLE Snow_cover (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 AND 2018),
    Date DATE NOT NULL,
    Plot VARCHAR NOT NULL,
    Location VARCHAR NOT NULL,
    Snow_cover REAL CHECK (Snow_cover BETWEEN 0 AND 130),
    Water_cover REAL CHECK (Water_cover BETWEEN 0 AND 130),
    Land_cover REAL CHECK (Land_cover BETWEEN 0 AND 130),
    Total_cover REAL CHECK (Total_cover BETWEEN 0 AND 130),
    Observer VARCHAR,
    Notes VARCHAR,
    PRIMARY KEY (Site, Plot, Location, Date),
    FOREIGN KEY (Site) REFERENCES Site (Code)
);

SELECT * FROM Snow_cover; -- No data here yet 

-- Import data 
COPY Snow_cover FROM "../ASDN_csv/snow_survey_fixed.csv" (header TRUE, nullstr "NA"); -- ".." means go outside of database folder, then "ASDN_csv", then the file 

SELECT * FROM Snow_cover LIMIT 5;

-- Create temporary table that deletes at the end of your session 
CREATE TEMP TABLE Camp_assignment_copy AS
   SELECT * FROM Camp_assignment;

.table

SELECT * FROM Camp_assignment_copy LIMIT 5;

SELECT * FROM Personnel LIMIT 5;

SELECT Year, Site, Name FROM Camp_assignment_copy JOIN Personnel ON Observer = Abbreviation;


-- Creating a view, make sure to designate it as a view in the title 
CREATE VIEW Camp_personnel_v AS
   SELECT Year, Site, Name 
   FROM Camp_assignment_copy JOIN Personnel ON Observer = Abbreviation;

.table

-- List views in duckDB

SELECT view_name FROM duckdb_views;

DANGER ZONE 

-- View rows with Site: bylo 

SELECT * FROM Camp_assignment_copy WHERE Site == 'bylo';

DELETE FROM Camp_assignment_copy WHERE Site == 'bylo';

SELECT * FROM Camp_personnel_v LIMIT 10;
