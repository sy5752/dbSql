[실습 sub7]

SELECT cy.cid, c.cnm, cy.pid, p.pnm, cy.day, cy.cnt
FROM cycle cy ,product p, customer c
WHERE cy.cid=1 AND cy.cid = c.cid AND cy.pid = p.pid
AND cy.pid IN(SELECT pid
           FROM cycle
            WHERE cid =2);
            
SELECT *
FROM cycle; --cid,pid,day,cnt
SELECT *
FROM product; -- pid, pnm
SELECT *
FROM customer; -- cid, cnm

[실습 sub 10] 
1번 고객이 먹지 않는 제품 정보 조회

SELECT *
FROM  product
WHERE NOT EXISTS(SELECT *
                FROM cycle
                WHERE product.pid=pid
                AND cid=1);  
