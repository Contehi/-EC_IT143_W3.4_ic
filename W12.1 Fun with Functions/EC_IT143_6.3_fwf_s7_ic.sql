--Q: How do I extract the FIRST name from ContactName in dbo.t_w3_schools_customers?

-- A:  1. Check whether names have commas (Last, First) or spaces (First Last).
--     2. If comma exists, take text after comma as First/Middle.
--     3. Otherwise, take the first token before the first space as FirstName.
-- Goggle Search "How to select first name only SQLServerCentral Forum"

--https://stackoverflow.com/questions/5145791/extracting-first-name-and-last-name


WITH computed AS
(
    SELECT
        ContactName,
        
        -- Ad-hoc first name logic
        CASE 
            WHEN CHARINDEX(',', ContactName) > 0 
                THEN LTRIM(RTRIM(SUBSTRING(ContactName, CHARINDEX(',', ContactName) + 1, 200)))
            WHEN CHARINDEX(' ', ContactName) > 0 
                THEN LEFT(ContactName, CHARINDEX(' ', ContactName) - 1)
            ELSE ContactName 
        END AS first_name,

        -- UDF-based first name
        dbo.ufn_GetFirstName(ContactName) AS first_name2
    FROM dbo.t_w3_schools_customers
)

SELECT *
FROM computed
WHERE first_name <> first_name2;
-- Expectation: 0 rows returned if UDF matches ad-hoc logic exactly
