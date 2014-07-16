-- Create table structures

CREATE TABLE IF NOT EXISTS Trips (
    identifier INTEGER PRIMARY KEY,
    name TEXT NOT NULL
)

CREATE TABLE IF NOT EXISTS Items (
    identifier INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    categoryIdentifier INTEGER,
    state INTEGER DEFAULT 0 /* 0: not checked */
);

CREATE TABLE IF NOT EXISTS ItemCategories (
    identifier INTEGER PRIMARY KEY AUTOINCREMENT,
    tripIdentifier INTEGER NOT NULL,
    name TEXT NOT NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS Trips_name ON Trips (name);

-- Initialize Category data --

INSERT INTO Trips (name) VALUES ('草原之旅'), ('沙漠探险'), ('海边度假'), ('高原之行');

-- 草原之旅 --

INSERT INTO ItemCategories (tripIdentifier,name) VALUES (1, '自定义'),(1, '必备'),(1, '外部装备'),(1, '服装'),(1, '生活用品'),(1, '电子类'),(1, '药品类'),(1, '食品类');

INSERT INTO Items (name, categoryIdentifier) VALUES ('身份证', 2),('驾驶本', 2),('地图', 2);

INSERT INTO Items (name, categoryIdentifier) VALUES ('双肩包或旅行包', 3),('帐蓬', 3),('睡袋', 3),('薄被', 3),('拖车绳', 3),('铁锹', 3);

INSERT INTO Items (name, categoryIdentifier) VALUES ('遮阳帽', 4),('太阳镜', 4),('长袖衣服', 4),('短袖', 4),('牛仔裤', 4),('旅游鞋', 4),('棉袜', 4),('内衣睡衣', 4),('手套', 4),('拖鞋', 4),('防晒衣', 4);

INSERT INTO Items (name, categoryIdentifier) VALUES ('防紫外线折伞', 5),('牙刷', 5),('牙膏', 5),('袋装洗发水', 5),('海绵', 5),('毛巾', 5),('肥皂', 5),('水壶', 5),('护肤品', 5),('洗面奶', 5),('润唇膏', 5),('防晒霜', 5),('面膜', 5),('剃须刀', 5),('梳子', 5),('雨伞或雨衣', 5),('针线包', 5),('小勺', 5),('纸巾（卫生纸湿巾等）', 5),('打火机', 5),('瑞士军刀', 5),('纸笔', 5),('扑克', 5);

INSERT INTO Items (name, categoryIdentifier) VALUES ('手机', 6),('相机', 6),('手机及相机充电器', 6),('手电筒', 6),('指南针', 6),('对讲机', 6),('笔记本', 6);

INSERT INTO Items (name, categoryIdentifier) VALUES ('肠胃药（诺氟沙星、马丁啉等', 7),('消炎药', 7),('去火含片', 7),('速效救心丸', 7),('创可贴（药棉、纱布）', 7),('百多邦或红花油', 7),('风油精', 7),('感冒药', 7),('驱蚊花露水', 7),('霍香正气水', 7),('晕车药品', 7);

INSERT INTO Items (name, categoryIdentifier) VALUES ('饮用水', 8),('生活水', 8),('巧克力', 8),('饼干', 8),('面包', 8),('火腿肠', 8),('蛋糕', 8),('零食', 8),('饮料', 8);

-- 沙漠探险 --

INSERT INTO ItemCategories (tripIdentifier,name) VALUES (2, '自定义'),(2, '必备'),(2, '露营装备'),(2, '服装'),(2, '生活用品'),(2, '电子类'),(2, '药品类'),(2, '食品类');

INSERT INTO Items (name, categoryIdentifier) VALUES ('身份证', 10),('驾驶本', 10),('地图', 10);

INSERT INTO Items (name, categoryIdentifier) VALUES
('帐篷', 11),('宿营灯具', 11),('炉头', 11),('五天15顿的燃料', 11),('野炊锅及餐具(饭盆，大盘大碗 大汤匙，炒菜铲)', 11),('调味料', 11),('保温壶(在沙漠中，热饮更能提振精神土气)', 11),('饮用淡水（淡水桶）', 11),('做饭洗漱用水', 11),('无磷洗涤灵', 11),('打火机', 11),('刀具', 11),('垃圾袋', 11),('针线包', 11),('一次性手套（洗菜 切菜用）', 11),('报纸', 11),('指北针', 11),('折叠铁锹', 11),('水桶', 11),('备用绳索', 11),('多种规格塑料食品袋', 11);

INSERT INTO Items (name, categoryIdentifier) VALUES ('(饱暖衣物', 12),('速干衣物', 12),('防风沙衣服及戴纱巾', 12),('遮阳帽', 12),('长衫', 12),('长裤，遮阳帽', 12),('沙漠靴', 12),('普通太阳镜', 12),('防风沙太阳镜', 12);

INSERT INTO Items (name, categoryIdentifier) VALUES ('头巾', 13),('切菜板', 13),('密封袋', 13),('扑克牌', 13),('板锹', 13),('工兵铲', 13),('一个大号水壶', 13),('一简爽身粉', 13),('手电筒', 13),('宽胶带', 13),('小圆镜', 13),('塑料袋', 13);

INSERT INTO Items (name, categoryIdentifier) VALUES ('专业的GPS', 14),('罗盘', 14),('手机', 14),('相机', 14),('手机及相机充电器', 14),('手电筒', 14),('对讲机', 14),('笔记本', 14);

INSERT INTO Items (name, categoryIdentifier) VALUES ('净水药片', 15),('感冒药', 15),('消炎药', 15),('胃药', 15),('拉肚子药', 15),('维生素', 15),('喉宝', 15),('创可贴', 15),('按摩药膏', 15),('口腔溃疡药', 15),('碘酒', 15),('体温计', 15),('眼药水', 15),('药棉', 15);

INSERT INTO Items (name, categoryIdentifier) VALUES ('果汁', 16),('奶粉', 16),('果珍', 16),('咖啡 红酒 奶糖', 16),('巧克力', 16),('方便米饭', 16),('方便面', 16),('火腿肠', 16),('午餐肉', 16),('真空包装肉食品', 16),('榨菜', 16),('新鲜的青辣椒 洋葱 鸡蛋 洋白菜 西葫芦等蔬菜', 16),('爱吃的零食', 16),('易保存的瓜果', 16),('姜', 16),('大蒜', 16);

-- 海边度假 --

INSERT INTO ItemCategories (tripIdentifier,name) VALUES (3, '自定义'),(3, '必备'),(3, '生活用品'),(3, '露营用品'),(3, '服装'),(3, '电子产品'),(3, '必备药品');

INSERT INTO Items (name, categoryIdentifier) VALUES ('身份证', 18),('护照', 18),('学生证', 18),('车票', 18),('足够的现金或信用卡', 18);

INSERT INTO Items (name, categoryIdentifier) VALUES
('太阳镜', 19),('防晒霜', 19),('泳衣', 19),('泳裤', 19),('泳帽', 19),('泳镜', 19),('浴巾', 19),('便携刀具', 19),('面巾纸', 19),('零钱包', 19),('洗漱用品全套', 19),('基础护肤产品', 19),('遮阳伞', 19),('面膜', 19),('太阳帽', 19);

INSERT INTO Items (name, categoryIdentifier) VALUES ('帐篷', 20),('防潮垫', 20),('气垫', 20),('薄睡袋', 20),('遮阳篷', 20),('沙滩椅', 20),('折叠桌', 20),('炊具', 20),('炉具', 20),('餐具', 20),('瓦斯炉', 20),('烧烤架等烧烤用具', 20),('保温箱', 20),('餐布', 20);

INSERT INTO Items (name, categoryIdentifier) VALUES ('泳装', 21),('沙滩长裙（女）', 21),('沙滩裤（男）', 21),('长袖衬衫或防晒衣', 21),('百搭吊带衫', 21),('热裤', 21),('休闲运动鞋', 21),('内衣裤', 21),('实用小背包1个', 21);

INSERT INTO Items (name, categoryIdentifier) VALUES ('手机', 22),('相机', 22),('充电器', 22);

INSERT INTO Items (name, categoryIdentifier) VALUES ('藿香正气防中暑', 23),('风油精防蚊虫', 23),('黄连素防腹泻', 23),('创可贴防受伤', 23),('晕车药', 23),('晕船药', 23);

-- 高原之行 --

INSERT INTO ItemCategories (tripIdentifier,name) VALUES (4, '自定义'),(4, '必备'),(4, '外部装备'),(4, '服装'),(4, '生活用品'),(4, '电子类'),(4, '药品类'),(4, '食品类');

INSERT INTO Items (name, categoryIdentifier) VALUES ('身份证（护照）', 25),('驾驶本', 25),('地图', 25);

INSERT INTO Items (name, categoryIdentifier) VALUES
('双肩包或旅行包', 26),('防风帐蓬', 26),('厚睡袋', 26),('充气床垫', 26),('拖车绳', 26),('铁锹', 26);

INSERT INTO Items (name, categoryIdentifier) VALUES ('遮阳帽', 27),('太阳镜', 27),('长袖衣服', 27),('牛仔裤', 27),('旅游鞋', 27),('棉袜', 27),('内衣睡衣', 27),('手套', 27),('拖鞋', 27),('防晒衣', 27),('保暖衣', 27);

INSERT INTO Items (name, categoryIdentifier) VALUES ('防紫外线折伞', 28),('雨具', 28),('牙刷', 28),('牙膏', 28),('袋装洗发水', 28),('毛巾', 28),('肥皂', 28),('水壶', 28),('护肤品', 28),('洗面奶', 28),('润唇膏', 28),('防晒霜 ', 28),('面膜', 28),('剃须刀', 28),('梳子', 28),('针线包', 28),('小勺', 28),('纸巾（卫生纸湿巾等）', 28),('打火机', 28),('瑞士军刀', 28),('纸笔', 28),('扑克', 28);

INSERT INTO Items (name, categoryIdentifier) VALUES ('手机', 29),('相机', 29),('手机及相机充电器', 29),('手电筒', 29),('指南针', 29),('对讲机', 29),('笔记本', 29);

INSERT INTO Items (name, categoryIdentifier) VALUES ('红景天口服液', 30),('复方丹参滴丸', 30),('银杏叶提取液', 30),('阿司匹林', 30),('西洋参含片', 30),('感冒药', 30),('黄连素', 30),('晕车药', 30),('速效救心丸', 30),('维生素片', 30),('肠胃药（诺氟沙星、马丁啉等）', 30),('创可贴（药棉、纱布）', 30),('晕车药品', 30),('硝苯吡啶(又名心痛定)', 30),('氨茶碱', 30),('小型氧气瓶', 30);

INSERT INTO Items (name, categoryIdentifier) VALUES ('饮用水', 31),('生活水', 31),('巧克力', 31),('糖', 31),('饼干', 31),('面包', 31),('火腿肠', 31),('蛋糕', 31),('零食', 31),('饮料', 31);

