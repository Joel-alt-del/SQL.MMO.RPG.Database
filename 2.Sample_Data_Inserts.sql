/*============================================================
FileName: Sample_Data_Inserts.sql
Programmer: Joel Paul Merrington
Description: This file will insert sample data in the database
============================================================*/

USE AshesByDawn
GO

INSERT INTO Account 
      (
	  accountName,
	  extraNews,
	  accountTotalCharacters, 
	  timeSpentHours, 
	  timeSpentMins,
	  dateAccountActivated,
	  dateAccountDeactivated
	  )
VALUES
      ('Lowko', 'yes', 6, 78, 45, (SELECT GETDATE()), (SELECT DATEADD(DAY,14,GETDATE()))),
      ('MountainMoose', 'yes', 6, 67, 38, (SELECT GETDATE()), (SELECT DATEADD(DAY,14,GETDATE()))),
	  ('DaKille', 'yes', 7, 105, 27, (SELECT DATEADD(DAY,-21,GETDATE())), (SELECT DATEADD(DAY,-7,GETDATE()))),
	  ('JabbaDaMutt', 'yes', 4, 61, 23, (SELECT DATEADD(DAY,-24,GETDATE())), (SELECT DATEADD(DAY,-10,GETDATE()))),
	  ('HayRey', 'no', 1, 23,57, (SELECT GETDATE()), (SELECT DATEADD(DAY,14,GETDATE())))
GO

----------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE PlayerCharacter
DROP CONSTRAINT PlayerAccountName_FK

INSERT INTO PlayerCharacter 
      (
	  characterTeam, 
	  characterClass, 
	  characterSkillLevel, 
	  accountName, 
	  characterName
	  )

VALUES('Alliance', 'SwordsMan', 99, 'Lowko', 'AlexanderTheSlayer'),
      ('Alliance', 'SwordsMan', 99, 'MountainMoose', 'Clem'),
	  ('Alliance', 'SwordsMan', 85, 'DaKille', 'PetroleumJelly'),
	  ('Alliance', 'SwordsMan', 78, 'JabbaDaMutt', 'PlayaFlave'),
	  ('Alliance', 'SwordsMan', 72, 'HayRey', 'gdajwn678'),
	  ('Alliance', 'SwordsMan', 68, 'DaKille', 'MikeTheKite'),
	  ('Alliance', 'Archer', 99, 'MountainMoose', 'Jason'),
	  ('Alliance', 'Archer', 85, 'Lowko', 'Greg33'),
	  ('Alliance', 'Archer', 84, 'DaKille', 'SirLaxeetive'),
	  ('Alliance', 'Wizard', 99, 'DaKille', 'Exxxxxxtra'),
	  ('Alliance', 'Wizard', 86, 'MountainMoose', 'AllGoodNamesTaken'),
	  ('Alliance', 'Wizard', 52, 'Lowko', 'SirPantsalot'),
	  ('Hoard', 'SwordsMan', 99, 'JabbaDaMutt', 'BKind'),
	  ('Hoard', 'SwordsMan', 86, 'MountainMoose', 'Tyrael'),
	  ('Hoard', 'SwordsMan', 82, 'DaKille', 'Lilith'), 
      ('Hoard', 'SwordsMan', 79, 'JabbaDaMutt', 'MarcusAllPennyless'),
	  ('Hoard', 'SwordsMan', 42, 'Lowko', 'DarftInvader'), 
	  ('Hoard', 'SwordsMan', 31, 'JabbaDaMutt', 'Noob83'),  
	  ('Hoard', 'Archer', 99, 'DaKille', 'Kill4u'),
	  ('Hoard', 'Archer', 85, 'MountainMoose', 'BloodiedMess'),
	  ('Hoard', 'Archer', 42, 'Lowko', 'Belzebub'),
	  ('Hoard', 'Wizard', 99, 'DaKille', 'ButchersCleaver'),
	  ('Hoard', 'Wizard', 72, 'MountainMoose', 'ButcherOfMen'),
	  ('Hoard', 'Wizard', 13, 'Lowko', 'WidowMaker')

ALTER TABLE PlayerCharacter
ADD CONSTRAINT [PlayerAccountName_FK]
FOREIGN KEY (accountName)REFERENCES Account(accountName)

GO

----------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE Membership
DROP CONSTRAINT MembershipAccountName_FK

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
VALUES($35, 'Paid', 'Active', 'Lowko', (SELECT GETDATE()), (SELECT DATEADD(DAY,14,GETDATE())), 0, 14),
      ($35, 'Paid', 'Active', 'MountainMoose',(SELECT GETDATE()), (SELECT DATEADD(DAY,14,GETDATE())), 0, 14),
	  ($35, 'Paid', 'Active', 'HayRey',(SELECT GETDATE()), (SELECT DATEADD(DAY,14,GETDATE())), 0, 14),
	  ($35, 'Unpaid', 'Inactive', 'DaKille',(SELECT DATEADD(DAY,-21,GETDATE())), (SELECT DATEADD(DAY,-7,GETDATE())), 0, 0),
	  ($35, 'Unpaid', 'Inactive', 'JabbaDaMutt',(SELECT DATEADD(DAY,-24,GETDATE())), (SELECT DATEADD(DAY,-10,GETDATE())), 0, 0)


