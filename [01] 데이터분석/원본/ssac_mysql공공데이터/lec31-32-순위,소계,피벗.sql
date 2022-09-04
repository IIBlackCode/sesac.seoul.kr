/*
 * 31차시
 */
USE BOOKSTORE;

/* 순위 */
-- 대여비용의 랭킹


/* 순위 */

-- 대여비용의 랭킹

-- 도서 주문 가격별 랭킹

SELECT B.bookname
	, RANK() OVER (ORDER BY O.SALEPRICE) AS RANKING 
FROM BOOK B, ORDERS O
WHERE B.BOOKID=O.BOOKID
GROUP BY 1;

-- 도서 주문 가격별 랭킹: DENSE_RANK
SELECT B.bookname, DENSE_RANK() OVER (ORDER BY O.SALEPRICE) AS RANKING 
FROM BOOK B, ORDERS O
WHERE B.BOOKID=O.BOOKID
GROUP BY 1;

-- 도서 주문 가격별 랭킹: ROW_NUMBER
SELECT B.bookname, ROW_NUMBER() OVER (ORDER BY O.SALEPRICE) AS RANKING 
FROM BOOK B, ORDERS O
WHERE B.BOOKID=O.BOOKID
GROUP BY 1;


-- 주문 가격별 고객의 랭킹

SELECT 	B.bookname, 
		-- O.CUSTID,
		ROW_NUMBER () OVER (PARTITION BY O.CUSTID ORDER BY O.SALEPRICE) AS RANKING 
FROM BOOK B, ORDERS O
WHERE B.BOOKID=O.BOOKID
GROUP BY 1;




/*
 * 롤업 : 소계
 */

/* MYSQL 안됨.
-- 방법1 : GROUP BY ROLLUP(그룹컬럼)
SELECT BOOKID, CUSTID, SUM(SALEPRICE) AS 판매액
FROM ORDERS
WHERE BOOKID IN (2,3,4)
GROUP BY ROLLUP(BOOKID, ORDERDATE); */

 
--  "예" 지역별로 판매된 도서의 수량을 조회하자.
 
-- 방법1 : GROUP BY 그룹컬럼 WITH ROLLUP
-- 지역중심으로 집계
SELECT SUBSTRING(address, 1, 12) as 지역,
		bookname, 
        COUNT(*) 수량
FROM Customer C, Book B, Orders O
WHERE O.bookid = B.bookid AND C.custid = O.custid
GROUP BY address WITH ROLLUP
ORDER BY username ASC, bookname DESC;


-- 밥업2 : Having IS NOT NULL 로 
SELECT  SUBSTRING(address, 1, 12) as 지역,
		bookname, 
        COUNT(*) 수량
FROM Customer C, Book B, Orders O
WHERE O.bookid = B.bookid AND C.custid = O.custid
GROUP BY address WITH ROLLUP
HAVING address IS NOT NULL
ORDER BY username ASC, bookname DESC;

--  GROUP BY 구문에 제시된 컬럼에 따라 결과는 달라질 수 있다.
SELECT  SUBSTRING(address, 1, 12) as 지역,
        Bookname, 
        COUNT(*) 수량
FROM Customer C, Book B, Orders O
WHERE O.bookid = B.bookid AND C.custid = O.custid
GROUP BY address, bookname WITH ROLLUP
HAVING address IS NOT NULL
ORDER BY username ASC, bookname DESC;
