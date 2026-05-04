# To verify that we have the right database open, look what tables are in the database:
.table

# To see the DuckDB - specific commands, do this: 
.help

# .exit to exit or Cntrl-D 

# In SQL, comments are delimitted with --

-- .table -- lists tables 
-- .schema -- lists the whole schema 
.schema


-- Getting help on SQL look like railroad diagram in SQLite 

-- Our first query 
-- The * means all columns; all rows are implied because we didnt specify a where clause 

SELECT * FROM Species; 

-- A couple gotchas 
-- 1. Dont forget the closing semicolon, DuckDB will wait for it forever 
-- 2. Watch for the missing closing quotes 

-- To see just a few rows:
SELECT * FROM Species LIMIT 5;
-- Can also "page" through the rows

SELECT * FROM Species LIMIT 5 OFFSET 5; 


-- Of course we can just select which columns we want 
SELECT Code, Scientific_name FROM Species; 


-- Another handy query to explore data:

SELECT Species FROM Bird_nests;
SELECT DISTINCT Species FROM Bird_nests;

-- Can also get distinct pairs or tuples that occur 
SELECT DISTINCT Species, Observer FROM Bird_nests;

-- Can ask that the results be ordered 

SELECT Scientific_name FROM Species;
SELECT Scientific_name FROM Species ORDER BY Scientific_name DESC;



-- The default ordering (which is undefined) can be subtle
SELECT DISTINCT Species FROM Bird_nests;

SELECT DISTINCT Species FROM Bird_nests LIMIT 3;

-- Surprising 

-- Let's try again but ask the results be ordered 
SELECT DISTINCT Species FROM Bird_nests ORDER BY Species;
SELECT DISTINCT Species FROM Bird_nests ORDER BY Species LIMIT 3;

-- In class challenge: 
-- Select distinct locations from the Site table; are they in order? If not, order them.

SELECT DISTINCT Location FROM Site;