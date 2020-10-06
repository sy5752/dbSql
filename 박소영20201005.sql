CREATE OR REPLACE PROCEDURE UPDATEdept_test (p_deptno IN dept_test.deptno%TYPE,
                                             p_dname IN dept_test.dname%TYPE,
                                             p_loc IN dept_test.loc%TYPE) IS
BEGIN
    UPDATE dept_test SET deptno = p_deptno, dname = p_dname, loc = p_loc WHERE deptno = p_deptno;
    COMMIT;
END;
/

SELECT *
FROM dept_test;
