/*======================================================
FileName: Create_Update_Procedure.sql
Programmer: Joel Paul Merrington
Description: This query will create an update procedure.
======================================================*/

USE AshesByDawn
GO

IF EXISTS 
(
      SELECT type_desc, type
	  FROM sys.procedures WITH(NOLOCK)
	  WHERE NAME = 'spAddTime'
)
      DROP PROCEDURE spAddTime
GO

CREATE PROCEDURE spAddTime
      @timeSpentHours INT,
      @timeSpentMins INT,
      @accountName VARCHAR (40)
AS
BEGIN
UPDATE Account
      SET Account.timeSpentHours += @timeSpentHours
      WHERE Account.accountName = @accountName
UPDATE Account
      SET timeSpentMins += @timeSpentMins
      WHERE Account.accountName = @accountName
END
SELECT * 
FROM Account

GO

------------------------------------------------------------------------------------------------

EXEC spAddTime 4, 1, 'HayRey'
GO

------------------------------------------------------------------------------------------------

IF EXISTS 
      (
      SELECT type_desc, type
	  FROM sys.procedures WITH(NOLOCK)
	  WHERE NAME = 'spAddItem'
      )
      DROP PROCEDURE spAddItem
GO

CREATE PROCEDURE spAddItem
      @itemName VARCHAR (30),
      @itemType VARCHAR (30),
      @itemTypeQuantity INT,
      @characterName VARCHAR (20) 
AS
BEGIN

IF NOT EXISTS 
      (
	  SELECT * 
	  FROM Inventory 
	  WHERE itemType = @itemType 
	  AND characterName = @characterName
	  ) -- if item new
BEGIN
      PRINT 'if item new ENGAGED'
      IF NOT EXISTS 
	        (
			SELECT * 
			FROM Inventory 
			WHERE characterName = @characterName 
			AND slotQuantity < 8
			) -- if no space
      BEGIN
	        DECLARE @slotQuantity INT
	        PRINT 'if no space ENGAGED'
	        PRINT 'Character has no space left in Inventory'
      END
	  IF NOT EXISTS 
	        (
			SELECT * 
			FROM Inventory 
			WHERE characterName = @characterName 
			AND slotQuantity = 8
			) -- if space
      BEGIN
	        PRINT 'if space ENGAGED'
            UPDATE Inventory
            SET @slotQuantity = slotQuantity += 1
            WHERE @characterName = characterName

            INSERT INTO Inventory
                  (
				  itemName,
                  itemType,
                  itemTypeQuantity,
                  characterName,
                  slotQuantity
	              )
            VALUES
                  (
				  @itemName,
                  @itemType,
                  @itemTypeQuantity,
                  @characterName,
                  @slotQuantity
	              )
      END
END
IF NOT EXISTS 
      (
	  SELECT * 
	  FROM Inventory 
	  WHERE itemType <> @itemType 
	  AND characterName <> @characterName
	  AND itemName <> itemName
	 
	  ) -- item not new
BEGIN
	  PRINT 'Else item not new ENGAGED'
	  UPDATE Inventory
      SET itemTypeQuantity += 1
      WHERE @characterName = characterName
	  AND @itemType = itemType
	  AND @itemName = itemName
      END
SELECT * 
FROM Inventory
ORDER BY slotQuantity ASC
END
GO

------------------------------------------------------------------------------------------------

EXEC spAddItem 'aaaaaaaaaaaa', 'Pleather', 1, 'Tyrael'
GO

------------------------------------------------------------------------------------------------

