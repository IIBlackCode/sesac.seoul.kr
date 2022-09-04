/**
 * 19차시/20차시  실습
 */

use bookstore;

/* 자주 사용하는 집계함수 */
-- 총 주문량을 조회
SELECT	COUNT(*), COUNT(SALEPRICE)
FROM  Orders;

-- 널을 포함한 컬럼의 결과 비교
SELECT	COUNT(*), COUNT(PHONE)
FROM  CUSTOMER;


-- 평균 구매 가격을 조회
SELECT	AVG(O.SALEPRICE) 평균주문가격, AVG(B.PRICE) 평균가격
FROM Orders O, BOOK B;

-- 총주문량과 평균판매가
SELECT COUNT(*), 
	SUM(SALEPRICE) 평균주문가격, 
	AVG(IFNULL(SALEPRICE,0)) 평균가격_널
FROM  Orders;


--  고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하고, 
-- 판매된 도서의 종류를 개수로 조회하자
SELECT	SUM(saleprice) AS 총매출,
		AVG(saleprice) AS 평균,
		MIN(saleprice) AS 최소값,
		MAX(saleprice) AS 최대값,
        C.USERNAME AS 고객,
        COUNT(DISTINCT B.BOOKID) AS 도서수 
FROM Orders O, BOOK B, CUSTOMER C
WHERE O.BOOKID = B.BOOKID
AND C.CUSTID = O.CUSTID
;




/** group by **/

-- 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT *
FROM Orders;

SELECT	custid, 
		COUNT(*) AS '도서수량', 
		SUM(saleprice) AS '판매액'
FROM Orders
GROUP BY custid;


-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가와 고객아이디를 출력하시오.
SELECT custid, 
       SUM(saleprice) AS 총매출,
       AVG(saleprice) AS 평균,
       MIN(saleprice) AS 최소값,
       MAX(saleprice) AS 최대값
FROM Orders
GROUP BY custid;


-- GROUP BY 절 사용시 주의
--  틀린 예
SELECT bookid, SUM(saleprice) -- bookid 속성이 올 수 있는가?
FROM Orders
GROUP BY custid;

-- 수정
SELECT bookid, SUM(saleprice) 
FROM Orders
GROUP BY custid, bookid;		-- bookid 속성 추가


-- 구매 고객이 가격 8000 이상 도서의 주문 수량을 구하는데 단 2권 이상 주문한
--  고객이름, 수량, 판금액을 조회하자.
select	C.USERNAME AS 이름, 
		COUNT(*) AS 수량, 
        SUM(O.saleprice) AS 판매액
FROM Orders O, BOOK B, CUSTOMER C
WHERE saleprice >= 8000
GROUP BY O.custid
HAVING count(*) >= 2;

-- SELECT custid, COUNT(*) 수량
-- FROM	   Orders
-- WHERE   	   saleprice >= 5000
-- GROUP BY	   custid
-- HAVING   	   count(*) >= 2;

    






/*
 * 실습1: 
 */
-- 도서번호가 10인 도서의 이름

-- 도서번호가 1~10 사이: between
-- 도서번호가 1~10 사이 : 비교식

-- 가격이 30,000원 이상인 도서의 이름

-- 가격이 5000원 에서 20000원 미만인 도서의 이름

-- 주문 금액의 총액과 주문의 평균 금액 

-- 2014년 7월 4일~7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호 
