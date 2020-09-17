[실습 join6] (hr계정 x)
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
SELECT r.region_id, region_name, country_name
FROM countries c,regions r
WHERE r.region_id = c.region_id
AND region_name = 'Europe';
   or
SELECT r.*, c.country_name
FROM countries c,regions r, locations l
WHERE r.region_id = c.region_id
AND r.region_id = 1
AND c.country_id = l.country_id;

SELECT *
FROM regions;

[실습 join9]
SELECT r.region_id, r.region_name, c.country_name, l.city
FROM countries c,regions r, locations l
WHERE r.region_id = c.region_id
AND c.country_id=l.country_id
AND region_name = 'Europe';

SELECT *
FROM countries; --country_id, country_name, region_id
SELECT *
FROM regions; --region_id, region_name
SELECT *
FROM locations; --city, ...
SELECT *
FROM departments; --department_name, ...

[실습 join10]
SELECT r.region_id, r.region_name, c.country_name, l.city, d.department_name
FROM countries c,regions r, locations l, departments d
WHERE r.region_id = c.region_id
AND c.country_id = l.country_id
AND d.location_id = l.location_id
AND region_name = 'Europe';

[실습 join11]
SELECT r.region_id, r.region_name, c.country_name, l.city, d.department_name, 
CONCAT(e.first_name, e.last_name) name
FROM countries c, regions r, locations l, departments d, employees e
WHERE r.region_id=c.region_id 
AND c.country_id = l.country_id
AND d.location_id = l.location_id
AND e.department_id = d.department_id
AND region_name = 'Europe';

[실습 join12]
SELECT e.employee_id, CONCAT(e.first_name, e.last_name) name, j.job_id, j.job_title
FROM employees e, jobs j;

[실습 join13]
SELECT *
FROM employees;
SELECT *
FROM jobs;

SELECT e.manager_id mgr_id, CONCAT(m.first_name, m.last_name) mgr_name,
        e.employee_id,CONCAT(e.first_name, e.last_name) name,
        j.job_id,j.job_title
FROM employees e, jobs j, employees m 
WHERE e.job_id = j.job_id
AND e.manager_id = m.employee_id;

[실습 outerjoin 5] (hr계정 X)
SELECT p.pid, p.pnm,NVL(cu.cnm,'brown') cnm, NVL(c.day, 0) day, NVL(c.cnt,0) cnt
FROM cycle c, product p, customer cu
WHERE c.pid(+) = p.pid
AND c.cid = cu.cid(+)
AND c.cid(+) = 1
ORDER BY pid DESC;

SELECT *
FROM product p;
SELECT *
FROM cycle c;
SELECT *
FROM customer cu;