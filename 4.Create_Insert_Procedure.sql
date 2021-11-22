/*==============================================================================
FielName: Create_Insert_Procedure.sql
ProgrammerName: Joel Paul Merrington
Description: This file will be used to create a insert procedure for AshesByDawn
==============================================================================*/

USE AshesByDawn
GO

IF EXISTS 
(
      SELECT type_desc, type
	  FROM sys.procedures WITH(NOLOCK)
	  WHERE NAME = 'spRegister'
)
      DROP PROCEDURE spRegister
GO

CREATE PROCEDURE spRegister
      @accountName VARCHAR (40),
	  @extraNews VARCHAR (3)
	 
AS

BEGIN
IF NOT EXISTS 
	  (
	  SELECT * 
	  FROM Account 
	  WHERE accountName = @accountName
	  )
BEGIN
      DECLARE
	        @accountTotalCharacters INT,
	        @dateAccountActivated DATE,
	        @dateAccountDeactived DATE,
			@timeSpentHours INT,
			@timeSpentMins INT
	  INSERT INTO Account 
			(
			accountName,
			accountTotalCharacters,
			dateAccountActivated,
			dateAccountDeactivated,
			extraNews,
			timeSpentHours,
			timeSpentMins
			)
      VALUES 
			( 
			@accountName,
			0,
			GETDATE(),
			DATEADD(DAY,14,GETDATE()),
			@extraNews,
			0,
			0
			)
	  ALTER TABLE Membership
      DROP Constraint MembershipAccountName_FK
	  INSERT INTO Membership
	        (
			membershipFee,
			membershipFeeStatus,
			membershipStatus,
			accountName,
			dateAccountActivated, 
			dateAccountDeactivated,
			timeSpentDays,
			timeLeftDays
			)
      VALUES
	        (
			35,
			'Paid',
			'Active',
			@accountName,
			GETDATE(),
			DATEADD(DAY,14,GETDATE()),
			0,
			DATEDIFF (DAY, (GETDATE()) , DATEADD(DAY,14,GETDATE())) 
			)
      ALTER TABLE Membership
      ADD CONSTRAINT [MembershipAccountName_FK]
      FOREIGN KEY (accountName)REFERENCES Account(accountName)
      PRINT 'Account registered'
END
ELSE
BEGIN
	  PRINT 'Account name already exists'
END
SELECT * 
FROM Account
SELECT *
FROM Membership
END
GO

------------------------------------------------------------------------------------

EXEC spRegister 'Haydnb', 'no'
GO

------------------------------------------------------------------------------------

IF EXISTS 
(
      SELECT type_desc, type
	  FROM sys.procedures WITH(NOLOCK)
	  WHERE NAME = 'spAddChar'
)
      DROP PROCEDURE spAddChar
GO

CREATE PROCEDURE spAddChar
      @characterTeam VARCHAR (20),
	  @characterClass VARCHAR (20),
      @characterName VARCHAR (20),
      @accountName VARCHAR (40)
AS
BEGIN
IF NOT EXISTS
      (
	  SELECT *
	  FROM PlayerCharacter
	  WHERE characterName = @characterName
	  )
BEGIN
DECLARE
      @characterSkillLevel INT
	  PRINT 'New character name ENGAGED'
      INSERT INTO PlayerCharacter 
	        (
			characterTeam, 
            characterClass, 
			characterSkillLevel, 
			characterName, 
			accountName
			)
	  VALUES 
	        (
	        @characterTeam, 
	        @characterClass, 
	        1, 
	        @characterName, 
	        @accountName
	        )
      PRINT 'Character successfully added to account'
			UPDATE Account
			SET accountTotalCharacters += 1
			WHERE @accountName = accountName
			SELECT * FROM Account
	  PRINT 'Character total successfully updated to account'
END
ELSE
BEGIN
      PRINT 'Character name is in use by another acccount'
END
SELECT * 
FROM PlayerCharacter
ORDER BY characterSkillLevel ASC
END
GO

------------------------------------------------------------------------------------

EXEC spAddChar 'Alliance', 'Wizard', 'Newb', 'Lowko'
GO

------------------------------------------------------------------------------------
