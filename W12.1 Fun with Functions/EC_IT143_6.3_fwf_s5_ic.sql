CREATE FUNCTION dbo.ufn_GetFirstName (@FullName NVARCHAR(400))
RETURNS NVARCHAR(200)
AS
BEGIN
    /*
      Returns the first name found in @FullName.
      Logic:
      1. If there is a comma, assume "Last, First ..." and take the text after the comma, then take the first token.
      2. Else, assume "First [Middle] Last" and return the first token up to the first space.
      3. Trim spaces.
    */

    /*****************************************************************************************************************
    NAME: dbo.ufn_GetFirstName    
    PURPOSE:  extract the FIRST name from ContactName in dbo.t_w3_schools_customers

    MODIFICATION LOG:
    Ver      Date        Author        Description
    -----   ----------   -----------   -------------------------------------------------------------------------------
    1.0     08/08/2024   IJCONTEH       1. Built this script for EC IT143

    RUNTIME: 
    Xs

    NOTES: 
    Google Search on SQLServerCentral
    https://www.sqlservercentral.com/forums/topic/how-to-select-first-name-only
    ******************************************************************************************************************/

    DECLARE @FirstName AS NVARCHAR(100);

    -- If there's a comma, assume "Last, First ..." and get the part after the comma
    IF CHARINDEX(',', @FullName) > 0
    BEGIN
        SET @FullName = LTRIM(RTRIM(SUBSTRING(@FullName, CHARINDEX(',', @FullName) + 1, 400)));
    END

    -- Extract the first name from whatever remains
    SET @FirstName = LEFT(@FullName, CHARINDEX(' ', @FullName + ' ') - 1);

    RETURN @FirstName;
END;
GO
