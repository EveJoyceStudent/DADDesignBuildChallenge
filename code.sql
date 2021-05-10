

-- Name: Eve Joyce
-- Student ID: 103681990

/*
Task 1 - Relational Schema
*/

/*
Task 2 - DB creation
*/

-- CREATE DATABASE DesignBuildChallenge103681990

Use DesignBuildChallenge103681990

IF OBJECT_ID('Subject') IS NOT NULL
	DROP TABLE Subject;
GO

CREATE TABLE Subject(
    SubjCode NVARCHAR(100),
    Description NVARCHAR(500),
    PRIMARY KEY (SubjCode)
);

IF OBJECT_ID('Student') IS NOT NULL
	DROP TABLE Student;
GO

CREATE TABLE Student(
    StudentId NVARCHAR(10),
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    Gender NVARCHAR(1),
    CONSTRAINT CHK_Person CHECK (Gender IN ('M', 'F', 'I')),
    PRIMARY KEY(StudentId)
);

IF OBJECT_ID('Teacher') IS NOT NULL
	DROP TABLE Teacher;
GO

CREATE TABLE Teacher(
    StaffID INT CHECK(StaffID>9999999),
    Surname NVARCHAR(100) NOT NULL,
    GivenName NVARCHAR(100) NOT NULL,
    PRIMARY KEY(StaffID)
)

IF OBJECT_ID('SubjectOffering') IS NOT NULL
	DROP TABLE SubjectOffering;
GO

CREATE TABLE SubjectOffering(
    SubjCode NVARCHAR(100), 
    Year INT CHECK (Year>999),
    Semester INT CHECK(Semester IN (1,2)),
    Fee MONEY NOT NULL CHECK(Fee > 0),
    StaffID INT,
    PRIMARY KEY(SubjCode, Year, Semester),
    FOREIGN KEY(SubjCode) REFERENCES Subject,
    FOREIGN KEY(StaffId) REFERENCES Teacher
)

IF OBJECT_ID('Enrolment') IS NOT NULL
	DROP TABLE Enrolment;
GO

CREATE TABLE Enrolment(StudentId NVARCHAR(10),
    SubjCode NVARCHAR(100),
    Year INT CHECK (Year>999),
    Semester INT CHECK(Semester IN (1,2)),
    Grade NVARCHAR(2) CHECK (Grade IN ('N', 'P', 'C', 'D', 'HD', NULL)),
    DateEnrolled DATE,
    PRIMARY KEY(StudentId,SubjCode, Year, Semester),
    FOREIGN KEY(StudentId) References Student,
    FOREIGN KEY(SubjCode, Year, Semester) References SubjectOffering
)

select table_name from information_schema.tables;
exec sp_columns project;

/* 
Task 3 - add data

INSERT INTO TABLE (COLS) VALUES
(),
();

*/

INSERT INTO Subject(SubjCode, Description) VALUES
('ICTWEB425', 'Apply SQL to extract & manipulate data'),
('ICTDBS403', 'Create Basic Databases'),
('ICTDBS502', 'Design a Database');

INSERT INTO Student(StudentId, Surname, GivenName, Gender)
VALUES
('s12233445', 'Morrison', 'Scott', 'M'),
('s23344556', 'Gillard', 'Julia', 'F'),
('s34455667', 'Whitlam', 'Gough', 'M'),
('103681990', 'Joyce', 'Eve', 'F');

INSERT INTO Teacher(StaffID, Surname, GivenName) VALUES
(98776655, 'Starr', 'Ringo'),
(87665544, 'Lennon', 'John'),
(76554433, 'McCartney', 'Paul');

INSERT INTO SubjectOffering(SubjCode, Year, Semester, Fee, StaffID) VALUES
('ICTWEB425', 2020, 1, 200, 98776655),
('ICTWEB425', 2021, 1, 225, 98776655),
('ICTDBS403', 2021, 1, 200, 87665544),
('ICTDBS403', 2021, 2, 200, 76554433),
('ICTDBS502', 2021, 2, 225, 87665544);

INSERT INTO SubjectOffering(SubjCode, Year, Semester, Fee, StaffID) VALUES
('ICTWEB425', 2019, 1, 200, 98776655),
('ICTDBS403', 2020, 1, 200, 87665544),
('ICTDBS403', 2020, 2, 200, 87665544),
('ICTDBS502', 2019, 2, 225, 87665544);

INSERT INTO Enrolment(StudentId, SubjCode, Year, Semester, Grade, DateEnrolled) VALUES
('s12233445', 'ICTWEB425', 2019, 1, 'D', '25-Feb-2019');

INSERT INTO Enrolment(StudentId, SubjCode, Year, Semester, Grade, DateEnrolled) VALUES
('s23344556', 'ICTWEB425', 2019, 1, 'P', '15-Feb-2019'),
('s12233445', 'ICTWEB425', 2020, 1, 'C', '30-Jan-2020'),
('s23344556', 'ICTWEB425', 2020, 1, 'HD', '26-Feb-2020'),
('s34455667', 'ICTWEB425', 2020, 1, 'P', '28-Jan-2020'),
('s12233445', 'ICTDBS403', 2020, 1, 'C', '8-Feb-2020'),
('s23344556', 'ICTDBS403', 2020, 2, '', '3-Feb-2021'),
('s34455667', 'ICTDBS403', 2020, 2, '', '3-Jan-2021'),
('s23344556', 'ICTDBS502', 2019, 2, 'P', '1-Jan-2019'),
('s34455667', 'ICTDBS502', 2019, 2, 'N', '13-Jan-2019');

select * from student;


/*
Task 4 - 
*/

-- Write a query that shows the student first name and surname, the subject code and description, the subject offering year, semester & fee and the given name and surname of the teacher for that subject offering.

SELECT * from 
(((Student
LEFT JOIN Enrolment
ON Student.StudentId=Enrolment.StudentId)
LEFT JOIN SubjectOffering
ON Enrolment.SubjCode=SubjectOffering.SubjCode AND
 Enrolment.Year=SubjectOffering.Year AND
 Enrolment.Semester=SubjectOffering.Semester)
LEFT JOIN Subject
ON Enrolment.SubjCode=Subject.SubjCode)
LEFT JOIN Teacher
ON SubjectOffering.StaffId=Teacher.StaffId
;

-- Write a query which shows the number of enrolments, for each year and semester in the following example format. For example

Select Year, Semester, Count(*)
FROM Enrolment
GROUP BY Year, Semester;

Select *
FROM Enrolment
WHERE Year=2020 AND Semester=1;


-- Write a query which lists all enrolments which for the subject offering which has the highest fee. (This query must use a sub-query.)

Select * 
FROM Enrolment
WHERE SubjCode IN (
Select SubjCode From 
    SubjectOffering WHERE
 Fee = (Select Max(Fee) From SubjectOffering))
ORDER BY SubjCode;

/*
Task 5 - 
*/
GO;

CREATE VIEW STUDENTVIEW AS 
(Select * 
FROM Enrolment
WHERE SubjCode IN (
Select SubjCode From 
    SubjectOffering WHERE
 Fee = (Select Max(Fee) From SubjectOffering)))
;

GO;

Select * From STUDENTVIEW;