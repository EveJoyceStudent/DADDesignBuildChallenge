

-- Name: Eve Joyce
-- Student ID: 103681990

/*
Task 1 - Relational Schema

TOUR(TourName, Description)
PRIMARY KEY(TourName)

CLIENT(ClientID, Surname, GivenName, Gender)
PRIMARY KEY(ClientID)

EVENT(TourName, EventYear, EventMonth, EventDay, Fee)
PRIMARY KEY(TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(TourName) REFERENCES TOUR

BOOKING(ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(ClientID) REFERENCES CLIENT
FOREIGN Key(TourName, EventYear, EventMonth, EventDay) REFERENCES EVENT

*/

/*
Task 2 - DB creation
*/

-- CREATE DATABASE DesignBuildChallenge103681990

-- Use DesignBuildChallenge103681990

/*
TOUR(TourName, Description)
PRIMARY KEY(TourName)
*/

IF OBJECT_ID('TOUR') IS NOT NULL
	DROP TABLE TOUR;
GO

CREATE TABLE TOUR(
    TourName NVARCHAR(100),
    Description NVARCHAR(500),
    PRIMARY KEY (TourName)
);

/*
CLIENT(ClientID, Surname, GivenName, Gender)
PRIMARY KEY(ClientID)
*/

IF OBJECT_ID('CLIENT') IS NOT NULL
	DROP TABLE CLIENT;
GO

CREATE TABLE CLIENT(
    ClientID INT,
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1),
    CONSTRAINT CHK_Person CHECK (Gender IN ('M', 'F', 'I')),
    PRIMARY KEY(ClientID)
);

/*
EVENT(TourName, EventYear, EventMonth, EventDay, Fee)
PRIMARY KEY(TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(TourName) REFERENCES TOUR

BOOKING(ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(ClientID) REFERENCES CLIENT
FOREIGN Key(TourName, EventYear, EventMonth, EventDay) REFERENCES EVENT
*/

IF OBJECT_ID('EVENT') IS NOT NULL
	DROP TABLE EVENT;
GO

CREATE TABLE EVENT(
    TourName NVARCHAR(100), 
    EventYear INT CHECK (EventYear>999),
    EventMonth NVARCHAR(3) CHECK(EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    EventDay INT CHECK (EventDay>=1 AND EventDay<=31),
    Fee MONEY NOT NULL CHECK(Fee > 0),
    PRIMARY KEY(TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY(TourName) REFERENCES TOUR
);

/*
BOOKING(ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(ClientID) REFERENCES CLIENT
FOREIGN Key(TourName, EventYear, EventMonth, EventDay) REFERENCES EVENT
*/

IF OBJECT_ID('BOOKING') IS NOT NULL
	DROP TABLE BOOKING;
GO

CREATE TABLE BOOKING(
    ClientID INT,
    TourName NVARCHAR(100), 
    EventYear INT CHECK (EventYear>999),
    EventMonth NVARCHAR(3) CHECK(EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec')),
    EventDay INT CHECK (EventDay>=1 AND EventDay<=31),
    DateBooked DATE NOT NULL,
    Payment MONEY CHECK(Payment > 0),
    PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay),
    FOREIGN KEY(ClientID) REFERENCES CLIENT,
    FOREIGN Key(TourName, EventYear, EventMonth, EventDay) REFERENCES EVENT
);

select table_name from information_schema.tables;
exec sp_columns project;
