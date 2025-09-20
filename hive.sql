set hive.exec.mode.local.auto=true;
set hive.exec.mode.local.auto.inputbytes.max=50000000;
set hive.exec.mode.local.auto.tasks.max=10;

-- 创建数据库
CREATE DATABASE IF NOT EXISTS hdfs;

use hdfs;

-- 基于tourist数据的原始表
DROP TABLE IF EXISTS tourist_info;
CREATE EXTERNAL TABLE IF NOT EXISTS tourist_info(
city string comment '城市',
name string comment '名称',
star string comment '星级',
score double comment '评分',
price double comment '价格',
sales int comment '销量',
provinces_and_municipalities string comment '省/市/区',
coordinate string comment '坐标',
brief_introduction string comment '简介',
is_free string comment '是否免费',
specific_address string comment '具体地址'
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/data/origin/tourist_info/'
TBLPROPERTIES ("skip.header.line.count"="1");
select * from tourist_info limit 10;


-- 景点简介
DROP TABLE IF EXISTS tourist_word;
CREATE EXTERNAL TABLE IF NOT EXISTS tourist_word(
word string comment '单词',
num int comment '数量'
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
LOCATION '/data/origin/tourist_word/';
select * from tourist_word limit 10;

-- 销量前20热门景点数据
DROP TABLE IF EXISTS tourist_place_topn;
CREATE TABLE IF NOT EXISTS tourist_place_topn AS
SELECT name,sales FROM tourist_info ORDER BY sales DESC limit 20;
select * from tourist_place_topn limit 10;

-- 假期出行数据全国地图分布
DROP TABLE IF EXISTS tourist_map_china;
CREATE TABLE IF NOT EXISTS tourist_map_china AS
SELECT city,sum(sales) as num FROM tourist_info GROUP BY city;
select * from tourist_map_china limit 10;
-- 各省市4A-5A景区数量柱状
-- 各省市4A-5A景区数量玫瑰图
-- 各省市4A-5A景区数量阴影散点图
-- 各省市4A-5A景区地图分布
DROP TABLE IF EXISTS tourist_place_4a_5a;
CREATE TABLE IF NOT EXISTS tourist_place_4a_5a AS
SELECT city,count(1) as num FROM tourist_info WHERE star in ('4A','5A') GROUP BY city;
select * from tourist_place_4a_5a limit 10;

-- 门票价格区间占比玫瑰图
-- 门票价格区间数量散点图
DROP TABLE IF EXISTS tourist_price_range;
CREATE TABLE IF NOT EXISTS tourist_price_range AS
SELECT price_range,count(1) as num
FROM(
SELECT
case
when price>=0 and price<50 then '0-50'
when price>=50 and price<100 then '50-100'
when price>=100 and price<150 then '100-150'
when price>=150 and price<200 then '150-200'
when price>=200 and price<250 then '200-250'
when price>=250 and price<300 then '250-300'
when price>=300 and price<350 then '300-350'
when price>=350 and price<400 then '350-400'
when price>=400 and price<450 then '400-450'
when price>=450 and price<500 then '450-500'
ELSE '>=500'
END as price_range
FROM tourist_info WHERE price>=0
) a
GROUP BY price_range;
select * from tourist_price_range limit 10;