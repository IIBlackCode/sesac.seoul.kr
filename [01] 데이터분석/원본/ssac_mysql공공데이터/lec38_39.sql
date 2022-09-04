/*
 * 38차시
 * 1. 테이블 생성
 * 2. 데이터 들여오기
 * 3. bicycle_202012 데이터 살펴보기
 */
use seoul_data;

/* 1. 테이블 생성 */

-- 2020/12월 공공자전거 테이블
CREATE TABLE IF NOT EXISTS `bicycle_202012` (
  `자전거번호` varchar(12),
  `대여일시` datetime,
  `대여소번호` int,
  `대여소명` varchar(100),
  `대여거치대` int DEFAULT NULL,
  `반납일시` datetime,
  `반납대여소번호` int,
  `반납대여소명` varchar(100),
  `반납거치대` int DEFAULT NULL,
  `이용시간` int DEFAULT NULL,
  `이용거리` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



/*
CREATE TABLE `bicycle_rent` (
  `ID` varchar(12),            -- 자전거번호
  `LD_TIME` datetime,          -- 대여일시
  `ST_ID` int,				         -- 대여소번호
  `ST_NAME` varchar(100),		   -- 대여소명
  `LD_RACK` int DEFAULT NULL,	 -- 대여거치대
  `RT_TIME` datetime,		       -- 반납일시
  `RT_STID` int,				       -- 반납대여소번호
  `RT_ST` varchar(100),		     -- 반납대여소이름 
  `RT_RACK` int DEFAULT NULL,  -- 반납거치대
  `U_TIME` int DEFAULT NULL,	 -- 이용시간 
  `U_DIST` double DEFAULT NULL -- 이용거리
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
*/


/* 2. 데이터 들여오기 */

SELECT @@max_allowed_packet / 1024 / 1024;

/*
SELECT @@max_allowed_packet / 1024 / 1024;

SET GLOBAL max_allowed_packet=10000000000;
SELECT @@max_allowed_packet / 1024 / 1024;

SELECT @@innodb_flush_log_at_trx_commit;

*/

-- show variables like 'local_infile';
-- SET GLOBAL local_infile = 1;
-- LOAD DATA LOCAL INFILE 'D:/Db_공공데이터-SQLite3/공공자전거 대여이력 정보_2020.12.csv' INTO TABLE bicycle_rent FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;


/* 3. bicycle_202012 데이터 살펴보기 */
 
select count(*) from bicycle_202012;

desc bicycle202012;


-- 
SELECT count(*) from bicycle202012;

-- 대여소 숫자
select count(distinct `대여소번호`), count(distinct `대여소명`) from bicycle202012;

-- 자전거 숫자
select count(`자전거번호`), count(distinct `자전거번호`) from bicycle202012;


-- 대여소별 자전거 숫자
select `대여소명`,
	count(`자전거번호`) 자전거숫자
from bicycle202012
group by `대여소명`
order by 2 desc
;

select `대여소명`,
	count(distinct `자전거번호`) 회전
from bicycle202012
group by `대여소명`
order by 2 desc
;


-- 자전거별 
select `자전거번호`,
	count(`이용시간`) 횟수,
    sum(`이용시간`) 시간
from bicycle202012
group by `자전거번호`
order by 3 desc
;




/*
 * 39 차시 실습 
    - 데이터 종류, 지표 등 살펴보기
 */

USE seoul_data;

/* 시간날짜 형식으로 업데이트
SELECT 대여일시 FROM bicycle_rental;

-- UPDATE bicycle_rental SET
-- 	대여일시 = STR_TO_DATE(대여일시, '%Y-%m-%d %H:%i:%s');

SELECT STR_TO_DATE(대여일시, '%Y-%m-%d %H:%i:%s') D 
FROM bicycle_rental
WHERE DATE_FORMAT(STR_TO_DATE(대여일시, '%Y-%m-%d %H:%i:%s'), "%Y-%m-%d") = "2021-12-01";

SELECT DATE_FORMAT(STR_TO_DATE(대여일시, '%Y-%m-%d %H:%i:%s'), "%Y-%m-%d") FROM bicycle_rental;
*/

-- 기본 테이블
DESC BICYCLE_202012;


-- BICYCLE_RENTAL 뷰 생성

CREATE OR REPLACE VIEW BICYCLE_RENTAL
AS 
	SELECT * FROM BICYCLE_202012;

DESC BICYCLE_RENTAL;

--
SELECT * FROM BICYCLE_RENTAL limit 10;


-- 대여소 숫자
-- 2095	1185907
SELECT  COUNT(DISTINCT 대여소번호 ) 대여소숫자
	, COUNT(*) 레코드수
FROM  BICYCLE_RENTAL;


-- 자전거 수량

SELECT COUNT(DISTINCT 자전거번호) 수량
FROM BICYCLE_RENTAL
;



-- 대여소별 사용한 자전거 수량 

SELECT 대여소번호
	, 대여소명
	, COUNT(DISTINCT 자전거번호) 수량
FROM BICYCLE_RENTAL
GROUP BY 대여소번호
ORDER BY 3 DESC
;


-- 대여소별 사용한 자전거 
SELECT 대여소번호
	, COUNT(자전거번호) 수량
FROM BICYCLE_RENTAL
GROUP BY 대여소번호
;



-- 대여소별 이용량이 많은 곳.
SELECT  대여소번호
	, 대여소명
	, COUNT(이용시간)
FROM  BICYCLE_RENTAL
GROUP BY  1,2
ORDER BY  3 DESC ;




-- 월별 이용시간 집계
SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY,
		SUM(이용시간) 합계,
        AVG(이용시간) 평균,
		MIN(이용시간) 최소,
        MAX(이용시간) 최대,
        AVG(이용거리) 평균거리
FROM BICYCLE_RENTAL
GROUP BY MONTHLY
ORDER BY 1;

-- 자전거별 월별 이용시간 집계
SELECT 자전거번호, 
		DATE_FORMAT(대여일시,'%Y-%m') 월간,
		SUM(이용시간) 합계,
        AVG(이용시간) 평균,
		MIN(이용시간) 최소,
        MAX(이용시간) 최대,
        AVG(이용거리) 평균거리
FROM BICYCLE_RENTAL
GROUP BY 자전거번호, 월간
ORDER BY 1;


/* 대여횟수 */
-- 월별 대여횟수
SELECT DATE_FORMAT(대여일시,'%Y-%m') 월간,
       COUNT(대여일시) 횟수
FROM BICYCLE_RENTAL
GROUP BY 1
ORDER BY 1;


-- 월 기준 대여소별 대여횟수
SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY
	, 대여소명
    , COUNT(대여일시) 횟수
FROM BICYCLE_RENTAL
GROUP BY MONTHLY, 대여소명
ORDER BY 1;


-- 월 기준 대여소의 자전거별 대여횟수
SELECT DATE_FORMAT(대여일시,'%Y-%m') 월간
	, 대여소명
    , 자전거번호
    , COUNT(대여일시) 횟수
FROM BICYCLE_RENTAL
GROUP BY 월간, 대여소명, 자전거번호
ORDER BY 4 DESC;


-- 월 기준 대여소의 자전거별 대여횟수
SELECT DATE_FORMAT(대여일시,'%Y-%m') 월간
	, 대여소명
    , 자전거번호
    , COUNT(대여일시) 횟수
    , SUM(이용시간) 총시간
FROM BICYCLE_RENTAL
GROUP BY 월간, 대여소명, 자전거번호
ORDER BY 4 DESC;


-- 일별 이용량
SELECT DATE_FORMAT( 대여일시, "%Y%m%d") AS 대여일시, 
		COUNT(*) 수량, 
        AVG(이용시간) 평균시간,
        AVG(이용거리) 평균거리
FROM  BICYCLE_RENTAL
GROUP BY 대여일시
ORDER BY  1 ASC;
 
-- 일별+대여소 이용량
SELECT 	DATE_FORMAT( 대여일시, "%Y%m%d") AS 대여일시, 
		대여소명,
		COUNT(자전거번호) 수량, 
        AVG(이용시간) 평균시간,
        AVG(이용거리) 평균거리
FROM  BICYCLE_RENTAL
GROUP BY 대여일시, 대여소명
ORDER BY  1 ASC;


SELECT 대여소번호
	, 대여소명
	, COUNT(DISTINCT 자전거번호) 수량
FROM BICYCLE_RENTAL
GROUP BY 대여소번호
ORDER BY 3 DESC
;


-- 총이용시간별 대여소 등급
SELECT  대여소번호
	, 대여소명
	, COUNT(DISTINCT 자전거번호) 수량
	, SUM(이용시간) AS 총시간
    , CASE 
          WHEN (SUM(이용시간) >= 80000) THEN '최우수'
          WHEN (SUM(이용시간)  >= 15000) THEN '우수'
          WHEN (SUM(이용시간)  >= 8000 ) THEN '일반'
          ELSE '기타'
       END AS '등급'
FROM BICYCLE_RENTAL
GROUP BY 대여소명
ORDER BY 4 DESC
;


--  주말, 주중 이용량 비교(절대치)

-- 1.
SELECT DATE_FORMAT( 대여일시, "%Y%m%d") RT
		, COUNT(*) CNT   -- 평균수량
		, AVG(이용시간) UT	 -- 평균사용시간
		, AVG(이용거리) DST -- 평균거리
FROM  BICYCLE_RENTAL
GROUP BY  1;

-- 2. 
--  일별 집계를 하고 주간 집계로 진행
SELECT  WEEK(RT) 주간
		, AVG(CNT) CNT -- 평균수량
		, AVG(UT ) UT  -- 평균사용시간
		, AVG(DST) DST -- 평균거리
  FROM  ( 
	SELECT DATE_FORMAT( 대여일시, "%Y%m%d") RT
				, COUNT(*) CNT
				, AVG(이용시간) UT	
				, AVG(이용거리) DST
	  FROM  BICYCLE_RENTAL
	  GROUP BY  1
		) A 
 GROUP  BY  1
 ORDER  BY  1 ;




/* Invalid Group function 

SELECT  WEEK(대여일시) 주간
		, AVG(COUNT(*)) CNT -- 평균수량
		, AVG(이용시간 ) UT  -- 평균사용시간
		, AVG(이용거리) DST -- 평균거리
FROM  BICYCLE_RENTAL
GROUP  BY  1
ORDER  BY  1 ;
*/