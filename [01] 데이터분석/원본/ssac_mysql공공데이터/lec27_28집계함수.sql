/*
 *  27차시 실습
 */
 
/* 숫자 집계함수 */
SELECT GREATEST(29, -100, 34, 8, 25);
SELECT GREATEST("windows.com", "microsoft.com", "apple.com");

SELECT CEILING(30.75);
SELECT CEILING(40.25);
SELECT CEILING(40);

SELECT ROUND(30.75, 1);
SELECT ROUND(100.925, 2);

-- 평균도서가격
SELECT CEILING(SUM(PRICE)/COUNT(PRICE)) 평균
	,  SUM(PRICE)/COUNT(PRICE) 평균2
FROM BOOK;


/* 날짜 집계함수 */

-- WEEKOFYEAR(), YEARWEEK()

SELECT WEEKOFYEAR('2021-01-01');  -- 2020년의 53주에 해당.
SELECT WEEK('2021-01-01', 3);


  
SELECT WEEKOFYEAR('2021-01-05');  -- 2021년의 1주에 해당.

SELECT WEEKOFYEAR('2021-02-01');  -- 2021년의 5주에 해당.
SELECT WEEKOFYEAR('2021-12-31');  -- 2021년의 52주에 해당.

--
SELECT YEARWEEK('2021-01-01'); -- 2020년의 52주에 해당.

SELECT YEARWEEK('2021-01-03', 2);
SELECT YEARWEEK('2021-01-05');

SELECT YEARWEEK('2021-08-02', 7);

SELECT DAYOFYEAR("2021-01-01");
SELECT DAYOFYEAR("2021-06-15");
SELECT DAYOFYEAR("2021-12-31");


-- 주문한 년도별 가격과 평균가격

SELECT YEAR(ORDERDATE) 년도, 
	SUM(SALEPRICE) 합계, 
	CEILING(SUM(SALEPRICE)/COUNT(SALEPRICE)) 평균 
FROM ORDERS
GROUP BY YEAR(ORDERDATE);

SELECT YEAR(ORDERDATE) 년도, 
	SUM(SALEPRICE) 합계, 
	CEILING(SUM(SALEPRICE)/COUNT(SALEPRICE)) 평균 
FROM ORDERS
GROUP BY 1;
 

/* view와 집계 함수 */
-- 주별 최소/최대 판매가 집계
SELECT YEARWEEK(orderdate)
	, orderdate
    , MIN(saleprice)
    , MAX(saleprice)
FROM Orders
GROUP BY YEARWEEK(orderdate);


CREATE OR REPLACE VIEW v_Weekly(Weekly, Date, MIN, MAX)
AS SELECT YEARWEEK(orderdate) Weekly, orderdate 'Date', 
          MIN(saleprice) MIN, MAX(saleprice) MAX
   FROM Orders
   GROUP BY YEARWEEK(orderdate);

SELECT * FROM v_Weekly;


-- 특정 기간에 대한 요일별 판매량
-- 요일별 판매량 보고서는 특정 기간동안 Sun에서 Sat 요일별 판매량를 리포팅 해줍니다

-- 1. 수량 처리
SELECT   count(orderid) AS 수량 FROM ORDERS;
SELECT   count(custid) AS 수량 FROM ORDERS;

-- 2. 요일별 수량 처리
SELECT
  CASE DAYOFWEEK(orderdate)
    WHEN 1 THEN "Sun"
    WHEN 2 THEN "Mon"
    WHEN 3 THEN "Tue"
    WHEN 4 THEN "Wed"
    WHEN 5 THEN "Thu"
    WHEN 6 THEN "Fri"
    WHEN 7 THEN "Sat"
  END AS 요일,
  count(orderid) AS 수량
FROM Orders;


-- 3. 기간별 통계
SELECT
  CASE DAYOFWEEK(orderdate)
    WHEN 1 THEN "Sun"
    WHEN 2 THEN "Mon"
    WHEN 3 THEN "Tue"
    WHEN 4 THEN "Wed"
    WHEN 5 THEN "Thu"
    WHEN 6 THEN "Fri"
    WHEN 7 THEN "Sat"
  END AS 요일
	,count(custid) AS 수량
