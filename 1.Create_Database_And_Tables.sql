/*========================================================================================
FileName: Create_Database_And_Tables.sql
Programmer: Joel Paul Merrington
Description: This query will create the database and tables with the necessary constraints
========================================================================================*/

USE Master
GO

IF EXISTS (SELECT name 
      FROM master.dbo.sysdatabases
      WHERE name = 'AshesByDawn')
BEGIN
      DROP DATABASE AshesByDawn
	  PRINT 'The Ashes By Dawn database has been deleted'
END

CREATE DATABASE AshesByDawn
ON Primary
      (NAME = 'AshesByDawn_Data',
	  FILENAME = 'C:\J3BJBN764_SQL_Project_1\AshesByDawn_data.mdf',
	  SIZE = 5MB,
	  FILEGROWTH = 10%)
LOG ON
      (NAME = 'AshesByDawn_Log',
	  FILENAME = 'C:\J3BJBN764_SQL_Project_1\AshesByDawn_Log.ldf',
	  SIZE = 5MB,
	  FILEGROWTH = 10%)
GO

USE AshesByDawn
GO

IF EXISTS (SELECT * FROM sys.objects
WHERE name = N'Account' and [type] = 'u')
BEGIN
DROP TABLE Account
END
GO

CREATE TABLE Account
(
	  accountName VARCHAR (40) NOT NULL,
	  accountTotalCharacters INT,
	  dateAccountActivated DATE,
	  dateAccountDeactivated DATE,
	  timeSpentHours INT,
	  timeSpentMins INT,
	  extraNews VARCHAR (3),
	  CONSTRAINT AccountName_PK PRIMARY KEY (accountName),
	  CONSTRAINT AccountName_UNIQUE UNIQUE (accountName),
	  CONSTRAINT CheckValidTime CHECK (timeSpentMins < 60)
)
GO

PRINT 'The Account Details table has been created'
GO

IF EXISTS (SELECT * FROM sys.objects
WHERE name = N'PlayerCharacter' and [type] = 'u')
BEGIN
DROP TABLE PlayerCharacter
END
GO

CREATE TABLE PlayerCharacter
(
      characterTeam VARCHAR (20) NOT NULL,
	  characterClass VARCHAR (20) NOT NULL,
	  characterSkillLevel INT,
	  accountName VARCHAR (40) NOT NULL,
	  characterName VARCHAR (20) NOT NULL,
	  CONSTRAINT CharacterName_PK PRIMARY KEY (characterName),
	  CONSTRAINT PlayerAccountName_FK FOREIGN KEY (accountName) REFERENCES Account (accountName)
      
)
GO

PRINT 'The Player Character table has been created'
GO

IF EXISTS (SELECT * FROM sys.objects
WHERE name = N'Membership' and [type] = 'u')
BEGIN
DROP TABLE Membership
END
GO

CREATE TABLE Membership
      (
      membershipFee MONEY NOT NULL,
	  membershipFeeStatus VARCHAR (6) NOT NULL,
	  membershipStatus VARCHAR (8) NOT NULL,
	  accountName VARCHAR (40) NOT NULL,
	  dateAccountActivated DATE, 
	  dateAccountDeactivated DATE,
	  timeSpentDays INT,
	  timeLeftDays INT,
	  CONSTRAINT MembershipAccountName_FK FOREIGN KEY (accountName) REFERENCES Account (accountName)
      )
GO

PRINT 'The Membership table has been created'
GO


IF EXISTS (SELECT * FROM sys.objects
WHERE name = N'Errors' and [type] = 'u')
BEGIN
DROP TABLE Errors
END
GO

CREATE TABLE Errors
(
      errorType VARCHAR (30),
	  timeAndDateOFError VARCHAR (40),
	  accountName VARCHAR (40) NOT NULL,
	  CONSTRAINT ErrorAccountName_FK FOREIGN KEY (accountName) REFERENCES Account (accountName)
)
GO

PRINT 'The Errors table has been created'
GO

IF EXISTS (SELECT * FROM sys.objects
WHERE name = N'Inventory' and [type] = 'u')
BEGIN
DROP TABLE Inventory
END
GO

CREATE TABLE Inventory
(
      itemName VARCHAR (30) NOT NULL,
	  itemType VARCHAR (30) NOT NULL,
	  itemTypeQuantity INT NOT NULL,
	  characterName VARCHAR (20) NOT NULL,
	  slotQuantity INT,
	  CONSTRAINT CheckCapacity CHECK (slotQuantity < 9),
	  CONSTRAINT CharacterName_FK FOREIGN KEY (characterName) REFERENCES PlayerCharacter (characterName)
)
GO

PRINT 'The Inventory table has been created'
GO