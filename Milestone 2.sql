CREATE DATABASE Milestone2

--Begin Milestone 2 Tables

-- SystemUser Table 
CREATE TABLE SystemUser(
Username VARCHAR(20) PRIMARY KEY,
Password1 VARCHAR(20)
);
--DROP TABLE SystemUser;
--SystemAdmin Table
CREATE TABLE SystemAdmin(
SystemAdmin_ID INT PRIMARY KEY IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE
);
--DROP TABLE SystemAdmin;
--SportsAssociationManager Table
CREATE TABLE SportsAssociationManager(
SportsAssociationManager_ID INT PRIMARY KEY IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE
);
--DROP TABLE SportsAssociationManager;
--Fan Table
CREATE TABLE Fan(
National_ID VARCHAR(20) PRIMARY KEY,
Phone_Number INT,
Name1 VARCHAR(20),
Address1 VARCHAR(20),
Status1 BIT, -- if 0 then banned if 1 then not banned
Birth_date DATETIME NOT NULL,
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE
);
--DROP TABLE Fan;
--Club Table
CREATE TABLE Club(
Club_ID INT PRIMARY KEY IDENTITY,
Club_Name VARCHAR(20),
Location1 VARCHAR(20)
);
--DROP TABLE Club;
--ClubRepresentative Table
CREATE TABLE ClubRepresentative(
ClubRepresentative_ID INT PRIMARY KEY IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
Club_ID int foreign key references Club(Club_ID) on delete cascade on update cascade
);
--DROP TABLE ClubRepresentative;
--Stadium Table
CREATE TABLE Stadium(
Stadium_ID INT PRIMARY KEY IDENTITY,
Stadium_Name VARCHAR(20),
Status1 BIT, -- if 0 then not filled if 1 then filled
Location1 VARCHAR(20),
Capacity INT
);
--DROP TABLE Stadium;
--StadiumManager Table
CREATE TABLE StadiumManager(
StadiumManager_ID INT PRIMARY KEY IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
Stadium_ID INT FOREIGN KEY REFERENCES Stadium(Stadium_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
--DROP TABLE StadiumManager;
--Matches Table
CREATE TABLE Matches(
Matches_ID INT PRIMARY KEY IDENTITY,
Stadium_ID INT FOREIGN KEY REFERENCES Stadium(Stadium_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Host_Club_ID INT FOREIGN KEY REFERENCES Club(Club_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Guest_Club_ID INT FOREIGN KEY REFERENCES Club(Club_ID), -- lazm hna ON DELETE CASCADE ON UPDATE CASCADE
StartTime DATETIME NOT NULL,
EndTime DATETIME NOT NULL
); -- lazm hna DROP TABLE Matches 3shan nzwd ON DELETE CASCADE ON UPDATE CASCADE
--DROP TABLE Matches;
--Ticket Table
CREATE TABLE Ticket(
Ticket_ID INT PRIMARY KEY IDENTITY,
Status1 BIT, --if 0 then not sold if 1 then sold
Matches_ID INT FOREIGN KEY REFERENCES Matches(Matches_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
--DROP TABLE  Ticket;
--Buys Table (Relation Between Fans & Tickets)
CREATE TABLE Ticket_Buying_Transactions(
Fan_National_ID VARCHAR(20) FOREIGN KEY REFERENCES Fan(National_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Ticket_ID INT FOREIGN KEY REFERENCES Ticket(Ticket_ID) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Ticket_Buying_Transactions_PK PRIMARY KEY(Fan_National_ID,Ticket_ID)
); --m3mltsh hna IDENTITY 3shan azon enha msh m7taga!
--DROP TABLE Ticket_Buying_Transactions;
--HostRequest Table
CREATE TABLE HostRequest(
HostRequest_ID INT PRIMARY KEY IDENTITY,
Status1 VARCHAR(20), -- Either 'Accepted' or 'Rejected' or 'Unhandled'
Match_ID INT FOREIGN KEY REFERENCES Matches(Matches_ID)on delete cascade on update cascade,
StadiumManager_ID INT FOREIGN KEY REFERENCES StadiumManager(StadiumManager_ID), --Lazm hna ON DELETE CASCADE ON UPDATE CASCADE,
ClubRepresentative_ID INT FOREIGN KEY REFERENCES ClubRepresentative(ClubRepresentative_ID) --Lazm hna ON DELETE CASCADE ON UPDATE CASCADE
);
--DROP TABLE HostRequest;
--End Milestone 2 Tables
--yousif part
--2.1 a
go
create procedure createAllTables
as
begin
CREATE TABLE SystemUser(
Username VARCHAR(20) PRIMARY KEY,
Password1 VARCHAR(20)
);
--SystemAdmin Table
CREATE TABLE SystemAdmin(
SystemAdmin_ID INT IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(SystemAdmin_ID, Username) --check if pass is prim or not
);
--SportsAssociationManager Table
CREATE TABLE SportsAssociationManager(
SportsAssociationManager_ID INT IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(SportsAssociationManager_ID, Username) --check if pass is prim or not
);
--Fan Table
CREATE TABLE Fan(
National_ID INT,
Phone_Number INT,
Name1 VARCHAR(20),
Address1 VARCHAR(20),
Status1 BIT, -- if 0 then banned if 1 then not banned
Birth_date DATE NOT NULL,
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(National_ID, Username) --check if pass is prim or not
);
--ClubRepresentative Table
CREATE TABLE ClubRepresentative(
ClubRepresentative_ID INT IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(ClubRepresentative_ID, Username), --check if pass is prim or not
Club_ID int foreign key references Club(Club_ID) on delete cascade on update cascade
);
--StadiumManager Table
CREATE TABLE StadiumManager(
StadiumManager_ID INT IDENTITY,
Name1 VARCHAR(20),
Username VARCHAR(20) FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE CASCADE ON UPDATE CASCADE,
Stadium_ID INT FOREIGN KEY REFERENCES Stadium(Stadium_ID) ON DELETE no action ON UPDATE no action,
PRIMARY KEY(StadiumManager_ID, Username) --check if pass is prim or not
);
--Stadium Table
CREATE TABLE Stadium(
Stadium_ID INT PRIMARY KEY IDENTITY,
Stadium_Name VARCHAR(20),
Status1 BIT, -- if 0 then not filled if 1 then filled
Location1 VARCHAR(20),
Capacity INT
);
--Club Table
CREATE TABLE Club(
Club_ID INT PRIMARY KEY IDENTITY,
Club_Name VARCHAR(20),
Location1 VARCHAR(20)
);
--Matches Table
CREATE TABLE Matches(
Matches_ID INT PRIMARY KEY IDENTITY,
Stadium_ID INT FOREIGN KEY REFERENCES Stadium(Stadium_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Host_Club_ID INT FOREIGN KEY REFERENCES Club(Club_ID) ON DELETE no action ON UPDATE no action,
Guest_Club_ID INT FOREIGN KEY REFERENCES Club(Club_ID) ON DELETE no action ON UPDATE no action,
StartTime TIME NOT NULL,
EndTime TIME NOT NULL
);
--Ticket Table
CREATE TABLE Ticket(
Ticket_ID INT PRIMARY KEY IDENTITY,
Status1 BIT, --if 0 then not sold if 1 then sold
Matches_ID INT FOREIGN KEY REFERENCES Matches(Matches_ID) ON DELETE CASCADE ON UPDATE CASCADE
);
--Buys Table (Relation Between Fans & Tickets)
CREATE TABLE Ticket_Buying_Transactions(
National_ID INT FOREIGN KEY REFERENCES Fan(National_ID) ON DELETE CASCADE ON UPDATE CASCADE,
Ticket_ID INT FOREIGN KEY REFERENCES Ticket(Ticket_ID) ON DELETE no action ON UPDATE no action,
PRIMARY KEY(National_ID,Ticket_ID)
); --m3mltsh hna IDENTITY 3shan azon enha msh m7taga!
--HostRequest Table
CREATE TABLE HostRequest(
HostRequest_ID INT PRIMARY KEY IDENTITY,
ClubRepresentative_ID INT FOREIGN KEY REFERENCES ClubRepresentative(ClubRepresentative_ID) ON DELETE CASCADE ON UPDATE CASCADE,
StadiumManager_ID INT FOREIGN KEY REFERENCES StadiumManager(StadiumManager_ID) ON DELETE no action ON UPDATE no action,
Match_ID INT FOREIGN KEY REFERENCES Matches(Matches_ID)on delete no action on update no action,
Status1 BIT -- if 0 then declined if 1 then accepted
);
end 
go;
--2.1 b

create procedure dropAllTables
as begin
Drop Table Ticket_Buying_Transactions
Drop Table Ticket
Drop Table HostRequest
Drop Table Matches
Drop table ClubRepresentative
Drop table SportsAssociationManager
Drop table SystemAdmin
Drop table Fan
Drop table StadiumManager
Drop table Club
Drop table Stadium
Drop table SystemUser
end
go;

--2.1 C

create procedure dropAllProceduresFunctionsViews
as begin 
drop procedure createAllTables, dropAllTables,clearAllTables,addAssociationManager,addNewMatch,deleteMatch,deleteMatchesOnStadium,addClub,addTicket,deleteClub,addStadium,deleteStadium,
blockFann,unblockFan,addRepresentative,addHostRequest,addStadiumManager,acceptRequest,rejectRequest,addFan,purchaseTicket,updateMatchHost,deleteMatchesOnStadium 
drop view allAssocManagers,allClubRepresentatives,allStadiumManagers,allFans,allMatches,allTickets,allCLubs,allStadiums,allRequests,clubsWithNoMatches,matchesPerTeam,clubsNeverMatched
drop function viewAvailableStadiumsOn,allUnassignedMatches,allPendingRequests,upcomingMatchesOfClub,availableMatchesToAttend,clubsNeverPlayed,matchWithHighestAttendance,matchesRankedByAttendance,
requestsFromClub end 
go;

--2.1 d

create procedure clearAllTables
as begin
Truncate Table Ticket_Buying_Transactions
Truncate Table Ticket
Truncate Table HostRequest
Truncate Table Matches
truncate table ClubRepresentative
truncate table SportsAssociationManager
truncate table SystemAdmin
truncate table Fan
truncate table StadiumManager
truncate table Club
truncate table Stadium
truncate table SystemUser
end
go;

--2.2 a
create view allAssocManagers as 
select sa.Username , su.Password1,sa.Name1
from SportsAssociationManager sa
inner join SystemUser su on su.Username = sa.Username 
go;

--2.2 b  
create view allClubRepresentatives as
select cl.Name1 ,su.Password1 ,c1.Username ,c.Club_Name
from ClubRepresentative cl
inner join Club c on c.Club_ID = cl.Club_ID
inner join SystemUser su on su.Username =cl.Username
go;

--2.2 c
create view allStadiumManagers as
select sm.Name1 , su.Password1 ,sm.Username , s.Stadium_Name
from StadiumManager sm
inner join Stadium s on s.Stadium_ID  = sm.Stadium_ID
inner join SystemUser su on su.Username =sm.Username
go;

--2.2 d 
create view allFans as 
select f.Username,su.Password1,f.Name1,f.National_ID,f.Birth_date,f.Status1
from Fan f
inner join SystemUser su on su.Username =f.Username
go;

--2.2 e
create view allMatches as 
select c1.Club_Name , c2.Club_Name ,c1.Club_Name AS HostClub ,c2.Club_Name AS GuestClub, m.StartTime AS Starttime , m.EndTime AS Endtime
from Matches m 
inner join Club c1 on m.Host_Club_ID = c1.Club_ID
inner join Club c2 on c2.Club_ID = m.Guest_Club_ID
where c1.Club_Name <>c2.Club_Name
go;

--2.2 f
create view allTickets as
select c1.Club_Name , c2.Club_Name,s.Stadium_Name,m.StartTime	
from Matches m
inner join Club c1 on c1.Club_ID = m.Host_Club_ID
inner join Club c2 on c2.Club_ID = m.Guest_Club_ID
inner join Stadium s on s.Stadium_ID = m.Stadium_ID
go;
--2.2 g
create view allCLubs as 
select Club_Name Location1
from Club;
go;
--2.2 h
create view allStadiums as 
select Stadium_Name,Status1 ,Location1,Capacity
from Stadium;
go;
--2.2 i
create view allRequests as 
select cl.Username , sm.Username ,h.Status1
from ClubRepresentitive cl
inner join HostRequest h on h.ClubRepresentative_ID = cl.ClubRepresentative_ID
inner join StadiumManager sm on sm.StadiumManager_ID = h.StadiumManager_ID
go;
--end of yousif part

--2.3
--Mazen's Part Start
--i)
GO;
CREATE PROCEDURE addAssociationManager --done
@Name VARCHAR(20), @UserName VARCHAR(20), @Password VARCHAR(20)
 AS
DECLARE @SAM_ID INT;
SELECT @SAM_ID = sam.SportsAssociationManager_ID FROM SportsAssociationManager sam INNER JOIN SystemUser su ON sam.Username = su.Username WHERE @Name = sam.Name1 AND @UserName = su.Username AND @Password = su.Password1
INSERT INTO SportsAssociationManager (SportsAssociationManager_ID, Name1, Username) VALUES (@SAM_ID, @Name, @UserName);
INSERT INTO SystemUser (Username, Password1) VALUES (@UserName, @Password);
GO;
--ii)
CREATE PROCEDURE addNewMatch --done
@HostName VARCHAR(20),@GuestName VARCHAR(20) , @StartTime DATETIME , @EndTime DATETIME
AS
DECLARE @MatchID INT , @StadiumID INT , @HostID INT , @GuestID INT;
SELECT @MatchID = m.Matches_ID , @StadiumID = s.Stadium_ID , @HostID = c.Club_ID , @GuestID = c1.Club_ID FROM Matches m INNER JOIN Club c ON m.Host_Club_ID = c.Club_ID INNER JOIN Club c1 ON m.Guest_Club_ID = c1.Club_ID INNER JOIN Stadium s ON m.Stadium_ID = s.Stadium_ID WHERE @HostName = c.Club_Name AND @GuestName = c1.Club_Name AND c.Club_ID <> c1.Club_ID AND @StartTime = m.StartTime AND @EndTime = m.EndTime
INSERT INTO Matches VALUES (@MatchID, @StadiumID, @HostID, @GuestID, @StartTime, @EndTime);
GO;
--iii)
CREATE VIEW clubWithNoMatches --done bs recheck
AS
SELECT c.Club_Name FROM Club c INNER JOIN Matches m ON c.Club_ID = m.Host_Club_ID WHERE m.Matches_ID IS NULL;
GO;
--iv)
CREATE PROCEDURE deleteMatch --lazm recheck
@HostName VARCHAR(20), @GuestName VARCHAR(20)
AS
DECLARE @MatchID INT , @StadiumID INT , @HostID INT , @GuestID INT, @StartTime DATETIME, @EndTime DATETIME;
DELETE FROM Matches WHERE @MatchID = Matches_ID AND @StadiumID = Stadium_ID AND @HostID = Host_Club_ID AND @GuestID = Guest_Club_ID AND @StartTime = StartTime AND @EndTime = EndTime
GO;
--v)
CREATE OR ALTER PROCEDURE deleteMatchesOnStadium 
@StadiumName VARCHAR(20) 
AS
DECLARE @StadiumID INT = (SELECT Stadium_ID FROM Stadium WHERE Stadium_Name = @StadiumName);
DECLARE @MatchID int = (SELECT Matches_ID FROM Matches WHERE Stadium_ID = @StadiumID)
DELETE FROM HostRequest WHERE Match_ID = @MatchID;
DELETE FROM Ticket WHERE Matches_ID = @MatchID;
DELETE FROM Matches WHERE Stadium_ID = @StadiumID;
GO;
--vi)
CREATE PROCEDURE addClub --done
@ClubName VARCHAR(20), @Location VARCHAR(20)
AS
DECLARE @ClubID INT;
SELECT @ClubID = Club_ID FROM Club WHERE Club_Name = @ClubName AND Location1 = @Location
INSERT INTO Club VALUES (@ClubID, @ClubName, @Location);
GO;
--vii)
CREATE PROCEDURE addTicket --done
@hostName VARCHAR(20), @GuestName VARCHAR(20), @StartTime DATETIME
AS
DECLARE @TicketID INT, @status BIT, @MatchID INT;
SELECT @TicketID = t.Ticket_ID , @status =t.Status1 , @MatchID = m.Matches_ID FROM Ticket t INNER JOIN Matches m ON t.Matches_ID = m.Matches_ID INNER JOIN Club c ON m.Host_Club_ID = c.Club_ID INNER JOIN Club c1 ON m.Guest_Club_ID = c1.Club_ID WHERE @hostName = c.Club_Name AND @GuestName = c1.Club_Name AND c.Club_ID <> c1.Club_ID AND @StartTime = m.StartTime
INSERT INTO Ticket VALUES (@TicketID, @status, @MatchID);
GO;
--viii)
CREATE PROCEDURE deleteClub --done bas recheck
@clubName VARCHAR(20)
AS
DECLARE @ClubID INT , @Location VARCHAR(20);
DELETE FROM Club WHERE @clubName = Club_Name AND @Location = Location1 AND @ClubID = Club_ID
GO;
--ix)
CREATE PROCEDURE addStadium --done
@StadiumName VARCHAR(20), @Location VARCHAR(20), @Capacity INT
AS
DECLARE @StadiumID INT , @status BIT;
SELECT @StadiumID = Stadium_ID, @status = Status1 FROM Stadium WHERE @StadiumName = Stadium_Name AND @Location = Location1 AND @Capacity = Capacity
INSERT INTO Stadium VALUES (@StadiumID, @StadiumName, @status, @Location, @Capacity);
GO;
--x)
CREATE PROCEDURE deleteStadium --done bs recheck
@Stadium_Name VARCHAR(20)
AS
DECLARE @StadiumID INT , @status BIT , @Location VARCHAR(20), @Capacity INT;
DELETE FROM Stadium WHERE @Stadium_Name = Stadium_Name AND @StadiumID = Stadium_ID AND @status = Status1 AND @Location = Location1 AND @Capacity = Capacity
GO;
--xi)
CREATE PROCEDURE blockFan ---- done
@NationalID VARCHAR(20)
AS
UPDATE Fan
SET Status1 = 0
WHERE @NationalID = National_ID
GO;
--xii)
CREATE PROCEDURE unblockFan -- done
@NationalID VARCHAR(20)
AS
UPDATE Fan
SET Status1 = 1
WHERE @NationalID = National_ID
GO;
--Mazen's Part End

