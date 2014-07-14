-- Create table structures

CREATE TABLE IF NOT EXISTS Fees (
    identifier INTEGER PRIMARY KEY AUTO-INCREMENT,
    travelIdentifier INTEGER NOT NULL,
    name TEXT NOT NULL,
    cost INTEGER DEFAULT 0,
    desc TEXT DEFAULT '',
);

CREATE TABLE IF NOT EXISTS Travels (
    identifier INTEGER PRIMARY KEY AUTO-INCREMENT,
    name TEXT NOT NULL,
    membersCount INTEGER DEFAULT 1,
    averageCost INTEGER DEFAULT 0
);

 -- Initialize data

