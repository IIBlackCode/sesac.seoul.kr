/*
 * lec11
 * distinct
 */
use bookstore;


-- 주문 고객목록
select distinct custid from orders;

-- 판매가격 목록
SELECT DISTINCT saleprice FROM orders;

-- 주문이 있는 고객의 숫자
SELECT count(DISTINCT custid) FROM orders;


-- 다중조건 CASE
SELECT custid, SUM(saleprice) AS '총구매액', 
       CASE 
          WHEN (saleprice >= 15000) THEN '최우수고객'
          WHEN (saleprice  >= 10000) THEN '우수고객'
          WHEN (saleprice  >= 5000 ) THEN '일반고객'
          ELSE '유령고객'
       END AS '고객등급'
    FROM Orders O
ROUP BY custid;
    
