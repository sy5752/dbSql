customer : 고객
cid : customer id
cnm : customer name
SELECT *
FROM customer;

product : 제품
pid : product  id : 제품 번호
pnm : product name : 제품 이름
SELECT *
FROM product;

cycle : 고객애음주기
cid : customer id 고객 id
pid : product id 제품 id
day : 1~7(일 ~ 토)
cnt : COUNT, 수량

SELECT *
FROM cycle;

[실습 JOIN 4]
-- 이거
ANSI - SQL
SELECT cid, cnm, cycle.pid, cycle.day,cycle.cnt
FROM customer NATURAL JOIN cycle
ON customer.cnm IN ('brown', 'sally');

SELECT customer.*, cycle.pid, cycle.day,cycle.cnt
FROM customer,cycle
WHERE customer.cid=cycle.cid
AND  customer.cnm IN ('brown', 'sally');

[실습 JOIN 5]
SELECT a.cid, a.cnm, a.pid, product.pnm, a.day, a.cnt
FROM
(SELECT customer.*, cycle.pid, cycle.day,cycle.cnt
FROM customer,cycle
WHERE customer.cid=cycle.cid
AND  customer.cnm IN ('brown', 'sally')) a, product
WHERE a.pid = product.pid;

[실습 join6]
SELECT cy.cid, cu.cnm, p.pid, p.pnm, SUM(cy.cnt) cnt 
FROM customer cu, cycle cy, product p 
WHERE cy.pid = p.pid 
AND cu.cid = cy.cid
GROUP BY cy.cid,cu.cnm, p.pid, p.pnm 
ORDER BY cy.cid;

SELECT *
FROM customer; --cid, cnm
SELECT *
FROM cycle; --cid, pid, day, cnt
SELECT *
FROM product; --pid, pnm

[실습 join7]
SELECT c.pid, p.pnm, SUM(c.cnt) cnt
FROM cycle c, product p
WHERE c.pid = p.pid
GROUP BY c.pid, p.pnm
ORDER BY pid;

[실습 join8] (8~13번 hr계정)
SELECT regions.region_id, region_name, country_name
FROM countries,regions
WHERE regions.region_id = countries.region_id
AND region_name = 'Europe';


EXPLAIN PLAN FOR
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.day, cycle.cnt -- ==> 오라클에서는 product테이블부터 읽을 수도 있다
FROM customer,cycle,product
WHERE customer.cid=cycle.cid
AND cycle.pid = product.pid
AND customer.cnm IN ('brown', 'sally');

SELECT * 
FROM TABLE(dbms_xplan.display);


SELECT *
FROM customer;

SELECT *
FROM cycle;

SELECT *
FROM product;

JOIN 구분
1. 문법에 따른 구분 : ANSI-SQL, ORACLE
2. join의 형태에 따른 구분 : SELF-JOIN, NONEQUI- JOIN, CROSS-JOIN
3. join 성공여부에 따라 데이터 표시여부 
        : INNER JOIN - 조인이 성공했을 때 데이터를 표시
        : OUTER JOIN - 조인이 실패해도 기준으로 정한 테이블의 컬럼 정보는 표시
        
사번, 사원의 이름, 관리자 사번, 관리자 이름

KING (PRESIDENT)의 경우 MGR컬럼의 값이 NULL 이기 때문에
조인에 실패. ==> 13건 조회
SELECT e.empno , e.ename, m.mgr, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT e.empno , e.ename, m.mgr, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno , e.ename, m.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
                        =
SELECT e.empno , e.ename, m.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);

행에 대한 제한 조건 기술시 WHERE절에 기술 했을 때와 ON 절에 기술 했을 때
결과가 다르다

사원의 부서가 10번인 사람들만 조회 되도록 부서 번호 조건을 추가
SELECT e.empno , e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno =10);

조건을 WHERE절에 기술한 경우 ==> OUTER JOIN이 아닌 INNER조인 결과가 나온다
SELECT e.empno , e.ename, e.deptno, e.mgr, m.ename, m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE e.deptno = 10;

SELECT e.empno, e.ename, e.deptno, e.mgr, m.ename, m.deptno
FROM emp e JOIN emp m ON (e.mgr = m.empno)
WHERE e.deptno = 10;

ANSI-SQL
SELECT e.empno , e.ename, m.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);
                        =
SELECT e.empno , e.ename, m.mgr, m.ename
FROM emp m RIGHT OUTER JOIN emp e ON (e.mgr = m.empno);

ORACLE-SQL : 데이터가 없는 쪽의 컬럼에 (+) 기호를 붙인자
            ANSI-SQL 기준 테이블 반대편 테이블의 컬럼에 (+)을 붙인다
            WHERE절 연결 조건 적용
SELECT e.empno , e.ename, m.mgr, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno(+);

A U B
SELECT e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
UNION
SELECT e.ename, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno)
INTERSECT
SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

[실습 OUTERJOIN1]
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b, prod p
WHERE b.buy_prod(+) = p.prod_id
 AND b.BUY_DATE(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD');
 
ANSI-SQL
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p
ON (b.buy_prod = p.prod_id AND b.BUY_DATE(+) = TO_DATE('2005/01/25', 'YYYY/MM/DD'));

buy_prod b LEFT OUTER JOIN buy_prod 
SELECT *
FROM prod;

--과제 join6~13 (2020.09.16 수요일 5교시 제출)

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);