--Omar's Part Start
--xiii)
GO;
CREATE PROCEDURE addRepresentative
@name VARCHAR(20) , @Club_Name VARCHAR(20) , @Username VARCHAR(20) , @Password VARCHAR(20)
AS
DECLARE @ClubRep_ID INT , @Club_ID INT;
SELECT @ClubRep_ID = crep.ClubRepresentative_ID , @Club_ID = c.Club_ID  FROM ClubRepresentative  crep INNER JOIN Club c ON crep.Club_ID = c.Club_ID INNER JOIN SystemUser s ON crep.Username = s.Username WHERE @name = crep.Name1 AND @Username = crep.Username AND @Club_Name = c.Club_Name AND @Password = s.Password1;
INSERT INTO SystemUser (Username, Password1) VALUES (@Username, @Password);
INSERT INTO ClubRepresentative ( ClubRepresentative_ID, Name1, Username, Club_ID) VALUES (@ClubRep_ID, @name, @Username, @Club_ID);
INSERT INTO Club(Club_Name) VALUES (@Club_Name);
GO;
--xiv)
CREATE FUNCTION viewAvailableStadiumsOn
(@date DATETIME)
RETURNS TABLE RETURN
SELECT s.Stadium_Name ,s.Location1,s.Capacity FROM Stadium s INNER JOIN Matches m ON m.Stadium_ID = s.Stadium_ID WHERE (m.StartTime > @date OR @date>m.EndTime) AND s.Status1 =1
GO;
--xv)
CREATE PROCEDURE addHostRequest  --done
@Club_Name  VARCHAR(20) , @Stadium_Name VARCHAR(20) , @StartTime DATETIME
AS
DECLARE @RequestID INT , @status VARCHAR(20) , @MatchID INT , @StadiumManagerID INT , @ClubRepID INT;
SELECT @RequestID = hr.HostRequest_ID , @status = hr.Status1 , @MatchID = m.Matches_ID , @StadiumManagerID = sm.StadiumManager_ID , @ClubRepID = crep.ClubRepresentative_ID  FROM HostRequest hr INNER JOIN ClubRepresentative crep ON hr.ClubRepresentative_ID = crep.ClubRepresentative_ID INNER JOIN Club c ON crep.Club_ID = c.Club_ID INNER JOIN Matches m ON crep.Club_ID = m.Host_Club_ID INNER JOIN Stadium s ON m.Stadium_ID = s.Stadium_ID INNER JOIN StadiumManager sm ON hr.StadiumManager_ID = sm.StadiumManager_ID WHERE @Club_Name  = c.Club_Name AND @StartTime = m.StartTime AND @Stadium_Name = s.Stadium_Name ;
INSERT INTO HostRequest (HostRequest_ID, Status1, Match_ID, StadiumManager_ID, ClubRepresentative_ID) VALUES (@RequestID, @status, @MatchID, @StadiumManagerID, @ClubRepID);
INSERT INTO Matches(StartTime) VALUES (@StartTime);
GO;
--xvi)
 CREATE FUNCTION allUnassignedMatches --not sure mnha --5lstha elmfrood
