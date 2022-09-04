/*
 * lec9-10
 */
use bookstore;

-- 가격이 22,000원 미만인 도서를 검색하시오.
SELECT	* 
FROM	Book
WHERE	price < 22000;


-- 가격이 10,000 보다 크고 20,000 이하인 도서를 검색하시오.
SELECT	*
FROM	Book
WHERE	price >= 10000 AND price <= 20000;

/*  between */
-- 가격이 10,000에서 20,000 사이인 도서를 검색하시오.
SELECT	*
FROM	Book
WHERE	price BETWEEN 10000 AND 20000;

-- 주문일자가 2014/07/01 에서 2014/07/09 인 주문을 출력
SELECT * FROM bookstore.orders
WHERE orderdate between '2014-07-01' AND '2014-07-09';

--  여러 연산자에 따른 결과
-- 도서번호가 3,4,5,6 인 주문 목록을 출력
SELECT * 
FROM orders
WHERE bookid IN (3,4,5,6);

SELECT * 
FROM orders
WHERE bookid BETWEEN 3 AND 6;

SELECT * 
FROM orders
WHERE bookid > 2 AND bookid <= 6;

-- NULL인 문자열 결합
select concat("전화번호: ", phone ) from customer;

SELECT * FROM BOOK;

-- book의 price가 null인 레코드 추가
INSERT INTO book VALUES(11, 'SQL 기본기 다지기', 'MS출판사', null);

-- 레코드 11번에 price를 1000원 올려서 출력
SELECT price+1000 FROM BOOK WHERE bookid=11;

--  price 컬럼에 집계함수를 실행해 보자.
SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
FROM book;

SELECT    SUM(price), AVG(price), COUNT(*)
FROM     book
WHERE    bookid < 11;

-- NULL인 레코드
SELECT 	*
FROM 	book
WHERE 	price IS NULL;

-- 
SELECT 	*
FROM 	book
WHERE 	price = '';

-- 이름, 전화번호가 포함된 고객목록 조회하고 전화번호가 없는 고객은 ‘연락처없음’으로 표시하자.
SELECT 	name AS '이름', IFNULL(phone, '연락처없음') '전화번호'
FROM 	Customer;




/*
 * Lec10
 */
-- 박씨 성을 가진 고객을 출력하시오.
SELECT name FROM customer WHERE name LIKE '박%';

-- 2번째 글자가 '지'인 고객을 출력하시오.
SELECT name FROM customer WHERE name LIKE '_지%';

-- '철학의 역사'를 출간한 출판사를 검색하시오.
SELECT	bookname, publisher
FROM	Book
WHERE	bookname LIKE '철학의 역사';


-- 질의 도서이름에 '파이썬'가 포함된 출판사를 검색하시오.
SELECT	bookname, publisher
FROM	Book
WHERE	bookname LIKE '%파이썬%';

-- '썬'으로 일치하는 도서 중 가격이 20,000원 이상인 도서를 검색

SELECT	*
FROM	Book
WHERE	bookname LIKE '%썬%' AND price >= 20000;

--  출판사 이름이 ‘정론사’ 혹은 ‘새미디어’인 도서를 검색하시오.
SELECT	*
FROM	Book
WHERE	publisher='정론사'  OR  publisher='새미디어';



/* order by */
-- 도서를 이름순으로 검색하시오.
SELECT	*
FROM	Book
ORDER BY	bookname;

-- 질의)  도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색
SELECT	*
FROM	Book
ORDER BY	price, bookname; 

-- 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름 차순으로 검색한다.
SELECT	*
FROM	Book
ORDER BY	price DESC, publisher ASC;

-- 주문일자를 내림차순으로 정렬하시오 
SELECT	*
FROM	orders
ORDER BY orderdate DESC;


SELECT	*
FROM	Book
WHERE	bookname LIKE '%썬%' AND price < 20000
ORDER BY publisher DESC;


SELECT * FROM orders WHERE saleprice > 1000
ORDER BY bookid;

-- book 테이블 컬럼번호
SELECT	*
FROM	Book
ORDER BY 1, 3; 


/*
 * IF, CASE
 */
 
SELECT IF (100 > 300, '크다', '작다');


SELECT 
CASE 100 
	  WHEN 10 THEN '십'
	  WHEN 50 THEN '오십' 
	  WHEN 100 THEN '일백' 
      ELSE '기타'
END
AS '결과';

