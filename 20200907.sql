
(11번)
SELECT *
FROM emp
WHERE job IN 'SALESMAN'
OR hiredate >=TO_DATE('1981/06/01','yyyy/mm/dd');

(12번)
SELECT *
FROM emp
WHERE job IN 'SALESMAN'
OR empno LIKE '78%';

(13번)
SELECT *
FROM emp
WHERE (empno BETWEEN 7800 AND 7899
OR empno BETWEEN 780 AND 789
OR empno BETWEEN 78 AND 78)
OR job IN 'SALESMAN';

SELECT *
FROM emp
WHERE job = 'SALESMAN'
OR(empno BETWEEN 7800 AND 7899
OR empno BETWEEN 780 AND 789
OR empno BETWEEN 78 AND 78);


(14번)
SELECT *
FROM emp
WHERE job IN 'SALESMAN'
or hiredate >=TO_DATE('1981/06/01','yyyy/mm/dd')
AND empno like '78%';


ROWNUM : 1부터 읽어야 된다
        SELSECT절이 ORDER BY 절보다 먼저 실행된다
        => ROWNUM을 이용하여 순서를 부여하려면 정렬부터 해야한다.
          => 인라인뷰 (ORDER BY - ROWNUM을 분리)
          
실습 ROW_1
SELECT ROWNUM rn, empno, ename
FROM emp
WHERE ROWNUM BETWEEN 1 AND 10; 또는 WHERE ROWNUM <=10;

실습 ROW_2

SELECT *
FROM(SELECT ROWNUM rn, empno, ename
    FROM emp)
WHERE rn >= 11 AND rn <= 20; 

실습 ROW_3 
1. ORDER BY ename ASC;
2. 페이지 사이즈 : 11~20(페이지당 10건)

SELECT *     
FROM
(SELECT ROWNUM rn, empno, ename
FROM
(SELECT empno, ename
FROM emp
ORDER BY ename ASC))
WHERE rn > 10 AND rn <= 20;


방법 1
SELECT *
FROM(SELECT ROWNUM rn, empno, ename
    FROM emp)
WHERE rn >= 11 AND rn <= 14; 

방법2
SELECT *
FROM(SELECT ROWNUM rn, empno, ename
    FROM emp)
WHERE rn BETWEEN 11 AND 14;

SELECT *
FROM(SELECT ROWNUM rn, a.*
    FROM    
        (SELECT ROWNUM, empno, ename
        FROM emp
        ORDER BY ename) a)
WHERE rn BETWEEN 11 AND 14;

SELECT dummy
FROM dual;

ORACLE 함수 분류
***1. SINGLE ROW FUNCTION : 단일 행을 작업의 기준, 결과도 한건 반환
2. MULTI ROW ROW FUNCTION : 여러 행을 작업의 기준, 하나의 행을 결과로 반환

dual 테이블
1. sys계정에 존재하는 누구나 사용할 수 있는 테이블
2. 테이블에는 하나의 컬럼, dummy 존재, 값은 x
3. 하나의 행만 존재
****SINGLE

SELECT empno, ename, LENGTH('hello')
FROM emp;

SELECT LENGTH('hello')
FROM dual

방법 1(잘못된 방법 : SQL 칠거지악)
좌변을 가공하지 말아라 (테이블 컬럼에 함수를 사용하지 말것)
 * 함수 실행 횟수
 * 인덱스 사용관련 (추후에)
SELECT ename, LOWER(ename)
FROM emp
WHERE LOWER(ename) = 'smith';

방법 2
SELECT ename, LOWER(ename)
FROM emp
WHERE ename = UPPER('smith');

방법 3 (가장 이상적)
SELECT ename, LOWER(ename)
FROM emp
WHERE ename = 'SMITH';  

문자열 관련 함수
SELECT CONCAT('Hello', ', World') concat,
        SUBSTR('Hello, World', 1, 5) substr, -- 1~5까지
        SUBSTR('Hello, World', 5) substr2, 
        LENGTH('Hello, World') length, -- 문자열의 길이
        INSTR('Hello, World', 'o')instr, -- 첫번째로 등장하는 인덱스
        INSTR('Hello, World', 'o',INSTR('Hello, World', 'o')+1 )instr3,
        LPAD('Hello, World', 15, '*') lpad, -- 문자열, 전체길이, 부족한 길이만큼 채울 문자
        LPAD('Hello, World', 15, '*') lpad2,
        RPAD('Hello, World', 15, '*') rpad, -- 문자열, 전체길이
        REPLACE('Hello, World', 'Hello', 'Hell') replace,
        TRIM('Hello, World') trim, -- 문자열 앞뒤로 공백 제거
        TRIM('   Hello, World    ') trim2,-- 문자열 앞뒤로 특정 문자 제거
        TRIM( 'H' FROM 'Hello, World') trim3
FROM dual;
 -- 또는 INSTR('Hello, World', 'o', 6)instr2 (첫번째 o가 5번째, 5번째 이후라서 6)
 
 숫자 관련 함수
 ROUND : 반올림 함수
 TRUNC : 버림 함수
    => 몇번째 자리에서 반올림, 버림을 할지?
        두번째 인자가 0, 양수 : ROUND(숫자, )
        ROUND(숫자, 반올림 결과 자리수)
 MOD : 나머지를 구하는 함수
 
SELECT TRUNC(105.54, 1)TRUNC,
        TRUNC(105.55, 1)TRUNC2,
        TRUNC(105.55, 0)TRUNC3,
        TRUNC(105.55,-1)TRUNC4
FROM dual;

--  1  0  5 . 5 4
  (-3 -2 -1 0 1 2)     
  

mod 나머지 구하는 함수
피제수 - 나눔을 당하는 수, 제수 - 나누는 수
a / b = c
a : 피제수
b : 제수

10을 3으로 나눴을 때의 몫을 구하기
SELECT TRUNC(10/3, 0)TRUNC
FROM dual;

SELECT mod(10,3),10*3, 10/3,  TRUNC(10/3, 0)
FROM dual;

날짜 관련함수
문자열 ==> 날짜 타입 TO_DATE
SYSDATE : 오라클 서버의 현재 날짜, 시간을 돌려주는 특수함수
          함수의 인자가 없다.
          (java
          public void test(){
          } 
          test();
          
          SQL
          length('Hello, World')
          SYSDATE;
          
SELECT SYSDATE
FROM dual;

날짜 타입 +- 정수(일자) : 날짜에서 정수만큼 더한 (뺀)날짜
하루 = 24
1일 = 24h
1/24일 = 1h
1/24일/60 = 1m
1/24일/60/60 = 1s
emp hiredate +5,-5

SELECT SYSDATE, SYSDATE + 5, SYSDATE -5,
        SYSDATE + 1/24, SYSDATE + 1/24/60
FROM dual;

SELECT TO_DATE('2019/12/31','yyyy/mm/dd') LASTDAY, 
        TO_DATE('2019/12/31','yyyy/mm/dd') - 5 LASTDAY_BEFORE5,
        SYSDATE NOW, SYSDATE -3 NOW_BEFORE3
FROM dual;

날짜를 어떻게 표현할까?
java : java.uti.Date
sql : nsl포맷에 설정된 문자열 형식을 따르거나
=>툴 때문일수도 있음. 예측하기 힘듦.
TO_DATE함수를 이용하여 명확하게 명시
TO_DATE('날짜 문자열', '날짜 문자열 형식')