(@GuestName VARCHAR(20))
 RETURNS TABLE AS RETURN (SELECT c.Club_ID , m.StartTime FROM Matches m INNER JOIN Club c ON m.Guest_Club_ID = c.Club_ID INNER JOIN Club c1 ON m.Host_Club_ID = c1.Club_ID INNER JOIN HostRequest hr ON m.Matches_ID = hr.Match_ID WHERE c.Club_ID <> c1.Club_ID AND hr.Status1 ='Unhandled' AND @GuestName = c.Club_Name)  
GO;
--xvii)
CREATE PROCEDURE addStadiumManager --done
@name VARCHAR(20) , @Stadium_Name VARCHAR(20) , @Username VARCHAR(20) , @Password VARCHAR(20)
AS
DECLARE @StadiumManagerID INT , @StadiumID INT;
SELECT @StadiumManagerID = sm.StadiumManager_ID, @StadiumID = s.Stadium_ID FROM StadiumManager sm INNER JOIN Stadium s ON sm.Stadium_ID = s.Stadium_ID INNER JOIN SystemUser su ON sm.Username = su.Username WHERE @name = sm.Name1 AND @Username = sm.Username AND @Password = su.Password1 AND @Stadium_Name = s.Stadium_Name;

INSERT INTO StadiumManager (StadiumManager_ID, Name1, Username, Stadium_ID) VALUES (@StadiumManagerID, @name, @Username, @StadiumID);
INSERT INTO SystemUser VALUES (@Username, @Password);
GO;
--xviii) 
CREATE FUNCTION allPendingRequests --5lstha
(@StadiumManagerUsername VARCHAR(20))
RETURNS TABLE AS RETURN (SELECT c1.Club_Name , m.StartTime FROM HostRequest hr INNER JOIN Matches m ON hr.Match_ID = m.Matches_ID INNER JOIN ClubRepresentative cr ON hr.ClubRepresentative_ID = cr.ClubRepresentative_ID INNER JOIN Club c ON m.Host_Club_ID = c.Club_ID INNER JOIN Club c1 ON m.Guest_Club_ID = c1.Club_ID INNER JOIN StadiumManager sm ON hr.StadiumManager_ID = sm.StadiumManager_ID WHERE cr.Club_ID = c.Club_ID AND c.Club_ID <> c1.Club_ID AND @StadiumManagerUsername = sm.Username AND hr.Status1 = 'Unhandled')
GO;
--xix) lesa
CREATE PROCEDURE acceptRequest -- elmfrood 5lstha
@StadiumManagerUsername VARCHAR(20) , @HostClub_Name VARCHAR(20) , @GuestClub_Name VARCHAR(20) , @StartTime DATETIME
AS
SELECT hr.Match_ID FROM HostRequest hr INNER JOIN Matches m ON hr.Match_ID = m.Matches_ID INNER JOIN ClubRepresentative cr ON hr.ClubRepresentative_ID = cr.ClubRepresentative_ID INNER JOIN Club c ON m.Host_Club_ID = c.Club_ID INNER JOIN Club c1 ON m.Guest_Club_ID = c1.Club_ID INNER JOIN StadiumManager sm ON hr.StadiumManager_ID = sm.StadiumManager_ID  WHERE @StadiumManagerUsername = sm.Username  AND @HostClub_Name = c.Club_Name AND @GuestClub_Name = c1.Club_Name AND c.Club_ID <> c1.Club_ID AND @StartTime = m.StartTime;
DECLARE @MatchID INT;
UPDATE HostRequest
SET Status1 = 'Accepted'
WHERE Match_ID = @MatchID
GO;
--xx) lesa
CREATE PROCEDURE rejectRequest -- elmfrood 5lstha
@StadiumManagerUsername VARCHAR(20) , @HostClub_Name VARCHAR(20) , @GuestClub_Name VARCHAR(20) , @StartTime DATETIME
AS
SELECT hr.Match_ID FROM HostRequest hr INNER JOIN Matches m ON hr.Match_ID = m.Matches_ID INNER JOIN ClubRepresentative cr ON hr.ClubRepresentative_ID = cr.ClubRepresentative_ID INNER JOIN Club c ON m.Host_Club_ID = c.Club_ID INNER JOIN Club c1 ON m.Guest_Club_ID = c1.Club_ID INNER JOIN StadiumManager sm ON hr.StadiumManager_ID = sm.StadiumManager_ID  WHERE @StadiumManagerUsername = sm.Username  AND @HostClub_Name = c.Club_Name AND @GuestClub_Name = c1.Club_Name AND c.Club_ID <> c1.Club_ID AND @StartTime = m.StartTime;
DECLARE @MatchID INT;
UPDATE HostRequest
SET Status1 = 'Accepted'
WHERE Match_ID = @MatchID
GO;
--xxi)
CREATE PROCEDURE addFan --done
@name VARCHAR(20) , @Username VARCHAR(20) , @Password VARCHAR(20) , @NationalID_Number VARCHAR(20) , @BirthDate DATETIME , @address VARCHAR(20) , @PhoneNumber INT
AS
INSERT INTO Fan VALUES (@NationalID_Number, @PhoneNumber, @name, @address, @BirthDate, @Username);
INSERT INTO SystemUser VALUES (@Username, @Password);
GO;
--xxii)
CREATE FUNCTION upcomingMatchesOfClub --not sure mnha
(@Club_Name VARCHAR(20))
RETURNS TABLE AS RETURN (SELECT c.Club_Name , c1.Club_Name , m.StartTime , s.Stadium_Name FROM Matches m INNER JOIN Club c ON m.Host_Club_ID = c.Club_ID INNER JOIN Club c1 ON m.Guest_Club_ID = c1.Club_ID INNER JOIN Stadium s ON m.Stadium_ID = s.Stadium_ID WHERE (@Club_Name = c.Club_Name OR @Club_Name = c1.Club_Name) AND m.StartTime >= CURRENT_TIMESTAMP)
GO;
--xxiii)
CREATE FUNCTION availableMatchesToAttend --done
(@date DATETIME)
RETURNS TABLE AS RETURN (SELECT c1.Club_Name AS Host, c2.Club_Name AS Guest, m.StartTime, s.Stadium_Name FROM Matches m INNER JOIN Club c1 ON m.Host_Club_ID = c1.Club_ID INNER JOIN Club c2 ON m.Guest_Club_ID = c2.Club_ID INNER JOIN Stadium s ON m.Stadium_ID = s.Stadium_ID INNER JOIN Ticket t ON m.Matches_ID = t.Matches_ID WHERE c1.Club_ID <> c2.Club_ID AND @date = m.StartTime AND t.Status1 = 0)
GO;
--Omar's Part End

