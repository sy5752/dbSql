본인 속한 부서의 급여 평균보다 높은 급여를 받는 사람들을 조회

SELECT *
FROM emp e
WHERE sal > (SELECT AVG(sal)
            FROM emp
            WHERE deptno= e.deptno);
            
            
[sub4]
테스트용 데이터 추가
DESC dept;
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');

SELECT *
FROM dept;        

SELECT *
FROM dept
WHERE deptno NOT IN(SELECT deptno
                     FROM emp);
                     
[실습 sub5]       
SELECT *
FROM product 
WHERE pid NOT IN (100,400);
         ||
SELECT *
FROM  product 
WHERE pid NOT IN(SELECT pid
                FROM cycle
                WHERE cid =1);

[실습 sub6]      
SELECT *
FROM cycle
WHERE cid IN (1)
AND pid = 100;

SELECT *
FROM cycle
WHERE cid=1 
AND pid IN(SELECT pid
           FROM cycle
            WHERE cid =2);    
            
[실습 sub7] 
SELECT c.cid, cnm, pid, day, cnt,
FROM customer c,cycle cy,product p;
WHERE cid=1 
AND pid IN(SELECT pid
           FROM cycle
            WHERE cid =2);

                    


SELECT *
FROM  cycle;

1. emp 테이블에 등록된 사원들이 속한 부서 번호 확인

EXISTS연산자 : 조건을 만족하는 서브쿼리의 행이 존재하면 TRUE
매니저가 존재하는 사원 정보 조회
SELECT *
FROM emp e
WHERE EXISTS ( SELECT 'X'
                FROM emp m
                WHERE e.mgr = m.empno);
                
SELECT *
FROM emp
WHERE EXISTS (SELECT 'X'
                FROM emp
                WHERE empno = mgr);
 
[실습 sub9]                
SELECT *
FROM  product
WHERE EXISTS(SELECT *
                FROM cycle
                WHERE product.pid=pid
                AND cid=1);  
                
[실습 sub 10] 
1번 고객이 먹지 않는 제품 정보 조회

SELECT *
FROM  product
WHERE NOT EXISTS(SELECT *
                FROM cycle
                WHERE product.pid=pid
                AND cid=1);  
                
SELECT *
FROM  product;

SELECT *
FROM  cycle;

집합연산자 : 알아두자
수학의 집합 연산
A = {1,3,5}
B = {1,4,5}

합집합 : A U B = {1,3,4,5} (교환법칙 성립  A U B == B U A)
교집합 : A n B = {1,5} (교환법칙 성립 A U B == B n A)
차집합 : A - B = {3} (교환법칙 성립하지 않음 A - B != B-A)
        B - A = {4}

SQL에서의 집합 연산자
합집합 : UNION : 수학적 합집합과 개념이 동일 (중복을 허용하지 않음)
                중복을 체크 ==> 두 집합에서 중복된 값을 확인 ==> 연산이 느림
        UNION ALL : 수학적 합집합 개념을 떠나 두개의 집합을 단순히 합친다.
        (중복 데이터 존재 가능)
        중복 체크 없음 ==> 두 집합에서 중복된 값 확인 없음 ==> 연산이 빠름
        ** 개발자가 두개의 집합에 중복되는 데이터가 없다는 것을 알 수 있는
        상황이라면 UNION연산자를 사용하는 것보다 UNION ALL을 사용하여 오라클이
        하는 연산을 절약할 수 있다.
        
        INTERSECT : 수학의 교집합 개념과 동일
        MINUS : 수학의 차집합 개념과 동일
 
위아래 집합이 동일하기 때문에 합집합을 하더라도 행이 추가되진 않는다.
       
SELECT empno, ename
FROM emp
WHERE deptno = 10
UNION
SELECT empno, ename
FROM emp
WHERE deptno = 10;

위아래 집합에서  7369번 사번은 중복되므로

SELECT empno, ename
FROM emp
WHERE empno IN (7369,7566)
UNION
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7782);

UNION ALL연산자는 중복제거 단계가 없다. 총 데이터 4개의 행
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7566)
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7782);

두 집합의 공통된 부분은 7369행 밖에 없음 : 총 데이터 1행
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7566)
INTERSECT
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7782);

위쪽 집합에서 아래쪽 집합의 행을 제거하고 남은 행 : 1개의 행(7566)
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7566)
MINUS
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7782);

집합연산자 특징
1. 컬럼명은 첫번째 집합의 컬럼명을 따라간다
2. order by 절은 마지막 집합에 적용한다.
 마지막 SQL이 아닌 SQL에서 정렬을 사용하고 싶은 경우 인라인뷰를 활용
 UNION ALL의 경우 위, 아래 집합을 이어 주기 때문에 집합의 순서를 그대로 유지
 하기 때문에 요구사항에 따라 정렬된 데이터 집합이 필요하다면 해당 방법을 고려
SELECT empno e, ename
FROM emp
WHERE empno IN (7369,7566)
--ORDER BY ename
UNION ALL
SELECT empno, ename
FROM emp
WHERE empno IN (7369,7782);





  
                
                
            


