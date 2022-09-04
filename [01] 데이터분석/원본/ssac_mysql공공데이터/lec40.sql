
/**
 * 40차시
 * - 202101월 데이터 합산
 * 1. 테이블 생성
 * 2. 데이터 들여오기
 * 3. view 생성
 * 3. bicycle_202012 데이터 살펴보기 */
 
 
 use seoul_data;

--
/* 1. '202101' 파일을
    - DBBrowser for SQLite에서 SQL 덤프 생성
*/ 

/* 2. 테이블 */
CREATE TABLE IF NOT EXISTS `bicycle_202101` (
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




/* 2. 데이터 들여오기 */

SELECT @@max_allowed_packet / 1024 / 1024;

/* 3. bicycle_202101 데이터 살펴보기 */



select count(*) from bicycle_202012;

select count(*) from bicycle_202101;

desc bicycle_202101;




/* 3. View 생성 */

-- BICYCLE_RENTAL 뷰 생성

CREATE OR REPLACE VIEW BICYCLE_RENTAL
AS 
	SELECT * FROM BICYCLE_202012
    UNION
    ALL
  	SELECT * FROM BICYCLE_202101
;


DESC BICYCLE_RENTAL;




/*  - 데이터 Top 50, Top 10 집계
*/

-- 대여소 숫자
-- 기존 202012 테이블: 2095	1185907
SELECT  COUNT(DISTINCT 대여소번호 ) 대여소숫자
	, COUNT(*) 레코드수
FROM  BICYCLE_RENTAL;


-- 자전거 수량
SELECT COUNT(DISTINCT 자전거번호) 수량
FROM BICYCLE_RENTAL
;

-- 대여소별 이용량이 많은 곳.
SELECT  대여소번호
	, 대여소명
	, COUNT(*)
FROM  BICYCLE_RENTAL
GROUP BY  1,2
ORDER BY  3 DESC ;


-- 대여소별 이용시간이 평균보다 높은 곳.
SELECT  대여소번호
	, 대여소명
	, COUNT(*) 횟수
FROM  BICYCLE_RENTAL
WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM BICYCLE_RENTAL)
GROUP BY  1,2
ORDER BY  3 DESC ;


-- 2. 요일별 평균 이용시간
SELECT
	CASE DAYOFWEEK(대여일시)
		WHEN 1 THEN "Sun"
		WHEN 2 THEN "Mon"
		WHEN 3 THEN "Tue"
		WHEN 4 THEN "Wed"
		WHEN 5 THEN "Thu"
		WHEN 6 THEN "Fri"
		WHEN 7 THEN "Sat"
	  END AS 요일
    , AVG(이용시간) AS 시간
FROM BICYCLE_RENTAL
WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM BICYCLE_RENTAL)
GROUP BY  1
;

SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY
	, CASE DATE_FORMAT( 대여일시, '%p')
		WHEN 'AM' THEN "오전"
		WHEN 'PM' THEN "오후"
	  END AMPM
    , AVG(이용시간) AS 시간
FROM BICYCLE_RENTAL
WHERE 이용시간 >= ( SELECT AVG(이용시간) FROM BICYCLE_RENTAL)
GROUP BY  1
;


/* 소계 이용 */
-- ifnull 활용
SELECT  IFNULL(대여소명,'소계')
	,  IFNULL(자전거번호,'소계')
    , SUM(이용시간)
FROM BICYCLE_RENTAL
WHERE DATE_FORMAT(대여일시,'%Y-%m-%d') BETWEEN "2020-12-01" AND  "2020-12-05"
GROUP BY 대여소명, 자전거번호 WITH ROLLUP
;

-- v8 이후 GROUPING 지원
SELECT  IF(GROUPING(대여소명),'소계',대여소명)
	,  IF(GROUPING(자전거번호),'소계',자전거번호)
    , SUM(이용시간)
FROM BICYCLE_RENTAL
WHERE DATE_FORMAT(대여일시,'%Y-%m-%d') BETWEEN "2020-12-01" AND  "2020-12-05"
GROUP BY 대여소명, 자전거번호 WITH ROLLUP
;


/* 이용량 Top10 */


-- 대여소별 이용량이 많은 곳에 대한 top10
-- 1 대여소별 순위
SELECT  대여소번호 
	, 대여소명
	, COUNT(*) 수량
    , ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
FROM  BICYCLE_RENTAL
GROUP BY  1,2
;

-- 2 대여소별 순위에서 TOP10
SELECT * 
FROM (
	SELECT  대여소번호 
		, 대여소명
		, COUNT(*) 수량
		, ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
	FROM  BICYCLE_RENTAL
	GROUP BY  1,2
) A
WHERE RNK <= 10;
;


-- 월 기준 대여소별 이용량이 많은 곳에 대한 top10
SELECT DATE_FORMAT(대여일시,'%Y-%m') MONTHLY
	, 대여소명
    , COUNT(*) 횟수
    , ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) RNK
FROM BICYCLE_RENTAL
GROUP BY MONTHLY, 대여소명
;