ALTER TABLE Membership
ADD CONSTRAINT [MembershipAccountName_FK]
FOREIGN KEY (accountName)REFERENCES Account(accountName)

select * from membership

GO

----------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE Errors
DROP CONSTRAINT ErrorAccountName_FK

INSERT INTO Errors 
      (
	  errorType, 
	  timeAndDateOfError, 
	  accountName
	  )
VALUES('ValueError', (SELECT GETDATE()), 'DaKille'),
	  ('AuthenticationError', (SELECT GETDATE()), 'DaKille'),
	  ('AccountError04', (SELECT GETDATE()), 'MountainMoose'),
	  ('AuthenticationError', (SELECT GETDATE()), 'DaKille')

ALTER TABLE Errors
ADD CONSTRAINT [ErrorAccountName_FK]
FOREIGN KEY (accountName)REFERENCES Account(accountName)

GO

----------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE Inventory
DROP CONSTRAINT CharacterName_FK

INSERT INTO Inventory 
      (
	  itemName, 
	  itemType, 
	  itemTypeQuantity, 
	  characterName, 
	  slotQuantity
	  )
VALUES('Elixir_Of_Health', 'HealthPotion', 6, 'WidowMaker', 7),
	  ('Elixir_Of_Power', 'ManaPotion', 4, 'Exxxxxxtra', 7),
	  ('Elixir_Of_Speed', 'StaminaPotion', 2, 'Belzebub', 7),
	  ('Elixir_Of_Strength', 'StrengthPotion', 2, 'AlexanderTheSlayer', 8),
	  ('Sword', 'MeleeWeapon', 1, 'PetroleumJelly', 8),
	  ('Great_Sword', 'TwoHandedMelee', 1, 'AlexanderTheSlayer', 8),
	  ('Helm', 'HeadPiece', 1, 'PetroleumJelly', 8),
	  ('PlateLeg', 'LegPiece', 1, 'PetroleumJelly', 8), 
	  ('Boots', 'FootGear', 1, 'Jason', 7),
	  ('Gauntlets', 'HandGear', 1, 'PetroleumJelly', 8),
	  ('Arrows', 'Ammo', 234, 'Belzebub', 7),
	  ('Bow', 'Range', 1, 'Belzebub', 7),
	  ('PlateBody', 'ChestPiece', 1, 'AlexanderTheSlayer', 8),
	  ('Shield', 'OffHandMelee', 1, 'AlexanderTheSlayer', 8),
	  ('Fish', 'FFood', 29, 'Tyrael', 6),
	  ('Bread', 'BFood', 23, 'Tyrael', 6),
	  ('Key', 'Key', 13, 'SirPantsalot', 7),
      ('Teleportation_Scroll', 'Scroll', 3, 'Tyrael', 6),
	  ('Ruby', 'RGem', 12, 'Tyrael', 6),
      ('Topaz', 'TGem', 13, 'Exxxxxxtra', 7),
	  ('Emerald', 'EGem', 11, 'Jason', 7),
      ('Amethyst', 'AGem', 8, 'SirPantsalot', 7),
	  ('Diamond', 'DGem', 9, 'AlexanderTheSlayer', 8),
	  ('Staff', 'MageWeapon', 1, 'Exxxxxxtra', 7),
	  ('Wand', 'MageWeapon', 1, 'SirPantsalot', 7),
	  ('Book_Of_Secrets', 'OffHandMage', 1, 'Exxxxxxtra', 7),
	  ('Willow_Log', 'WWoodLog', 14, 'AlexanderTheSlayer', 8),
	  ('Oak_Log', 'OWoodLog', 16, 'MikeTheKite', 8),
	  ('Elder_Log', 'EWoodLog', 15, 'MikeTheKite', 8),
	  ('Iron_Bar', 'IIgnot', 12, 'AlexanderTheSlayer', 8),
	  ('Steel', 'SIgnot', 21, 'Jason', 7),
	  ('Drakolith', 'DIgnot', 23, 'AlexanderTheSlayer', 8),
	  ('Leather_Strap', 'Leather', 17, 'Jason', 7),
	  ('Fine_Cloth', 'Cloth', 3, 'MikeTheKite', 8)

ALTER TABLE Inventory
ADD CONSTRAINT [CharacterName_FK]
FOREIGN KEY (characterName)REFERENCES PlayerCharacter (characterName)

GO