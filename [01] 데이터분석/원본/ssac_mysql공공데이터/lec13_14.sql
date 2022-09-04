/*
 * lec13,14
 */
use bookstore;


-- TRIM() - 문자열 좌우 공백 제거
SELECT TRIM(' 안녕하세요 ');

-- 문자열 좌우 문자 제거 (BOTH)
SELECT TRIM(BOTH '안' FROM '안녕하세요안');

-- 문자열 좌측 공백 제거 (LEADING)
SELECT TRIM(LEADING FROM ' 안녕하세요 ');

-- 문자열 좌측 문자 제거 (LEADING)
SELECT TRIM(LEADING '안' FROM '안녕하세요안');

-- 문자열 우측 공백 제거 (TRAILING)
SELECT TRIM(TRAILING FROM ' 안녕하세요 ');

-- 문자열 우측 문자 제거 (TRAILING)\
SELECT TRIM(TRAILING '요' FROM '요안녕하세요');

-- LTRIM
SELECT LTRIM(' 안녕하세요 ');

-- RLTRIM
SELECT RTRIM(' 안녕하세요 ');


SELECT LENGTH('Hello');
SELECT CHAR_LENGTH('Hello');
SELECT CHAR_LENGTH('Hello');
SELECT CHARACTER_LENGTH('Hello');

SELECT LENGTH('안녕');
SELECT CHAR_LENGTH('안녕');
SELECT CHARACTER_LENGTH('안녕');


/* 대소문자 */
SELECT UPPER('sql로 시작하는 하루');
SELECT UPPER('A에서 z까지 !');
SELECT LOWER('A에서 z까지 !');

SELECT LOWER(bookname) FROM book;


/* 추출 */

-- 안녕하세요 문자열에서 2~3 번 인덱스 문자를 추출
select substring('안녕하세요', 2,3);

-- 안.녕.하.세.요 문자열에서 . 를 만난후 2번째 까지 
select substring_index('안.녕.하.세.요', '.', 2);
-- 안.녕.하.세.요 문자열에서 . 를 만난후 뒤에서 -3번째 까지 
select substring_index('안.녕.하.세.요', '.', -3);


SELECT LEFT('안녕하세요', 3);

SELECT RIGHT('안녕하세요', 3);


/* 결합 */
SELECT  concat('홍길동', '모험');
SELECT  concat_ws(',', '홍길동', '모험');
SELECT  '홍길동','모험';

SELECT CONCAT_WS(":", bookname, publisher) FROM book;
SELECT bookname, ":", publisher FROM book;

-- customer 의 name과 phone을 ':' 로 묶어 보자
SELECT GROUP_CONCAT(name, ":", phone) AS "전화" FROM customer;
SELECT concat_ws(':', name, phone) AS '전화' FROM customer;

