1.
SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01', 'YYYY/MM/DD')
 AND hiredate <= TO_DATE('1983/01/01', 'YYYY/MM/DD');
 
 2. 
 SELECT *
 FROM emp
 WHERE job = 'SALESMAN'
 AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
 
 3. 
 SELECT *
 FROM emp
 WHERE deptno NOT IN (10)
 AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');
 
 4. 
 SELECT empno, ename
 FROM
 (SELECT ROWNUM,empno,ename
 FROM  emp);
 
 5. 
 SELECT *
 FROM emp
 WHERE sal >=1500
 AND deptno IN (10,30)
 ORDER BY ename DESC;
 
 6. 
 SELECT deptno, MAX(sal) max_sal ,MIN(sal) min_sal, ROUND(AVG(sal),2) avg_sal
 FROM emp
 GROUP BY deptno;
 
 7. --
 SELECT e.empno, e.ename, e.sal, e.deptno, d.dname
 FROM emp e,dept d
 WHERE  
 AND sal >2500
 AND e.empno > 7600
 AND d.dname = 'RESEARCH';
 
 8.
 SELECT e.empno, e.ename,e.deptno,d.dname
 FROM emp e,dept d
 WHERE e.deptno IN (10,30);
 
 9.
 SELECT ename,mgr
 FROM emp
 WHERE mgr = ;
 
 10. 
SELECT TO_CHAR(hiredate,'YYYYMM') hire_yyyymm ,COUNT(*)cnt
FROM emp
GROUP BY TO_CHAR(hiredate,'YYYYMM');
 
 11. 
 SELECT *
 FROM emp
 WHERE deptno = '20'
 OR deptno ='30';
 
SELECT *
FROM emp
WHERE deptno IN (20,30);
 
 
 SELECT *
 FROM emp;
 
 12.
 SELECT *
 FROM emp
 WHERE sal > 2073.21;
 
 SELECT ROUND(avg(sal),2)
 FROM emp;
 
 13.
 
 CREATE dept AS('99','ddit','대전');
 
 14.
 UPDATE dept SET 

 15.
 DELETE dept WHERE deptno = '99';
 
 16. 
 ALTER TABLE emp,dept ADD CONSTRAINT PM_emp_dept PRIMARY KEY;
 
 17.
 SELECT deptno, sal)
 FROM emp
 WHERE rollup;
 
 18.
 SELECT ename,sal,deptno,hiredate, RANK(sal)dept_sal_rank
 FROM emp
 ORDER BY hiredate;
 
 19.
 
 20.
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 