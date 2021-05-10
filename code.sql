

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

/* 
Task 3 - add data

/* 
TOUR(TourName, Description)
PRIMARY KEY(TourName)
*/

INSERT INTO TOUR(TourName, Description) VALUES
('North', 'Tour of wineries and outlets of the Bedigo and Castlemaine region'),
('South', 'Tour of wineries and outlets of Mornington Penisula'),
('West', 'Tour of wineries and outlets of the Geelong and Otways region');

/* 
CLIENT(ClientID, Surname, GivenName, Gender)
PRIMARY KEY(ClientID)
*/

INSERT INTO CLIENT(ClientID, Surname, GivenName, Gender) VALUES
('1', 'Price', 'Taylor', 'M'),
('2', 'Gamble', 'Ellyse', 'F'),
('3', 'Tan', 'Tilly', 'F');

/* 
EVENT(TourName, EventYear, EventMonth, EventDay, Fee)
PRIMARY KEY(TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(TourName) REFERENCES TOUR
*/

INSERT INTO EVENT(TourName, EventYear, EventMonth, EventDay, Fee) VALUES
('North', 2016, 'Jan', 9,  200),
('North', 2016, 'Feb', 13, 225),
('South', 2016, 'Jan', 9, 200),
('South', 2016, 'Jan', 16, 200),
('West', 2016, 'Jan', 29, 225);

/* 
BOOKING(ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(ClientID) REFERENCES CLIENT
FOREIGN Key(TourName, EventYear, EventMonth, EventDay) REFERENCES EVENT
*/

INSERT INTO BOOKING(ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment) VALUES
(2, 'North', 2016, 'Jan', 9, '16-December-2015', 200),
(1, 'North', 2016, 'Jan', 9, '10-December-2015', 200),
(1, 'North', 2016, 'Feb', 13, '08-January-2016', 225),
(2, 'North', 2016, 'Feb', 13, '14-January-2016', 125),
(3, 'North', 2016, 'Feb', 13, '03-February-2016', 225),
(1, 'South', 2016, 'Jan', 9, '10-December-2015', 200),
(2, 'South', 2016, 'Jan', 16, '18-December-2015', 200),
(3, 'South', 2016, 'Jan', 16, '09-January-2016', 200),
(2, 'West', 2016, 'Jan', 29, '17-December-2015', 225),
(3, 'West', 2016, 'Jan', 29, '18-December-2015', 200);



select * from TOUR;
select * from CLIENT;
select * from EVENT;
select * from BOOKING;


/*
Task 4 - 
*/

/*
Query 1:
• Write a query that shows the client first name and surname, the tour name and description,
the tour event year, month, day and fee, the booking date and the fee paid for the booking.
*/

/*
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

Select CLIENT.Surname, CLIENT.GivenName, 
    TOUR.TourName, TOUR.Description, 
    EVENT.EventYear, EVENT.EventMonth, EVENT.EventDay, EVENT.Fee,
    BOOKING.DateBooked, BOOKING.Payment
    FROM
    (((CLIENT LEFT JOIN BOOKING
    ON CLIENT.ClientID=BOOKING.ClientID)
    LEFT JOIN EVENT
    ON EVENT.TourName=BOOKING.TourName AND EVENT.EventYear=BOOKING.EventYear 
        AND EVENT.EventMonth=BOOKING.EventMonth AND EVENT.EventDay=BOOKING.EventDay)
    LEFT JOIN TOUR
    ON TOUR.TourName=EVENT.TourName);

/*
Query 2:
• Write a query which shows the number of bookings for each (tour event) month, for each
tour in the following example format. For example:
EventMonth  TourName    Num Bookings
Jan         North       1
Jan         South       7
Jan         West        4
Feb         North       5

(The actual results will vary. This demonstrates format only)

BOOKING(ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay)
FOREIGN KEY(ClientID) REFERENCES CLIENT
FOREIGN Key(TourName, EventYear, EventMonth, EventDay) REFERENCES EVENT
*/

Select EventMonth, TourName, Count(*) AS 'Num Bookings'
From BOOKING
Group By EventMonth, TourName;

/*
Query 3:
• Write a query which lists all bookings which have a payment amount greater than the average
payment amount. (This query must use a sub-query.)
*/

Select AVG(Payment) from BOOKING;

Select * FROM BOOKING 
WHERE Payment>(Select AVG(Payment) from BOOKING);

