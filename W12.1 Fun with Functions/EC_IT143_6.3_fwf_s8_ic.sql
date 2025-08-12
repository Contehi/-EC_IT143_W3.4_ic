
--Q: How do I extract the LAST NAME from ContactName in dbo.t_w3_schools_customers?

SELECT 
    ContactName,
    LTRIM(RIGHT(ContactName, LEN(ContactName) - CHARINDEX(' ', ContactName))) AS LastName
FROM dbo.t_w3_schools_customers;
