/**
 * 15, 16차시 실습 
 */
 
-- 현재 날짜/시간 함수
SELECT NOW(),SYSDATE(),CURRENT_TIMESTAMP; 

SELECT CURTIME(), CURRENT_TIME;

-- 날짜 시간 증감 함수
SELECT ADDDATE('2021-8-31', INTERVAL 5 DAY), ADDDATE('2021-8-31', INTERVAL 1 MONTH);
SELECT ADDTIME('2021-01-01 23:59:59', '1:1:1'), ADDTIME('09:00:00', '2:10:10');

-- "예" 날짜/시간 사이의 차이
SELECT DATEDIFF('2022-01-01', NOW());

SELECT TIMEDIFF('23:23:59', '2:1:1');

-- 날짜/시간 생성
SELECT MAKEDATE(2021, 55);

SELECT DATE_FORMAT(MAKEDATE(2021, 55),'%Y.%m.%d');

SELECT MAKETIME(11, 11, 10); # hh:mm:ss

SELECT QUARTER('2021-04-04'); # 2


/* 자료형 변환 함수 */
USE BOOKSTORE;

-- 데이터 형식 변환 함수

-- 구매 테이블 에서 평균 구매 개수를 구한다.
SELECT AVG(saleprice) AS '평균 구매 가격' FROM orders;

-- 구매 가격을 정수로 출력 
SELECT CAST(AVG(saleprice) AS SIGNED INTEGER) 
       AS '평균 구매 가격' FROM orders;
-- 
SELECT CONVERT(AVG(saleprice), SIGNED INTEGER) AS '평균 구매 가격' FROM orders;

-- 데이터 형식 변환 함수
--  CAST( ) 함수에 다양한 구분자($, /, %, @)를 날짜 형식으로 사용할 수 있다.
SELECT CAST('2021$09$20' AS DATE) AS '날짜';

SELECT CAST('2021/09/20' AS DATE) AS '날짜';

SELECT CAST('2021%09%20' AS DATE) AS '날짜';

SELECT CAST('2021@09@20' AS DATE) AS '날짜';


-- Date and Time Data Types
-- 날짜 데이터 형식과 시간 데이터 형식

SELECT CAST('2020-10-19 12:35:29.123' AS DATE)
       AS 'DATE';

SELECT CAST('2020-10-19 12:35:29.123' AS TIME)
       AS 'TIME';

SELECT CAST('2020-10-19 12:35:29.123' AS DATETIME)
       AS 'DATETIME';


-- 암묵적 형 변환: 연산의 결과에 따른 규칙
 SELECT '100' + '200'; -- 문자와 문자를 더함(정수로 변환한 후 처리) 
 SELECT CONCAT('100', '200'); -- 문자와 문자를 연결(문자열 그대로 처리) 
 SELECT CONCAT(100, '200'); -- 정수와 문자를 연결(정수를 문자로 변환하여 처리) 
 SELECT 1 > '3mega'; -- 정수인 3으로 변환한 후 비교 
 SELECT 4 > '3MEGA'; -- 정수인 3으로 변환한 후 비교 
 SELECT 0 = 'mega3'; -- 문자가 0으로 변환됨

-- 
-- 현재시간을 날짜로 
 SELECT CAST(now() AS DATE);


 SELECT CAST("123" AS UNSIGNED);

-- 바로 앞의 SELECT 문에서 조회된 행의 개수를 반환
 SELECT * FROM ORDERS;
 SELECT FOUND_ROWS();




/**-------------------------------------------------
 * 16차시 실습 
 */
USE BOOKSTORE;

-- 현재 날짜시간 조회
SELECT CURRENT_TIMESTAMP;
SELECT NOW();     # 2021-03-07 오후 9:27:21
SELECT SYSDATE(); #2021-03-07 오후 9:27:21
SELECT CURDATE(); #2021-03-07 오전 12:00:00


-- 현재 날짜형식을 출력
SELECT DATE_FORMAT(CURDATE(),'%Y-%m-%d');
SELECT DATE_FORMAT(CURDATE(),'%d-%m, %Y');
SELECT DATE_FORMAT(CURDATE(),'%d-%m, %Y');

-- ORDERDATE 컬럼 를 특정 형식(format)의 문자열로 변환하여 반환하기
SELECT ORDERDATE FROM ORDERS;
SELECT DATE_FORMAT(CURDATE(),'%Y-%m-%d');


/* 데이터 형식 변환 함수 */

-- 문자열 날짜 데이터 형식을 DATE 형식으로
SELECT CAST('2021-02-19 10:11:40' AS DATE)
       AS 'DATE';

-- 문자열 시간 데이터 형식 DATETIME, TIME 형식으로
SELECT CAST('2021-02-19 10:11:40' AS TIME)
       AS 'TIME';

SELECT CAST('2021-02-19 10:11:40' AS DATETIME)
       AS 'DATETIME';


-- CAST 와 $,%,@ 이용 날짜형 생성
SELECT CAST('2021$09$20' AS DATE) AS '날짜' ;
SELECT CAST('2021/09/20' AS DATE) AS '날짜';
SELECT CAST('2021%09%20' AS DATE) AS '날짜';
SELECT CAST('2021@09@20' AS DATE) AS '날짜';


-- ORDERDATE 컬럼
SELECT * FROM ORDERS;
SELECT CAST(ORDERDATE AS DATETIME) FROM ORDERS;


-- 현재시간을 날짜로 
SELECT now(); # YYYY-MM-DD hh:mm:ss 형식
SELECT CAST(now() AS DATE);


-- 날짜 및 시간 더하기/빼기
-- 기준날짜로부터 하루 뒤 날짜 조회
SELECT DATE_ADD("2021-03-07 23:59:59", INTERVAL 1 DAY);

-- 한시간 전 
SELECT NOW(),DATE_ADD(NOW(), INTERVAL -1 MONTH) AS 한달전;
SELECT NOW(),DATE_ADD(NOW(), INTERVAL -1 DAY) AS 하루전;
SELECT NOW(),DATE_ADD(NOW(), INTERVAL -1 HOUR) AS 한시간전;

-- ORDERS 테이블에서 주문일자의 한달 날짜 계산
-- SELECT ORDERDATE FROM ORDERS WHERE ORDERDATE >= DATE_ADD(NOW(), INTERVAL -1 MONTH); 
SELECT ORDERDATE, DATE_ADD(ORDERDATE, INTERVAL -1 MONTH) FROM ORDERS; 
SELECT ORDERDATE, DATE_ADD(ORDERDATE, INTERVAL -1 DAY) FROM ORDERS; 

-- ORDERS 테이블에서 주문일자의 하루 전 조회
SELECT CUSTID, ORDERDATE, DATE_ADD(ORDERDATE, INTERVAL -1 DAY) AS 하루전
FROM ORDERS WHERE ORDERDATE >= DATE_ADD(ORDERDATE, INTERVAL -1 DAY); 


-- 쿼터
SELECT QUARTER(ORDERDATE) FROM ORDERS; # 2

SELECT QUARTER(DATE_ADD(ORDERDATE, INTERVAL + 3 MONTH)) AS 분기 
FROM ORDERS; # 2


