-- 01. Да се добави информация за актрисата Nicole Kidman. За нея знаем само, че е родена на 20.06.1967.
INSERT INTO MOVIESTAR(NAME, GENDER, BIRTHDATE)
VALUES ('Nicole Kidman', 'F', '1967-06-20');

SELECT * FROM MOVIESTAR WHERE NAME = 'Nicole Kidman';

-- 02. Да се изтрият всички продуценти с нетни активи (networth) под 30 милиона.
DELETE FROM MOVIEEXEC WHERE CERT# IN (SELECT CERT# FROM MOVIEEXEC WHERE NETWORTH < 30000000);

SELECT * FROM MOVIEEXEC WHERE NETWORTH < 30000000;

-- 03. Да се изтрие информацията за всички филмови звезди, за които не се знае адреса.
DELETE FROM MOVIESTAR WHERE NAME IN (SELECT NAME FROM MOVIESTAR WHERE ADDRESS IS NULL);

SELECT * FROM MOVIESTAR WHERE ADDRESS IS NULL;