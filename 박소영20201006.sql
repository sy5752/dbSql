DECLARE
    v_sal NUMBER := 0;
    e_sal NUMBER;

BEGIN
SELECT sal INTO e_sal
FROM emp
WHERE empno = 7369;
    v_sal := CASE 
          WHEN e_sal>1000 THEN e_sal*1.2
          WHEN e_sal>900 THEN e_sal*1.3
          WHEN e_sal>800 THEN e_sal*1.4
          ELSE e_sal*1.6
        END;
         DBMS_OUTPUT.PUT_LINE('v_sal');
         UPDATE emp SET sal =v_sal WHERE empno = '7369';
        COMMIT;
END;
/
SELECT *
FROM emp;