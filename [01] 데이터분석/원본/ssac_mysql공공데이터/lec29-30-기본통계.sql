/*
 * 30차시 실습
 */
use bookstore;

-- 기본통계

--  고객의 전체 주문횟수, 합계, 평균, 최소/최대 구매액을 조회하자. 
SELECT 	C.USERNAME 이름, 
		COUNT(*) 주문량, 
		FORMAT(SUM(SALEPRICE),0) 합계, 
		FORMAT(AVG(SALEPRICE), 1) 평균, 
		MAX(SALEPRICE) 최대, 
        MIN(SALEPRICE) 최소
FROM ORDERS O
	LEFT JOIN CUSTOMER C
		ON O.CUSTID = C.CUSTID
GROUP BY 이름;


--  년도별 주문량, 주문 합계, 평균, 최대 및 최소 값을 계산하자.
SELECT 	YEAR(ORDERDATE) 년도,
		COUNT(*) 주문량, 
		FORMAT(SUM(SALEPRICE),0) 합계, 
		FORMAT(AVG(SALEPRICE), 1) 평균, 
		MAX(SALEPRICE) 최대, 
        MIN(SALEPRICE) 최소
FROM ORDERS O
LEFT JOIN CUSTOMER C
ON O.CUSTID = C.CUSTID
GROUP BY 1;


-- 주문 금액의 합계, 평균, 최소, 최대, 분산, 표준편차
SELECT SUM(SALEPRICE) 합계, 
		FORMAT(AVG(SALEPRICE), 1) 평균, 
		MAX(SALEPRICE) 최대, 
        MIN(SALEPRICE) 최소,
        FORMAT(VARIANCE(SALEPRICE),1) 분산,
        FORMAT(STD(SALEPRICE),1) 표준편차
FROM ORDERS;



/* 사분위수 
 - GROUP_CONCAT 함수로 데이터를 합쳐서 분위수에 해당하는 수치를 구해 SUBSTRING_INDEX함수로 데이터를 추출하는 방법이다. 
 - 합쳐지는 데이터가 많을 경우 꼭 SET GROUP_CONCAT_MAX_LEN = 10485760; 와 같은 설정이 필요함
*/

/* 가격 개수를 이용한 사분위수 */
-- 1단계: 
-- group_concat(name [separator][order by]) : 컬럼 결과를 한 줄로 결합
SELECT publisher, GROUP_CONCAT(bookname SEPARATOR ':')
FROM book
GROUP BY publisher;

-- 2단계: 
-- 모든 가격을 결합한다.
SELECT GROUP_CONCAT(saleprice ORDER BY saleprice SEPARATOR ',')
FROM Orders;


-- 3단계: 전체 레코드 수를 25%~100% 까지 계산해 본다.
SELECT 25/100 * COUNT(saleprice) + 1 AS '25%',
 50/100 * COUNT(saleprice) + 1 AS '50%',
 70/100 * COUNT(saleprice) + 1 AS '75%',
 MAX(saleprice) AS 'MAX'
FROM Orders;

-- 4단계: 
-- substring_index(str, delim, count)
-- 문자열 str 을 delim 로 구분해서 배열로 만든 후 count 만큼만 보여준다.
-- count 가 양수이면 왼쪽에서 count 수만큼 보여주고 음수이면 오른쪽에서 count 수 만큼 보여준다.
select substring_index('www.mysql.com', '.', 1); -- 'www'
select substring_index('www.mysql.com', '.', -1); -- 'com' 


-- 5단계: FINAL
-- 합쳐지는 데이터가 많을 경우 꼭 SET GROUP_CONCAT_MAX_LEN = 10485760; 와 같은 설정이 필요함
-- SET GROUP_CONCAT_MAX_LEN = 10485760; 
SELECT 	MIN(saleprice) AS 'MIN',
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(saleprice ORDER BY saleprice SEPARATOR ','),',', 25/100 * COUNT(*) + 1), ',', -1) AS `25%`,
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(saleprice ORDER BY saleprice SEPARATOR ','),',', 50/100 * COUNT(*) + 1), ',', -1) AS `50%`,
        AVG(saleprice) AS 'MEAN', 
        SUBSTRING_INDEX(SUBSTRING_INDEX(GROUP_CONCAT(saleprice ORDER BY saleprice SEPARATOR ','),',', 75/100 * COUNT(*) + 1), ',', -1) AS `75%`, 
        MAX(saleprice) AS 'MAX'
FROM Orders;





/* 전체 가격 범위는 판매가를 합산 가격으로 계산해 사분위 범위 */
SELECT MIN(saleprice) AS 'MIN',
 FORMAT(25/100 * SUM(saleprice), 1) AS '25%',
 FORMAT(50/100 * SUM(saleprice), 1) AS '50%',
 FORMAT(AVG(saleprice),1 ) AS 'MEAN', 
 FORMAT(70/100 * SUM(saleprice), 1) AS '75%',
 MAX(saleprice) AS 'MAX'
FROM Orders;




