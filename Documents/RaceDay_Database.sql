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


INSERT INTO [USER]
    (Email, PasswordHash, UserType, OrganiserID, ParticipantID)
VALUES
(
    'thabo.mokoena@raceday.co.za',
    '65841431231b654a8423749225e420453d34e5d712a660dbdf61fd9e4e93e9d8',
    'Organiser',
    1,
    NULL
),
(
    'lerato.dlamini@raceday.co.za',
    '26efd3f6c3a3ac2bfa3e1ce418ab5b941c5148dc477074d0c5e9664634ebaa57',
    'Organiser',
    2,
    NULL
),
(
    'sipho.nkosi@email.com',
    'e321fc52d68bd1f1a121971c2529c53e535b5faa5f19b7a82208421b6991e086',
    'Participant',
    NULL,
    1
),
(
    'anele.mthembu@email.com',
    '3ee90c7f66a77667a1d1a66b3bd4239fd6cf4eb183916d1ed3f2f9db44c0a709',
    'Participant',
    NULL,
    2
);


INSERT INTO Events
    (Name, Description, [Date], Location, Distance, EventType, OrganiserID)
VALUES
(
    'Bloemfontein City Run',
    'A city road race suitable for recreational and competitive runners.',
    '2026-10-10',
    'Bloemfontein, Free State',
    10.00,
    'Road Race',
    1
),
(
    'Mangaung Half Marathon',
    'A 21 kilometre endurance race through Mangaung.',
    '2026-11-15',
    'Mangaung, Free State',
    21.10,
    'Half Marathon',
    2
),
(
    'Free State Fun Run',
    'A community-focused race for runners of different experience levels.',
    '2026-12-05',
    'Bloemfontein, Free State',
    5.00,
    'Fun Run',
    1
);
