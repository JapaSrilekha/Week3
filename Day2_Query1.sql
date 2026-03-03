-- =============================================
-- CREATE DATABASE
-- =============================================
CREATE DATABASE EventDb;
GO

USE EventDb;
GO


-- =============================================
-- 1. USERINFO TABLE
-- =============================================
CREATE TABLE UserInfo (
    EmailId VARCHAR(100) PRIMARY KEY,
    UserName VARCHAR(50) NOT NULL CHECK(LEN(UserName) BETWEEN 1 AND 50),
    Role VARCHAR(20) NOT NULL CHECK(Role IN ('Admin','Participant')),
    Password VARCHAR(20) NOT NULL CHECK(LEN(Password) BETWEEN 6 AND 20)
);
GO

-- =============================================
-- 2. EVENTDETAILS TABLE
-- =============================================
CREATE TABLE EventDetails (
    EventId INT PRIMARY KEY,
    EventName VARCHAR(50) NOT NULL CHECK(LEN(EventName) BETWEEN 1 AND 50),
    EventCategory VARCHAR(50) NOT NULL CHECK(LEN(EventCategory) BETWEEN 1 AND 50),
    EventDate DATETIME NOT NULL,
    Description VARCHAR(500),
    Status VARCHAR(20) NOT NULL CHECK(Status IN ('Active','In-Active'))
);
GO

-- =============================================
-- 3. SPEAKERSDETAILS TABLE
-- =============================================
CREATE TABLE SpeakersDetails (
    SpeakerId INT PRIMARY KEY,
    SpeakerName VARCHAR(50) NOT NULL CHECK(LEN(SpeakerName) BETWEEN 1 AND 50)
);
GO

-- =============================================
-- 4. SESSIONINFO TABLE
-- =============================================
CREATE TABLE SessionInfo (
    SessionId INT PRIMARY KEY,
    EventId INT NOT NULL,
    SessionTitle VARCHAR(50) NOT NULL CHECK(LEN(SessionTitle) BETWEEN 1 AND 50),
    SpeakerId INT NOT NULL,
    Description VARCHAR(500),
    SessionStart DATETIME NOT NULL,
    SessionEnd DATETIME NOT NULL,
    SessionUrl VARCHAR(2048),

    FOREIGN KEY(EventId) REFERENCES EventDetails(EventId),
    FOREIGN KEY(SpeakerId) REFERENCES SpeakersDetails(SpeakerId),
    CHECK(SessionEnd > SessionStart)
);
GO

-- =============================================
-- 5. PARTICIPANTEVENTDETAILS TABLE
-- =============================================
CREATE TABLE ParticipantEventDetails (
    Id INT PRIMARY KEY,
    ParticipantEmailId VARCHAR(100) NOT NULL,
    EventId INT NOT NULL,
    SessionId INT NOT NULL,
    IsAttended BIT CHECK(IsAttended IN (0,1)),

    FOREIGN KEY(ParticipantEmailId) REFERENCES UserInfo(EmailId),
    FOREIGN KEY(EventId) REFERENCES EventDetails(EventId),
    FOREIGN KEY(SessionId) REFERENCES SessionInfo(SessionId)
);

GO