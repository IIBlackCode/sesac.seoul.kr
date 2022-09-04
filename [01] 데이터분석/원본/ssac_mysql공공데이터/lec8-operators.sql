/*
 * lec8 - Operators
 */

/* 1. 산술연산자 */

select 1;

select 1+1;

SELECT 0.1;

SELECT 1-1;

SELECT 100/20;

SELECT 5.0/2;

SELECT 1-1, 100/20, 5.0/2;


/* BOOK 테이블과 연산자 */
-- price 열의 값에 0.05를 곱한다.
SELECT price * 0.05 FROM book;

-- total 열의 값을 number 열의 값으로 나눈다. 
SELECT price / 2 FROM book;

SELECT (price / 2) * 100 FROM book;


/* 2. 비교 연산자 */
SELECT 1 > 100;
SELECT 1 < 100;
SELECT 10 = 10;
SELECT 101 <> 10;
SELECT 101 != 10;


/* 2. 논리 연산자 */
SELECT (10 >= 10) AND ( 5 < 10);

SELECT (10 > 10) AND ( 5 < 10);

SELECT (10 > 10) OR ( 5 < 10);

SELECT NOT (10 > 10);




/* 5. 집계 함수 */

-- 북스토어의 도서 판매 건수를 구하시오.
SELECT	COUNT(*)
FROM     	Orders;

-- 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT	SUM(saleprice) 
FROM	Orders;

-- 고객이 주문한 도서의 총 판매액을 '총매출' 로 구하시오.
SELECT	SUM(saleprice) AS 총매출
FROM	Orders;

-- 고객이 주문한 도서의 총 판매액 평균을 구하고 '매출평균'으로 구하시오.
SELECT	AVG(saleprice) AS 매출평균
FROM	Orders;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT	SUM(saleprice) AS Total,
            	AVG(saleprice) AS Average,
            	MIN(saleprice) AS Minimum,
            	MAX(saleprice) AS Maximum
FROM    	Orders;