--badawi part
--xxiv)
create procedure purchaseTicket
@nationalid varchar(20),
@hostclub varchar(20),
@guestclub varchar(20),
@starttime datetime
as
select f.National_ID,c1.Club_Name,c2.Club_Name,m.StartTime
from Ticket_Buying_Transactions tb
inner join Fan f on f.National_ID = tb.National_ID
inner join Ticket t on t.Ticket_ID = tb.Ticket_ID
inner join Matches m on m.Matches_ID = t.Matches_ID
inner join Club c1 on c1.Club_ID  = m.Host_Club_ID
inner join Club c2 on c2.Club_ID  = m.Guest_Club_ID
where f.National_ID = @nationalid and  c1.Club_Name = @hostclub and c2.Club_Name = @guestclub and m.StartTime = @starttime
go;

--xxv)
CREATE PROCEDURE updateMatchHost
@hostname varchar(20),
@guestname varchar(20),
@starttime datetime
as
declare @matchid int
declare @guestid int
declare @hostid int
select @matchid=m.Matches_ID ,@guestid = cg.Club_ID , @hostid = ch.Club_ID 
from Matches m,Club ch,Club cg
where m.Host_Club_ID = cg.Club_ID and m.Guest_Club_ID = ch.Club_ID and m.StartTime = @starttime and ch.Club_Name = @guestname and cg.Club_Name = @hostname  
update Matches set Host_Club_ID = @guestid where ID = @MatchID; 
go;


