CREATE database IF NOT EXISTS echarts;
ALTER DATABASE echarts CHARACTER SET utf8 COLLATE utf8_general_ci;
use echarts;

DROP TABLE IF EXISTS tourist_word;
CREATE TABLE IF NOT EXISTS tourist_word(
 word VARCHAR(128),
 num int
) ENGINE = InnoDB,
DEFAULT CHARSET = utf8mb4,
COLLATE = utf8mb4_unicode_ci;


DROP TABLE IF EXISTS tourist_place_topn;
CREATE TABLE IF NOT EXISTS tourist_place_topn(
 name VARCHAR(128),
 sales int
) ENGINE = InnoDB,
DEFAULT CHARSET = utf8mb4,
COLLATE = utf8mb4_unicode_ci;


DROP TABLE IF EXISTS tourist_map_china;
CREATE TABLE IF NOT EXISTS tourist_map_china(
 city VARCHAR(128),
 num int
) ENGINE = InnoDB,
DEFAULT CHARSET = utf8mb4,
COLLATE = utf8mb4_unicode_ci;


DROP TABLE IF EXISTS tourist_place_4a_5a;
CREATE TABLE IF NOT EXISTS tourist_place_4a_5a(
 city VARCHAR(128),
 num int
) ENGINE = InnoDB,
DEFAULT CHARSET = utf8mb4,
COLLATE = utf8mb4_unicode_ci;



DROP TABLE IF EXISTS tourist_price_range;
CREATE TABLE IF NOT EXISTS tourist_price_range(
 price_range VARCHAR(128),
 num int
) ENGINE = InnoDB,
DEFAULT CHARSET = utf8mb4,
COLLATE = utf8mb4_unicode_ci;