FROM Orders 
WHERE date_format(orderdate,"%Y-%m-%d") BETWEEN "2021-01-01" AND "2021-08-31"
GROUP BY DAYOFWEEK(orderdate);

-- 5. 뷰 생성
CREATE OR REPLACE VIEW v_weekday(요일, 수량)
AS
	SELECT
	  CASE DAYOFWEEK(orderdate)
		WHEN 1 THEN "Sun"
		WHEN 2 THEN "Mon"
		WHEN 3 THEN "Tue"
		WHEN 4 THEN "Wed"
		WHEN 5 THEN "Thu"
		WHEN 6 THEN "Fri"
		WHEN 7 THEN "Sat"
	  END AS 요일
	,count(custid) AS 수량
	FROM Orders 
	WHERE date_format(orderdate,"%Y-%m-%d") BETWEEN "2021-01-01" AND "2021-08-31"
	GROUP BY DAYOFWEEK(orderdate)
;

SELECT * FROM V_WEEKDAY;




/*
# https://bluexmas.tistory.com/626


-- Weekly 주별 판매량 (52주 기준)1
-- 주별로 판매량은 1년을 52주를 기준으로도 볼 수 있는 리포팅으로 사용도 가능합니다.

-- group by, YEAR()와 WEEK()를 이용한 주별 기준 통계
SELECT
 CONCAT(YEAR(orderdate),"/",Week(orderdate)) YYYYWeek
,CONCAT(DATE_FORMAT(DATE_ADD(orderdate, INTERVAL(1-DAYOFWEEK(orderdate)) DAY),"%m/%d/%Y"),
" -  "
,DATE_FORMAT(DATE_ADD(orderdate, INTERVAL(7-DAYOFWEEK(orderdate)) DAY),"%m/%d/%Y")) AS DateRange
,count(custid) AS Total
FROM Orders
WHERE date_format(orderdate,"%Y-%m-%d") BETWEEN "2021-01-01" AND "2021-08-31"
GROUP BY CONCAT(YEAR(orderdate), "/", WEEK(orderdate));


-- (Case2) Weekly 리포트의 쿼리 예제 2
-- group by YEARWEEK(reg_date)를 이용한 주별 기준 통계로 그룹핑합니다.

SELECT
  WEEK(reg_date) AS week,
  SUM(left_cnt) AS lct,
  SUM(right_cnt) AS rct,
  CONCAT(
    DATE_FORMAT(DATE_ADD(dtentered, INTERVAL(1-DAYOFWEEK(reg_date)) DAY),'%Y-%m-%e'),
    ' TO ',   
    DATE_FORMAT(DATE_ADD(dtentered, INTERVAL(7-DAYOFWEEK(reg_date)) DAY),'%Y-%m-%e')
  ) AS DateRange
FROM `DailyCount`
WHERE paid='1' and regid='SF00033200712'
GROUP BY YEARWEEK(reg_date)





-- MySQL - 주간통계
SELECT DATE_FORMAT(DATE_SUB(`reg_date`, INTERVAL (DAYOFWEEK(`reg_date`)-1) DAY), '%Y/%m/%d') as start,
       DATE_FORMAT(DATE_SUB(`reg_date`, INTERVAL (DAYOFWEEK(`reg_date`)-7) DAY), '%Y/%m/%d') as end,
       DATE_FORMAT(`reg_date`, '%Y%U') AS `date`, 
       sum(`value`)
  FROM test_st
 GROUP BY date;

-- 월간통계

SELECT MONTH(`reg_date`) AS `date`, 
       sum(`value`)
  FROM test_st
 GROUP BY `date`;


-- 기간별 통계

SELECT DATE(`reg_date`) AS `date`,
       sum(`value`)
  FROM test_st
 WHERE DATE(`reg_date`) >= STR_TO_DATE('2017-04-01', '%Y-%m-%d')
   AND DATE(`reg_date`) <= STR_TO_DATE('2017-04-10', '%Y-%m-%d')
 GROUP BY `date`;
*/