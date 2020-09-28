 [INDEX 실습 idx4]

    1) empno(=)
    2) deptno(=)
    3) deptno(=), empno(LIKE :empno || '%') 
    4) deptno(=), sal(BETWEEN)
    5) deptno (=), loc
        empno(=) 
   
    CREATE UNIQUE INDEX idx_emp_u_01 ON emp (empno, deptno);
    CREATE INDEX idx_emp_n_02 ON emp (deptno,sal);
    CREATE UNIQUE INDEX idx_dept_u_03 ON dept(deptno,loc);