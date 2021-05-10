

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
