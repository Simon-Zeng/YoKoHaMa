-- Create table structures

CREATE TABLE IF NOT EXISTS Items (
    identifier INTEGER PRIMARY KEY AUTO-INCREMENT,
    name TEXT NOT NULL,
    categoryIdentifier INTEGER DEFAULT 0 // 0: user defined
);

CREATE TABLE IF NOT EXISTS ItemCategories (
    identifier INTEGER PRIMARY KEY AUTO-INCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Trips (
    identifier INTEGER PRIMARY KEY,
    name TEXT NOT NULL
)

CREATE TABLE IF NOT EXISTS TripItems(
    tripIdentifier INTEGER NOT NULL,
    itemIdentifier INTEGER NOT NULL,
    required       INTEGER DEFAULT 0,
    state          INTEGER DEFAULT 0 // 0: TO prepare. 1: Prepared
);

 CREATE UNIQUE INDEX IF NOT EXISTS TripItems_trip_item ON TripItems (tripIdentifier, itemIdentifier);
 
 -- Initialize data
INSERT OR REPLACE INTO ItemCategories (name) VALUES ('自定义'), ('必备'), ('露营装备'), ('服装'), ('生活用品'), ('电子类'), ('药品类'), ('必备');
