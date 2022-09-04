/**
 * 21차시/22차시  실습
 * - 테이블 관계 조인(INNER, OUTER)  이해하기
 
 * 추가로 참고: https://futurists.tistory.com/17
 */

USE bookstore;

/* 조인 */
-- 두 테이블에서 조회
SELECT *
FROM CUSTOMER, ORDERS;

-- 세 테이블에서 조회
SELECT	*
FROM Book, CUSTOMER, ORDERS;


-- 일반조인: 동등조인, INNER JOIN

--  조건문과 정렬을 함께 사용해 보자.
-- 고객 이름, 고객 주문 도서의 판매 가격을 출력
SELECT username, saleprice
FROM CUSTOMER C, ORDERS O
WHERE C.custid = O.custid;

-- INNER JOIN
SELECT username, saleprice
FROM CUSTOMER C
JOIN ORDERS O
ON C.custid = O.custid;



-- 도서 가격이 20000원인 이상인 도서를 주문한 고객의 이름, 주문 도서 이름을 출력
SELECT C.username AS '이름', B.bookname AS '도서명'
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.custid = O.custid
	AND O.bookid = B.bookid
    AND B.price >= 20000;
;



--  GROUP 을 함께 사용할 수 있다.
-- 고객 별로 주문 도서의 총 판매액, 고객이름을 주문일자로 정렬
SELECT username, SUM(saleprice)
FROM CUSTOMER C, ORDERS O
WHERE C.custid = O.custid
GROUP BY C.username
ORDER BY O.orderdate
;


-- 고개의 이름, 주문 도서 이름을 출력.
SELECT C.username as '이름', B.bookname AS '도서명'
FROM CUSTOMER C, ORDERS O, BOOK B
WHERE C.custid = O.custid
AND O.bookid = B.bookid
;


-- 외부조인
-- 도서를 구매하지 않은 고객을 포함해 고객 이름/전화번호 와 주문 도서의 판매 가격을 출력
SELECT username, ORDERS.saleprice
FROM CUSTOMER 
	LEFT OUTER JOIN ORDERS
	ON CUSTOMER.custid = ORDERS.custid;


/* Cross Join */
-- 상호 존재하는 행을 모두 반환,  많은쪽 행 수 만큼 반환
SELECT count(*) FROM ORDERS;
SELECT count(*) FROM customer;


-- 도서를 구매한 이력이 있는 고객 이름, 판매 도서의 가격을 출력하세요.

SELECT	Customer.username, saleprice, orderdate
FROM  Customer
CROSS JOIN ORDERS 
	ON Customer.custid = ORDERS.custid;
                 




/* 실습2: 조인 */


-- 추신수와 김연아의 총 구매액
    
-- 박지성이 구매한 도서의 출판사 수

-- 고객별 구매액으로 고객 이름 구매액으로 출력
