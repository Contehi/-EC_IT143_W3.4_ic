/*
Missing Index Details from SQLQuery4.sql - IBRAIDA.AdventureWorksLT2022 (IBRAIDA\HERITAGE_GROUP (67))
The Query Processor estimates that implementing the following index could improve the query cost by 86.6995%.
*/


USE [AdventureWorksLT2022]
GO
CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>]
ON [SalesLT].[Customer] ([LastName])

GO

