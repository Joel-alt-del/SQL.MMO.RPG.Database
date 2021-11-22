/*==========================================================
FileName: Create_Indexes.sql
Programmer Name: Joel Merrington
Description: This file creates two indexes for Ashes By Dawn
==========================================================*/

USE AshesByDawn
GO


CREATE INDEX idx_Characters
ON PlayerCharacter 
(
   characterName
)
GO

CREATE INDEX idx_Accounts
ON Account
(
   accountName
)
GO