--xxvi)
create view matchesPerTeam
as 
select c.Club_Name , count(m.Matches_ID) as Matchesplayed
from Matches m 
inner join Club c1 on c1.Club_ID = m.Host_Club_ID
inner join Club c2 on c2.Club_ID = m.Guest_Club_ID
where m.EndTime < CURRENT_TIMESTAMP
go;

--xxvii)
Create view clubsNeverMatched 
AS
Select c1.Club_Name, c2.Club_Name
From Club c1, Club c2
Inner join Matches m1 on c1.Club_ID = m1.Host_Club_ID 
Inner join Matches m2 on c2.Club_ID = m2.Guest_Club_ID where m1.Matches_ID ! = m2.Matches_ID
go;

--xxviii)
Create function clubsNeverPlayed
(@Club_Name VARCHAR(20))
RETURNS TABLE 
AS 
return select Club_Name 
from Club 
where not exists (select c.Club_Name from Club c 
inner join Matches m on c.Club_ID  = m.Host_Club_ID)
go;


--xxix)
Create function MatchWithHighestAttendance
()
Returns Table 
AS
Return  Select ch.Club_Name AS Host, cg.Club_Name AS Guest, count(T.status1) AS TCount
From Matches m 
INNER JOIN Club ch ON m.Host_Club_ID = ch.Club_ID 
INNER JOIN Club cg ON m.Guest_Club_ID = cg.Club_ID 
INNER JOIN Ticket T ON T.Matches_ID = m.Matches_ID 
having T.status1 = '1' and TCount = Max(TCount)
go;

