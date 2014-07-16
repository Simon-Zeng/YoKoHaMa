-- Create table structures

CREATE TABLE IF NOT EXISTS Items (
    identifier INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    categoryIdentifier INTEGER DEFAULT 0 /* 0: user defined */
);

CREATE TABLE IF NOT EXISTS ItemCategories (
    identifier INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Trips (
    identifier INTEGER PRIMARY KEY,
    name TEXT NOT NULL
)

CREATE UNIQUE INDEX IF NOT EXISTS Trips_name ON Trips (name);

CREATE TABLE IF NOT EXISTS TripItems(
    tripIdentifier INTEGER NOT NULL,
    itemIdentifier INTEGER NOT NULL,
    itemName TEXT NOT NULL,
    required       INTEGER DEFAULT 0,
    state          INTEGER DEFAULT 0 /* 0: TO prepare. 1: Prepared */
);

 CREATE UNIQUE INDEX IF NOT EXISTS TripItems_trip_item ON TripItems (tripIdentifier, itemIdentifier);
 
-- Initialize Category data


INSERT INTO ItemCategories (name) VALUES ('自定义'), ('文本'), ('日用品'), ('药品'), ('其他'), ('车辆备件');

-- Initialize item data

INSERT INTO Items (name, categoryIdentifier) VALUES ('身份证', 2), ('驾驶证',2), ('保险单',2), ('养路费及购置税/车辆使用税缴税凭证',2), ('公路地图',2), ('信用卡',2), ('笔记本和笔',2);

INSERT INTO Items (name, categoryIdentifier) VALUES ('适时衣服', 3), ('遮阳帽',3), ('手套',3), ('适宜驾驶的软底鞋',3), ('雨具',3), ('电筒',3), ('照相器材',3), ('洗漱用品等',3);

INSERT INTO Items (name, categoryIdentifier) VALUES ('绷带', 4), ('创可贴',4), ('消毒药水',4), ('消炎药',4), ('晕车药',4), ('驱蚊虫药水等',4);

INSERT INTO Items (name, categoryIdentifier) VALUES ('多功能手表', 5), ('指南针',5), ('移动电话',5), ('组合刀具',5), ('对讲机',5);

INSERT INTO Items (name, categoryIdentifier) VALUES ('全套随车工具', 6), ('备用轮胎',6), ('牵引绳',6), ('备用油桶',6), ('水桶',6), ('工兵铲等',6);

INSERT INTO Trips (name) VALUES ('草原之旅'), ('高原之行'), ('海边度假'), ('沙漠探险');

INSERT INTO TripItems (tripIdentifier, itemIdentifier, itemName) SELECT t.identifier, i.identifier, i.name FROM Trips t, Items i;
