CREATE DATABASE RACEDAY_DB

USE RACEDAY_DB

CREATE TABLE Organisers
(
    OrganiserID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE Participants
(
    ParticipantID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Surname VARCHAR(50) NOT NULL,
    Age INT NOT NULL CHECK (Age > 0 AND Age < 120),
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(20) NOT NULL
);

CREATE TABLE [USER]
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    UserType VARCHAR(20) NOT NULL
        CHECK (UserType IN ('Organiser', 'Participant')),
    OrganiserID INT NULL,
    ParticipantID INT NULL,

    CONSTRAINT FK_User_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES Organisers(OrganiserID),

    CONSTRAINT FK_User_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Participants(ParticipantID),

    CONSTRAINT CK_User_TypeReference
        CHECK
        (
            (UserType = 'Organiser' AND OrganiserID IS NOT NULL AND ParticipantID IS NULL)
            OR
            (UserType = 'Participant' AND ParticipantID IS NOT NULL AND OrganiserID IS NULL)
        )
);

CREATE TABLE Events
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    [Date] DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    Distance DECIMAL(6,2) NOT NULL CHECK (Distance > 0),
    EventType VARCHAR(50) NOT NULL,
    OrganiserID INT NOT NULL,

    CONSTRAINT FK_Events_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES Organisers(OrganiserID)
);

CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Age INT NOT NULL CHECK (Age > 0 AND Age < 120),
    EventID INT NOT NULL,

    CONSTRAINT FK_Category_Event
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID)
);

CREATE TABLE Enrollment
(
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,

    CONSTRAINT FK_Enrollment_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Participants(ParticipantID),

    CONSTRAINT FK_Enrollment_Event
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT UQ_Enrollment_Participant_Event
        UNIQUE (ParticipantID, EventID)
);

CREATE TABLE Results
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    FinishTime TIME NOT NULL,
    FinishPosition INT NOT NULL CHECK (FinishPosition > 0),
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,

    CONSTRAINT FK_Results_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES Participants(ParticipantID),

    CONSTRAINT FK_Results_Event
        FOREIGN KEY (EventID)
        REFERENCES Events(EventID),

    CONSTRAINT FK_Results_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
);

INSERT INTO Organisers (Name, Surname, Email, PhoneNumber)
VALUES
('Thabo', 'Mokoena', 'thabo.mokoena@raceday.co.za', '0825551001'),
('Lerato', 'Dlamini', 'lerato.dlamini@raceday.co.za', '0835551002');


INSERT INTO Participants (Name, Surname, Age, Email, PhoneNumber)
VALUES
('Sipho', 'Nkosi', 24, 'sipho.nkosi@email.com', '0845552001'),
('Anele', 'Mthembu', 29, 'anele.mthembu@email.com', '0855552002');