--xxx)
Create function MatchesRankedByAttendance 
()
Returns Table 
AS
Return ( Select c1.Club_Name AS Host, c2.Club_Name AS Guest, count(T.status1) AS TCount
From Matches m INNER JOIN Club c1 ON m.Host_Club_ID = c1.Club_ID INNER JOIN Club c2 ON m.Guest_Club_ID = c2.Club_ID INNER JOIN Ticket T ON T.Matches_ID = m.Matches_ID 
Where T.status1 = '1'
Order By TCount Desc)
go;

--xxxi)

Create function requestFromClub
(@Stadium_Name VARCHAR(20),	@Club_Name VARCHAR(20))
RETURNS TABLE 
AS 
Return (Select c1.Club_Name AS Host, c2.Club_Name AS Guest
From Club c1, Club c2
Inner join Matches m ON m.Guest_Club_ID = c2.Club_ID And m.Host_Club_ID =c1.Club_ID
Inner join HostRequest HR ON HR.Match_ID =m.Matches_ID 
Inner join StadiumManager SM ON SM. StadiumManager_ID = HR.StadiumManager_ID
Inner join Stadium S ON S.Stadium_ID = SM.Stadium_ID 
where S.Stadium_Name = @Stadium_Name and HR.Status1 ='Pending')
go;
