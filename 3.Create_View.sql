/*==================================================================
FielName: Create_View.sql
ProgrammerName: Joel Paul Merrington
Description: This file will be used to create a view for AshesByDawn
==================================================================*/

USE AshesByDawn
GO

IF EXISTS (SELECT Table_Name 
      FROM INFORMATION_SCHEMA.VIEWS
      WHERE Table_Name = 'vwBlockedAccounts')
BEGIN
      DROP VIEW vwBlockedAccounts
	  PRINT 'vwBlockedAccounts has been deleted'
END
GO

CREATE VIEW vwBlockedAccounts
AS  
SELECT Membership.accountName 
      FROM Membership
--JOIN Account ON Account.accountName = Membership.accountName
WHERE Membership.membershipStatus = 'Inactive'
GO

SELECT *
FROM vwBlockedAccounts
GO
----------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT Table_Name FROM INFORMATION_SCHEMA.VIEWS
      WHERE Table_Name = 'vwTopSkill ')
BEGIN
      DROP VIEW vwTopSkill 
	  PRINT 'vwTopSkill  has been deleted'
END
GO

CREATE VIEW vwTopSkill 
AS
SELECT TOP 20 PlayerCharacter.characterTeam, characterClass, characterSkillLevel, accountName, characterName
      FROM PlayerCharacter
      GROUP BY PlayerCharacter.characterSkillLevel, characterClass, accountName, characterName, characterTeam
      ORDER BY characterSkillLevel DESC
GO

SELECT *
FROM vwTopSkill
GO
-----------------------------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT Table_Name FROM INFORMATION_SCHEMA.VIEWS
      WHERE Table_Name = 'vwTopStackedItems')
BEGIN
      DROP VIEW vwTopStackedItems
	  PRINT 'vwTopStackedItems has been deleted'
END
GO

CREATE VIEW vwTopStackedItems
AS
SELECT TOP 20 Inventory.itemName, itemType, itemTypeQuantity
      FROM Inventory
      GROUP BY Inventory.itemTypeQuantity, itemType, itemName
      ORDER BY itemTypeQuantity DESC
GO

SELECT *
FROM vwTopStackedItems
GO
------------------------------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT Table_Name FROM INFORMATION_SCHEMA.VIEWS
      WHERE Table_Name = 'vwPopItems')
BEGIN
	  DROP VIEW vwPopItems
	  PRINT 'vwPopItems has been deleted'
END
GO

CREATE VIEW vwPopItems
AS
SELECT TOP 20 itemType,
COUNT(itemType) AS
Frequency
      FROM Inventory
      GROUP BY itemType
      ORDER BY Frequency
DESC
GO

SELECT *
FROM vwPopItems
GO