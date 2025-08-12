--Q: How do I extract the FIRST name from ContactName in dbo.t_w3_schools_customers?

-- A:  1. Check whether names have commas (Last, First) or spaces (First Last).
--     2. If comma exists, take text after comma as First/Middle.
--     3. Otherwise, take the first token before the first space as FirstName.
--  ContactName = Ann Devon - Ann

SELECT   t.ContactName

    FROM dbo.t_w3_schools_customers AS t
ORDER BY 1;