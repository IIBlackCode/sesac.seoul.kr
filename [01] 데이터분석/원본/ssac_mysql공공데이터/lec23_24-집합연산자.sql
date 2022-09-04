/**
 * 23차시/24차시  실습
 *  조인과 집합 연산자 사용하기
 */
 use bookstore;

/* 집합연산자 */

-- UNION
-- 도서 주문에서 고객 주소가 서울인 고객의 이름, 전화번호를 출력하자. 

-- 1.
SELECT	username, phone
FROM	Customer
WHERE 	address LIKE '%서울%';

-- 2.
SELECT	username, phone
FROM	Customer
WHERE	custid IN (SELECT custid FROM Orders);


SELECT	username, phone
FROM	Customer
WHERE 	address LIKE '%서울%'

UNION  

SELECT	username, phone
FROM	Customer
WHERE	custid IN (SELECT custid FROM Orders);



-- 도서 주문에서 주소가 대한민국이 있는 고객의 이름, 전화번호를 출력하자. 
-- 단, 전화번호가 없는 경우 '전화없음' 표시를 하자.
SELECT	username, IFNULL(phone, '전화없음')
FROM	Customer
WHERE 	address LIKE '대한민국%'

UNION  

SELECT	username, IFNULL(phone, '전화없음')
FROM	Customer
WHERE	custid IN (SELECT custid FROM Orders);



/* IN */

-- 주문 테이블에 40000 이상 주문한 고객의 이름, 주소와 책 제목을 출력하시오.

-- 1
SELECT custid FROM  Orders WHERE saleprice > 40000;

-- 2
SELECT * FROM Customer;

-- 주문 테이블에 25000 이상 주문한 고객의 이름, 주소와 책 제목을 출력하시오.
SELECT 	C.username, C.address, B.bookname
FROM 	Customer C, Book B
WHERE C.custid IN (SELECT custid
	           FROM  Orders WHERE saleprice > 40000);


/* MINUS 대체, NOT IN */
--  대한민국 거주 고객의 이름에서 도서를 주문 고객의 이름 제외하고 출력.
-- 주문과 고객 테이블에서 도서를 주문하지 않은 고객만 조회하자 

SELECT	username
FROM	Customer
WHERE address LIKE '대한민국%' 
AND username NOT IN (SELECT	username
					FROM	Customer
					WHERE	custid IN (SELECT custid FROM Orders));

/* INTERSECT 대체, IN */
SELECT	username
FROM	Customer
WHERE address LIKE '대한민국%' 
AND username IN (SELECT username
				FROM	Customer
				WHERE	custid IN (SELECT custid FROM Orders));




/* 02. 다중행 연산자 */

--  "예" 주문 테이블에서 40000 이상 주문한 고객의 이름, 주소와 책 제목을 조회.
SELECT 	C.username, C.address, B.bookname
FROM 	Customer C, Book B
WHERE cs.custid IN (SELECT custid
                   FROM  Orders
                   WHERE saleprice > 40000);



/* EXIST */
--  "예" 주문이 있는 고객의 이름, 주소 정보를 출력하자.
-- 1
SELECT *
FROM  Orders O, Customer C
WHERE C.custid = O.custid;

-- f               
SELECT 	username, address
FROM 	Customer C
WHERE 	EXISTS (SELECT *
	           FROM  Orders O
	           WHERE C.custid = O.custid);



/* ALL */
-- 주문일자가 2021-02-05 이전 주문 금액보다 비싼 모든 도서를 출력하시오.
SELECT bookid FROM orders
WHERE orderdate < '2021-02-05';

-- all
SELECT bookname, publisher, price FROM BOOK 
WHERE price > ALL (SELECT bookid FROM orders
		                  WHERE orderdate < '2021-02-05');


/* ANY */
-- 메인쿼리
SELECT bookname, price FROM book;

-- "예" 주문 테이블에서 주문가격이 5000 에서 20000 사이 도서의 도서 이름, 도서 가격을 조회하자.
-- 1
SELECT saleprice
FROM ORDERS 
WHERE saleprice between 5000 and 20000;

-- f                   
SELECT bookname, price 
FROM BOOK
WHERE price = ANY (SELECT saleprice 
                   FROM ORDERS 
                   WHERE saleprice between 5000 and 20000);
