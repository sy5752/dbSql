[join 1]
SELECT lprod_gu,lprod_nm,prod_id,prod_name
FROM prod, lprod
WHERE prod.prod_lgu = lprod.lprod_gu;

prod 테이블 건수?

SELECT COUNT(*)
FROM prod;

[join 2]
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM buyer,prod
WHERE prod_buyer = buyer_id;                     ==>한정자 안붙여도 됨                            

[join 3]
join시 생각할 부분
1. 테이블 기술
2. 연결조건

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member, cart, prod
WHERE member.mem_id = cart.cart_member;

ANSI-SQL
테이블 JOIN 테이블 ON ()

SELECT member.mem_id, member.mem_name, prod.prod_id, prod.prod_name, cart.cart_qty
FROM member JOIN cart ON (member.mem_id = cart.cart_member)
            JOIN prod ON (cart.cart_member = member.mem_id )
WHERE member.mem_id = cart.cart_member;

