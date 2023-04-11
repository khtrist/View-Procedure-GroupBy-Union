CREATE DATABASE EDUHOME;
GO

USE EDUHOME;

GO

CREATE TABLE Event (
    eventid INT PRIMARY KEY,
    eventname NVARCHAR(50),
    startdatetime DATETIME,
    enddatetime DATETIME,
    cityid INT FOREIGN KEY REFERENCES City(cityid)
);

GO

INSERT INTO Event(eventid, eventname, startdatetime, enddatetime, cityid)
VALUES
(1, 'LEARNING CONS', '2008-11-10 00:00:00', '2023-11-11 00:00:00', 1),
(2, 'AZERBAIJAN HISTORY', '2023-05-10 00:00:00', '2023-05-11 00:00:00', 3),
(3, 'LEARNING French', '2023-05-10 00:00:00', '2023-05-11 00:00:00', 3),
(4, 'UK ECONOMY', '2021-03-10 00:00:00', '2021-05-11 00:00:00', 2),
(5, 'ENGLISH POLITIC', '2020-04-10 00:00:00', '2021-05-11 00:00:00', 1);

GO

CREATE TABLE Speaker (
    speakerid INT IDENTITY PRIMARY KEY,
    firstname NVARCHAR(50),
    lastname NVARCHAR(50)
);


GO

INSERT INTO Speaker(speakerid,firstname,lastname)
VALUES
(1,'Lucy ',' Rose'),
(2,'Taylor ',' Dikiy'),
(3,'Amanda ',' Fox'),
(4,'Deny ',' Wolf'),
(5,'Fox ',' Malder'),
(6,'Megan ',' Cherry')
GO

CREATE TABLE [Date] (
    dateid INT IDENTITY PRIMARY KEY,
    datevalue DATE
);

GO


INSERT INTO [Date] (dateid,datevalue) 
VALUES 
(1,'2022-01-01'),
(2,'2022-11-10' ),
(3,'2023-05-10'),
(4,'2023-05-10'),
(5,'2021-03-10'),
(6,'2020-04-10'),
(7,'2021-03-10'),
(8,'2020-12-10')

GO


CREATE TABLE City (
    cityid INT IDENTITY PRIMARY KEY,
    cityname NVARCHAR(50)
);
INSERT INTO City(cityid,cityname)
VALUES
(1,'New-York'),
(2,'CHELSI'),
(3,'BAKU'),
(4,'KURDAMIR'),
(5,'BANKOG')


GO


CREATE TABLE SpeakerEvent (
    eventid INT,
    speakerid INT,
    PRIMARY KEY (eventid, speakerid),
    FOREIGN KEY (eventid) REFERENCES Event(eventid),
    FOREIGN KEY (speakerid) REFERENCES Speaker(speakerid)
);




CREATE PROCEDURE AddCity
    @cityname NVARCHAR(50)
AS
BEGIN
    INSERT INTO Cities (CityName)
    VALUES (@cityname)
END

SELECT cityid, COUNT(*) AS EventCount
FROM Event
GROUP BY cityid
HAVING COUNT(*) > 2;

CREATE VIEW EventsLastYear AS
SELECT e.eventid, e.eventname, c.cityname, COUNT(DISTINCT es.speakerid) AS SpeakerCount, DATEDIFF(MINUTE, e.startdatetime, e.enddatetime) AS DurationInMinutes
FROM Event e
JOIN City c ON e.CityId = c.CityId
JOIN SpeakerEvent es ON e.eventid = es.eventid
WHERE e.startdatetime >= DATEADD(YEAR, -1, GETDATE())
GROUP BY e.eventid, e.eventname, c.cityname, DATEDIFF(MINUTE, e.startdatetime, e.enddatetime);
