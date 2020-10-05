SELECT gb,sido,sigungu
FROM fastfood;
WHERE SIDO = '대전광역시'
AND sigungu = '중구';

-- 도시발전지수 : (버거킹 + 맥도날드 + kfc)/롯데리아

SELECT count(gb)
FROM fastfood
WHERE sido= '강원도'
AND sigungu = '강릉시'
AND gb = '맥도날드';

SELECT count(gb)
FROM fastfood
WHERE sido= '강원도'
AND sigungu = '강릉시'
AND gb = '롯데리아';

SELECT count(gb)
FROM fastfood
WHERE sido= '강원도'
AND sigungu = '강릉시'
AND gb = 'KFC';

SELECT count(gb)
FROM fastfood
WHERE sido= '강원도'
AND sigungu = '강릉시'
AND gb = 'KFC';

--풀이--

SELECT a.sido, a.sigungu, a.cnt, b.cnt, ROUND(a.cnt/b.cnt, 2) di
FROM
(SELECT sido, sigungu, COUNT(*) cnt
 FROM fastfood
 WHERE gb IN ( 'KFC', '맥도날드', '버거킹')
 GROUP BY sido, sigungu) a,

(SELECT sido, sigungu, COUNT(*) cnt
 FROM fastfood
 WHERE gb = '롯데리아'
 GROUP BY sido, sigungu) b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY di DESC;



테이블 한번만 읽고 풀기
SELECT sido, sigungu, 
        ROUND((NVL(SUM(DECODE(gb, 'KFC', cnt)), 0) +       
        NVL(SUM(DECODE(gb, '버거킹', cnt)), 0) +
        NVL(SUM(DECODE(gb, '맥도날드', cnt)), 0) ) /        
        NVL(SUM(DECODE(gb, '롯데리아', cnt)), 1), 2) di 
FROM 
(SELECT sido, sigungu, gb, COUNT(*) cnt
 FROM fastfood
 WHERE gb IN ('KFC', '롯데리아', '버거킹', '맥도날드')
 GROUP BY sido, sigungu, gb)
GROUP BY sido, sigungu 
ORDER BY di DESC;

KFC - 66 롯데리아 - 188 버거킹- 104 맥도날드- 126

SELECT a.sido, a.sigungu, a.cnt , b.cnt, a.cnt
FROM
(SELECT sido, sigungu, COUNT(*)cnt
    FROM fastfood
WHERE gb IN('KFC', '맥도날드', '버거킹')
GROUP BY sido,sigungu) a,


SELECT a.sido, a.sigungu, a.cnt , b.cnt l, round(a.cnt/ b.cnt, 2) point
FROM
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE  gb IN('버거킹','맥도날드','KFC')
GROUP BY sido, sigungu) a,
(SELECT sido, sigungu, COUNT(*) cnt
FROM fastfood
WHERE  '롯데리아'
GROUP BY sido, sigungu) b
WHERE a.sido = b.sido 
AND a.sigungu = b.sigungu
ORDER BY point desc;



SELECT sido, sigungu,
   ROUND((NVL(SUM(DECODE(gb, 'KFC', cnt)),0) +
    NVL(SUM(DECODE(gb, '버거킹', cnt)),0) +
    NVL(SUM(DECODE(gb, '맥도날드', cnt)),0) /
    NVL(SUM(DECODE(gb, '롯데리아', cnt)),1),2) di
FROM
(SELECT sido, sigungu,gb, COUNT(*)cnt
FROM fastfood
WHERE gb IN ('KFC', '롯데리아','버거킹','맥도날드')
GROUP BY sido, sigungu, gb)
GROUP BY sido, sigungu
ORDER BY sido, sigungu, gb;

SELECT sido, sigungu, ROUND(sal/people) p_sal
FROM tax
ORDER BY p_sal DESC;

도시발전지수 1 - 세금1위
도시발전지수 2 - 세금2위
도시발전지수 3 - 세금3위

DML : Date Manipulate Language
1. SELECT : *****************
2. INSERT : 테이블에 새로운 데이터를 입력하는 명령             
3. UPDATE :                 데이터의 컬럼을 변경
4. DELETE :                 데이터(행)을 삭제

INSERT의 3가지
테이블의 특정 컬럼에만 데이터를 입력할 때 (입력되지 않은 컬럼은 NULL로 설정 된다.)
INSERT INTO 테이블명 (컬럼1, 컬럼2...) VALUES (컬럼1의 값 1, 컬럼 2의 값2...);
DESC emp;

INSERT INTO emp (empno, ename) VALUES (9999, 'brown');
SELECT *
FROM emp
WHERE empno = 9999;

empno컬럼의 설정이 not null이기 때문에 empno컬럼에 null값이 들어갈 수 없어서 에러가 발생
INSERT INTO emp (ename) VALUES ('sally');

2.테이블의 모든 컬럼에 모든 데이터를 입력할 때
 *** 단 값을 나열하는 순서는 테이블의 정의된 컬럼 순서대로 기술 해야한다
    테이블 컬럼 순서 확인 방법 : DESC 테이블명
INSERT INTO 테이블명 VALUES (컬럼 1의 값1, 컬럼2의 값2...);

DESC dept;

컬럼을 기술하지 않았기 때문에 테이블에 정의된 모든 컬럼에 대해 값을 기술해야하나
3개중 2개만 기술하여 에러 발생
INSERT INTO dept VALUES( 97, 'DDIT');
SELECT *
FROM dept;

3. SELECT 결과를 (여러행일 수도 있다) 테이블에 입력
INSERT INTO 테이블명 [(col,...)]
SELECT 구문;

INSERT INTO emp (empno, ename)
SELECT 9997, 'cony' FROM dual
UNION ALL
SELECT 9996, 'moon' FROM dual;

SELECT *
FROM emp;

날짜 컬럼 값 입력하기
INSERT INTO emp VALUES (9996, 'james', 'CLERK', NULL, SYSDATE, 3000, NULL,NULL);

'2020/09/01' --무결성 제약조건을 생성하지 않아서 행이 삽입됨(같은 내용인데 날짜만 다름)
INSERT INTO emp VALUES (9996, 'james', 'CLERK', NULL, 
                        TO_DATE('2020/09/01', 'YYYY/MM/DD'), 3000, NULL,NULL);
SELECT *
FROM emp;

UPDATE : 테이블에 존재하는 데이터를 수정
            1. 어떤 데이터를 수정할지 데이터를 한정 (WHERE)
            2. 어떤 컬럼에 어떤 값을 넣을지 기술
            
UPDATE 테이블명 SET 변경할 컬럼명 = 수정할 값 [, 변경할 컬럼명, 수정할 값....]
[WHERE] 
99 ddit daejeon
dept 테이블의 deptno 컬럼의 값이 99번인 데이터의 DNAME컬럼을 대문자 DDIT로, LOC컬럼을 한글
'영민'으로 변경

UPDATE dept SET dname = 'DDIT', loc= '영민'
WHERE deptno = 99;


SELECT *
FROM dept;

UPDATE dept SET dname = 'DDIT', loc= '영민';

ROLLBACK;

SELECT *
FROM emp;
