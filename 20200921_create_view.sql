PSY 계정에게 VIEW객체를 생성할 수 있는 권한을 부여

GRANT CREATE VIEW TO PSY;

SELECT t.*, c.column_name, c.comments
FROM user
