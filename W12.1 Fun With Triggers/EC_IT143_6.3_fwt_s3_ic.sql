--Q1: How to keep track of when a record was last modified.
--A1: Add columns to the table: LastModifiedDate datetime2
     --Create an AFTER UPDATE trigger that sets those columns when a row is updated.

--Q2: How to keep track of who last modified a record.
--A2: LastModifiedBy sysname (or nvarchar(200)).

--Use inserted pseudo-table to update only modified rows.

-- https://learn.microsoft.com/en-us/sql/t-sql/statements/create-trigger-transact-sql?view=sql-server-ver17
-- https://community.claris.com/en/s/question/0D50H00006h9FwBSAU/track-who-created-or-modified-a-record
