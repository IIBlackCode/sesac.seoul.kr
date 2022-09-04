/**
 * 17, 18차시  실습
 */
 
/* 01. 서브쿼리 */

-- 새 테이블에서 테스트
use lecture;

drop table product;

# 샘플 테이블과 데이터
create table product(
	code int,
	name varchar(20),
	price int
);

INSERT INTO product VALUES(1, '녹차', 2300);
INSERT INTO product VALUES(2, '홍차', 3000);
INSERT INTO product VALUES(3, '유자차', 1800);
INSERT INTO product VALUES(4, '보리차', 2500);

SELECT * FROM product;


-- 아래는 집계는 하나의 스칼라 값이고 나머지 칼럼은 여러 행이라서 에러 발생.
-- Invalid use of group function
SELECT * FROM product
WHERE AVG(price) > 1000;

SELECT AVG(price)  
FROM product;  


-- 서브쿼리
-- 제품 판매 가격이 평균보다 큰 제품은?
SELECT * FROM product
WHERE price >= (SELECT avg(price) FROM product);


SELECT code, min(price) 
FROM product
GROUP BY name
HAVING min(price) < (select avg(price) from product);

SELECT * FROM product WHERE price >= 2500;


-- INLINE VIEW
-- subquery 결과를 from 에 사용
SELECT min(price) -- subquery - from
FROM (SELECT * FROM product where price >= 2000) as c_price ;


--
-- SAFE UPDATES 
SET SQL_SAFE_UPDATES=1; /* Safe Updates 옵션 기본값*/
update product set price = 3000;
delete from product;

-- SAFE UPDATES 해제
SET SQL_SAFE_UPDATES=0; /* Safe Updates 옵션 해제*/
update product set price = 3000;

-- 모든 레코드 삭제
delete from product;

DROP TABLE PRODUCT;




-- 상관부속질의

USE BOOKSTORE;

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT 	b1.bookname
FROM 	Book b1
WHERE 	b1.price > (SELECT avg(b2.price)
           		FROM 	Book b2
          		WHERE 	b2.publisher=b1.publisher);


-- 주문한 내용에서 도서의 가격과 판매가격의 차이가 가장 많은 주문 
-- 1.
SELECT MAX(price-saleprice)
FROM Book B, Orders O
WHERE B.bookid=O.bookid;

-- 결과
SELECT *
FROM Book B, Orders O
WHERE B.bookid=B.bookid
AND B.price-O.saleprice = ( SELECT MAX(price-saleprice)
							FROM Book, Orders
							WHERE Book.bookid=Orders.bookid);
                            
-- 1권 이상 구매한 구매한 도서
SELECT DISTINCT B.BOOKNAME, B.PRICE
FROM Book B, Orders O
WHERE B.bookid=B.bookid
AND O.saleprice<>B.price;

