/*============================================================
FileName: Create_Triggers.sql
Programmer Name: Joel Merrington
Description: This file creates a trigger for the Ashes By Dawn
============================================================*/

USE AshesByDawn
GO

CREATE TRIGGER tr_Characters
ON PlayerCharacter
AFTER INSERT
AS
      PRINT'A new character has been added'
GO

CREATE TRIGGER tr_Accounts
ON Account
AFTER INSERT
AS
      PRINT'A new Account has been Registered'
GO
