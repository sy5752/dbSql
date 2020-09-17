[실습 grp5]
SELECT TO_CHAR(hiredate,'YYYY')hiredate, COUNT(*) cnt 
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYY')

[실습 grp6]
SELECT COUNT(deptno) cnt
FROM dept;

[실습 grp7] -- 직원이 속한 부서의 개수 3
SELECT COUNT(COUNT(deptno)) cnt
FROM emp
GROUP BY deptno;

[실습 join0]
SELECT empno,ename,deptno, dname
FROM emp NATURAL JOIN dept
ORDER BY deptno;

[실습 join0_1]
SELECT empno,ename,deptno,dname
FROM emp NATURAL JOIN dept
WHERE deptno IN (10,30);

[실습 join0_2]
SELECT empno,ename,sal,deptno,dname
FROM emp NATURAL JOIN dept
WHERE sal > 2500
ORDER BY deptno;

[실습 join0_3]
SELECT empno,ename,sal,deptno,dname
FROM emp NATURAL JOIN dept
WHERE sal > 2500 AND empno >7600;

[실습 join0_4]
SELECT empno,ename,sal,deptno,dname
FROM emp NATURAL JOIN dept
WHERE sal > 2500 AND empno >7600 AND dname ='RESEARCH'
ORDER BY empno DESC;
