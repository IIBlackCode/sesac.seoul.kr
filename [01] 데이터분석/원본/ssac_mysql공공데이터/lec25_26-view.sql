/**
 * 25차시/26차시  실습
 *  조인과 집합 연산자 사용하기
 */
 use bookstore;

/** 레코드를 몇개 더 추가 하자 **/
INSERT INTO Book VALUES(12, 'OpenCV 파이썬', '포웨이', 23500);
INSERT INTO Book VALUES(13, '자연어 처리 시작하기', '투시즌', 20000);
INSERT INTO Book VALUES(14, 'SQL 이해', '새미디어', 22000);

INSERT INTO Customer VALUES (6, '박보영', '서울 서초구', '010-8214-9010');
INSERT INTO Customer VALUES (7, '오정세', '서울 중구', '010-5190-1090');
INSERT INTO Customer VALUES (8, '이병헌', '서울 성북구', NULL);

INSERT INTO Orders VALUES (11, 6, 12, 23500, STR_TO_DATE('2020-02-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (12, 6, 14, 44000, STR_TO_DATE('2020-02-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (13, 8, 13, 20000, STR_TO_DATE('2020-02-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (14, 3, 13, 20000, STR_TO_DATE('2020-02-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (15, 4, 12, 23500, STR_TO_DATE('2020-02-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (16, 5, 8, 35000, STR_TO_DATE('2020-02-07','%Y-%m-%d'));

SELECT * FROM BOOK WHERE BOOKID IN (12,13,14);

/*
-- 새로 추가한 레코드 삭제시
SET SQL_SAFE_UPDATES=0;  --safe-update option

DELETE FROM BOOK WHERE BOOKID IN (12,13,14);
DELETE FROM CUSTOMER WHERE BOOKID IN (6,7,8);
DELETE FROM ORDERS WHERE BOOKID IN (11,12,13,14,15,16);

SET SQL_SAFE_UPDATES=1; -- safe-update option
*/



/* View 이해하고 사용하기 */

CREATE VIEW v_orders
AS SELECT orderid, O.custid, username, O.bookid, saleprice, orderdate
   FROM Customer C, Orders O, Book B
   WHERE C.custid = O.custid and B.bookid = O.bookid;

SELECT * FROM V_ORDERS;   

-- 도서 가격이 20000이상인 레코드로 변경
CREATE OR REPLACE VIEW v_orders(custid, username, address)
AS SELECT C.custid, username, address
   FROM Customer C, Orders O, Book B
   WHERE B.price > 20000;

SELECT * FROM V_ORDERS;   

-- 고객 구매 뷰
CREATE OR REPLACE VIEW  V_CUST_PURCHASE
AS
SELECT C.USERNAME AS 고객, SUM(O.SALEPRICE) 구매액
FROM CUSTOMER C, ORDERS O
WHERE C.CUSTID = O.CUSTID
GROUP BY 고객
ORDER BY 구매액 DESC
;

SELECT * FROM V_CUST_PURCHASE;


-- 구매 고객의 매출 순위
SELECT 	고객, 
		RANK() OVER(ORDER BY 구매액 DESC) AS '매출순위'
FROM V_CUST_PURCHASE
;



-- 뷰 삭제
DROP VIEW V_ORDERS;
DROP VIEW V_CUST_PURCHASE;

