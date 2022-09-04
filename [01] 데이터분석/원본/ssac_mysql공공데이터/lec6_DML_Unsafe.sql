/* lec6 - 스키마 생성하기 */

/* 01 - DML 확장실습 */
CREATE TABLE BookLibrary (
  bookid	INTEGER, 
  bookname	VARCHAR(20),
  publisher	VARCHAR(20),
  price		INTEGER
);


/*  "실습": 기본 값 지정 */
CREATE TABLE  BookLibrary (
bookname     	VARCHAR(20) 	NOT NULL,
publisher      	VARCHAR(20) 	UNIQUE,
price 	     	INTEGER 	DEFAULT 10000 CHECK(price > 5000),
PRIMARY KEY	(bookname, publisher)
);



/* safe-update option */
SET SQL_SAFE_UPDATES=0;

delete from bookstore.book ;



/* ALTER */
--  실습용 BookLibrary  테이블을 생성한다.

CREATE TABLE BookLibrary (
 bookid 	  INTEGER,
 bookname  VARCHAR(20),
 publisher 	  VARCHAR(20),
 price 	  INTEGER
 );
desc booklibrary;

-- BookLibrary 테이블에 VARCHAR(30)의 자료형을 가진 inventory 속성을 추가하시오.
ALTER TABLE BookLibrary ADD inventory VARCHAR(30);

-- BookLibrary 테이블의 isbn 속성의 데이터 타입을 INTEGER형으로 변경하시오.
ALTER TABLE BookLibrary MODIFY inventory  INTEGER;

-- BookLibrary 테이블의 isbn 속성을 삭제하시오.
ALTER TABLE BookLibrary DROP COLUMN inventory;
-- ALTER TABLE BookLibrary DROP inventory; -- 동일

-- BookLibrary 테이블의 bookid 속성에 NOT NULL 제약조건을 적용하시오.
ALTER TABLE BookLibrary MODIFY bookid INTEGER NOT NULL;

-- BookLibrary 테이블의 bookid 속성을 기본키로 변경하시오.
ALTER TABLE BookLibrary ADD PRIMARY KEY(bookid);

-- BookLibrary 테이블의 기본키로 제거
ALTER TABLE BookLibrary DROP PRIMARY KEY;

--
DROP TABLE BookLibrary;