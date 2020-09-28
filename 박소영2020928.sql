[실습 sub_a3]

CREATE TABLE emp_test AS 
SELECT * FROM emp;

UPDATE emp_test a SET sal = sal+200 
WHERE sal < (SELECT AVG(sal)
FROM emp_test b
WHERE a.deptno = b.deptno);

SELECT sal+200
FROM emp_test
WHERE sal < (SELECT AVG(sal)
            FROM emp_test);
            
SELECT *
FROM emp;

