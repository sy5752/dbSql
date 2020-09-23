--EMP, dept테이블 제약조건 4가지 추가 과제--  

SELECT *
FROM user_constraints
WHERE table_name IN('EMP', 'DEPT');

SELECT *
FROM dept;  

ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY(empno);
ALTER TABLE dept ADD CONSTRAINT PK_dept PRIMARY KEY(deptno); 
ALTER TABLE emp ADD CONSTRAINT FK_emp_emp FOREIGN KEY(mgr) REFERENCES emp(empno);
ALTER TABLE emp ADD CONSTRAINT FK_emp_dept FOREIGN KEY(deptno) REFERENCES dept(deptno);