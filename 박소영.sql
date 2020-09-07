
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