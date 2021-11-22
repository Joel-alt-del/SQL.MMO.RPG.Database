/*=====================================================
FileName: Send_Letter_To_User.sql
Programmer: Joel Paul Merrington
Description: This query will send a letter to the user.
=====================================================*/
USE AshesByDawn
GO

IF EXISTS
(
      SELECT type_desc, type
	  FROM sys.procedures WITH(NOLOCK)
	  WHERE NAME = 'spSendLetter'
)
      DROP PROCEDURE spSendLetter
GO

CREATE PROCEDURE spSendLetter
      @accountName VARCHAR (40)
AS
BEGIN
IF EXISTS
(
SELECT * 
FROM Account
WHERE extraNews = 'yes'
AND accountName = @accountName
)
BEGIN
DECLARE
      @timeSpentDays INT,
	  @timeLeftDays INT
SELECT
	  @accountName = accountName,
	  @timeSpentDays = timeSpentDays,
	  @timeLeftDays = timeLeftDays
FROM Membership
WHERE @accountName = accountName

PRINT 'yes'     ---------------- 
PRINT'======================================================================================='
PRINT'                       Greeting from the Ashes By Dawn team.'
PRINT'              Your weekly carrier pigeon is here with news to share.'
PRINT'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
PRINT'   Hello '+@accountName
PRINT'  Your account has been active for '+CAST(@timeSpentDays AS VARCHAR)+' days.'
PRINT'  You have exactly '+CAST(@timeLeftDays AS VARCHAR) +' days left on your account.'
PRINT'  To celebrate the founding of AshesByDawn, we would like you to enjoy the following '
PRINT'  this weekend from Friday 12AM to Monday 12AM. Thats 72hours of:'
PRINT''
PRINT'  - Double XP earned from all quests and activities.'
PRINT'  - Double gold from monster drops.'
PRINT'  - A special quest avaibale for a limited time with special unique rewards.'
PRINT''
PRINT'  Notice for players.'
PRINT'  Be careful of scammers, no one from Ashes By Dawn will ever ask you for your'
PRINT'  login details. If someone asks you for any of your account details, please'
PRINT'  contact us right away and provide us with their character name.'
PRINT'  Thank you for supporting us'
PRINT''
PRINT'  '
PRINT'                               Happy questing adventurer!'
PRINT''
PRINT'========================================================================================'

PRINT 'letter section printed'
END
ELSE
BEGIN
print 'no'    -----------------------------




print 'no'    -----------------------------
PRINT'' 
PRINT''
PRINT'======================================================================================='
PRINT'                       Greeting from the Ashes By Dawn team.'
PRINT'              Your weekly carrier pigeon is here with news to share.'
PRINT'= = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = ='
PRINT'   Hello '+@accountName+' '
PRINT'  Your account has been active for '+CAST(@timeSpentDays AS VARCHAR)+' days.'
PRINT'  You have exactly '+CAST(@timeLeftDays AS VARCHAR) +' left on your account.'
PRINT' '
PRINT'  '
PRINT'                               Happy questing adventurer!'
PRINT''
PRINT'========================================================================================'
PRINT''
END
END
GO

EXEC spSendLetter 'MountainMoose'
GO