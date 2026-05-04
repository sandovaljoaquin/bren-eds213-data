-- Camp asisgnment: where each person worked and when 
-- Goal to find all pairs of people who worked at the same site 

SELECT A.Site, A.Observer AS Observer_1, B.Observer as Observer_2 -- Select only these attributes and rename
FROM Camp_assignment A
JOIN Camp_assignment B
  ON A.Site = B.Site            -- Step 1: Join 
  AND A.Start <= B.End          -- Step 2: Add clause selects rows where people worked at same site w overlapping date ranges 
  AND B.Start <= A.End
  WHERE A.Site = 'lkri'         -- Step 3: Only want ordered distinct pairs
  AND A.Observer < B.Observer;  

-- Bonus problem 

SELECT A.Site, PA.Name AS Name_1, PB.NAME AS Name_2
FROM Camp_assignment A                                -- Same as before, joining two Camp_assignments together
JOIN Camp_assignment B
  ON A.Site = B.Site
  AND A.Start <= B.End
  AND B.Start <= A.End
JOIN Personnel PA                                    -- Now Join Personnel: PA with A on observer/abbreviaton columns
  ON A.Observer = PA.Abbreviation
JOIN Personnel PB
  ON B.Observer = PB.Abbreviation                   -- Do the same but with PB on observer/abberviation
WHERE A.Site = 'lkri'                               -- Same as before, has to be after the next joins
  AND A.Observer < B.Observer
  ORDER BY PA.Name, PB.Name;                        -- Now order by Personnel attributes