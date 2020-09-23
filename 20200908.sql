
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

SLECT dummy
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

날짜 데이터 : emp.hiredate
            SYSDATE
            
TO_CHAR(날짜타입, '변경할 문자열 포맷')
TO_DATE('날짜문자열', '첫번째 인자의 날짜 포맷')
TO_CHAR, TO_DATE 첫번째 인자 값을 넣을 때 문자열인지, 날짜인지 구분
현재 설정된 NLS DATE FORMAT : YYYY/MM/DD HH24:MI:SS

SELECT SYSDATE, TO_CHAR(SYSDATE, 'DD-MM-YYYY'), 
    TO_CHAR(SYSDATE, 'D'), TO_CHAR(SYSDATE, 'IW')
FROM dual;

YYYYMMDD ==> YYYY/MM/DD
'20200908'==> '2020/09/08'
SELECT ename,
        SUBSTR('20200908', 1,4)|| '/' || SUBSTR('20200908',5,2) || '/' || SUBSTR('20200908',7,2)
        hiredate, TO_CHAR(hiredate, 'yyyy/mm/dd hh24:mi:ss') h1,
        TO_CHAR(hiredate +1, 'yyyy/mm/dd hh24:mi:ss') h2,
        TO_CHAR(hiredate + 1/24, 'yyyy/mm/dd hh24:mi:ss') h3,
        TO_CHAR(TO_DATE('20200908', 'YYYYMMDD'),'YYYYMMDD') H4
FROM emp;

2020년 9월 8일 14시 10분 5초 ==> '20200908' ==> 2020년 9월 8일
SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYYMMDD')
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') DT_DASH,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') DT_DASH_WITH_TIME,
        TO_CHAR(SYSDATE, 'DD-MM-YYYY') DT_DD_MM_YYYY
FROM dual;

날짜 조작 함수

MONTHS_BETWEEN(date1, date2) : 두 날짜 사이의 개월 수를 반환
                                두 날짜의 일 정보가 다르면 소수점이 나오기 때문에 잘 사용 안함.
ADD_MONTHS(DATE, NUMBER) : 주어진 날짜에 개월수를 더하거나 뺀 날짜를 반환     

ADD_MONTHS(SYSDATE, 5) : 오늘 날짜로부터 5개월 뒤의 날짜는 며칠인가?

NEXT_DAY(DATE, NUMBER(주간요일 : 1-7)) : DATE이후에 등장하는 첫번째 주간요일을 갖는 날짜
NEXT_DAY(SYSDATE, 6) : SYSDATE 이후에 등장하는 첫번째 금요일에 해당하는 날짜

LAST_DAY(DATE) : 주어진 날짜가 속한 월의 마지막 일자를 날짜로 변환
LAST_DAY(SYSDATE) : SYSDATE(2020/09/08)가 속한 9월의 마지막 날짜 : 2020/09/30
                    월마다 마지막 일자가 다르기 때문에 해당 함수를 통해서 편하게
                    마지막 일자를 구할 수 있다.
해당 월의 가장 첫 날짜를 반환하는 함수는 없음 ==> 모든 월의 첫 날짜는 1일이다
FIRST_DAY

SELECT MONTHS_BETWEEN(TO_DATE('20200915','YYYYMMDD'),TO_DATE('20200808', 'YYYYMMDD')),
        ADD_MONTHS(SYSDATE, 5),
        NEXT_DAY(SYSDATE, 6),
        LAST_DAY(SYSDATE),
        TRUNC(SYSDATE, 'MM')
        SYSDATE가 속한 월의 첫 날짜 구하기
        FROM dual;

(2020년 9월 8일 ==> 2020년 9월 1일의 날짜 타입으로 구하기)
방법1.
SELECT TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD'),
FROM dual;

방법2      
-- 오늘날짜 -> 월의 마지막 날짜로 -> 한달전으로 -> 날짜 하루 더하기
SELECT ADD_MONTHS(LAST_DAY(SYSDATE), -1 ) +1
FROM dual;

방법3        
SELECT SYSDATE- TO_CHAR(SYSDATE,'DD')+1
FROM dual;

방법4        
SELECT TO_DATE('01', 'DD')
FROM dual;

실습 fn3
주어진 것 : 년월 문자열 ==> 날짜로 변경 ==> 해당월의 마지막 날짜로 변경

SELECT TO_CHAR(LAST_DAY(TO_DATE('202009','YYYYMM')),'DD')DT
FROM dual;

TO_DATE
TO_CHAR

형변환
명시적 형변환
TO_CHAR, TO_DATE, TO_NUMBER

묵시적 형변환
ORACLE DBMS가 상황에 맞게 알아서 해주는 것
JAVA시간에 8가지 원시 타입(primitive type)간 형변환
1가지 타입이 다른 7가지 타입으로 변활될 수 있는지
8*7 = 56가지

두가지 가능한 경우
1.empno(숫자)를 문자로 묵시적 형변환
2. '7369'(문자)를 숫자로 묵시적 형변환

몰라도 큰 지장은 없지만 알면 매우 좋음, 고급개발자와 일반 개발자 구분하는 차이점이 됨

실행계획 : 오라클에서 요청받은 SQL을 처리하기 위한 절차를 수립한 것
실행계획 보는 방법
1. EXPLAIN PLAN FOR
    실행계획을 분석할 SQL;
2. SELECT *
    FROM TABLE(dbms_xplan.display);

실행계획의 operation을 해석하는 방법
1. 위에서 아래로
2. 단 자식노드(둘여쓰기가 된 노드) 있을 경우 자식부터 실행하고 본인 노드를 실행
    
SELECT *
FROM emp
WHERE empno = '7369';

TABLE 함수 : PL/SQL의 테이블 타입 자료형을 테이블로 변환
SELECT *
FROM TABLE(dbms_xplan.display);

java의 class full name : 패키지명, 클래스명
java : String.lang.class : 

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';

SELECT *
FROM TABLE(dbms_xplan.display);

1600 ==> 1,600
숫자를 문자로 포맷팅 : DB보다는 국제화(i18n) I nternationalizatio N
SELECT empno, ename, TO_CHAR(sal, '009,999L')
FROM emp;

NULL과 관련된 함수 : 4가지 (다 못외워도 됨, 한가지를 주로 사용)
오라클의 NVL함수와 동일한 역할을 하는 MS-SQL SERVER의 함수 이름?

NULL의 의미 : 아직 모르는 값 할당되지 않은 값
                0과 ''문자와는 다르다
NULL의 특징 : NULL을 포함한 연산의 결과는 항상 NULL
sal 컬럼에는 null이 없지만, comm에는 4개의 행을 제외하고 10개의 행이 null값을 갖는다.

SELECT ename, sal, comm, sal+comm
FROM emp;

NULL과 관련된 함수
1. NVL(컬럼 || 익스프레션, 컬럼 || 익스프레션)
    NVL(expr1, ecpr2)
    
    if(expr1 == null)
    System.out.println(expr2);
    else
        System.out.println(expr1);
        
SELECT empno, comm, sal + comm, sal +  NVL(comm, 0)
FROM emp;
    
