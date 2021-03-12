-- 01. Използвайте две INSERT заявки. Съхранете в базата данни факта, че персонален компютър модел 1100 е направен от производителя C, има процесор 2400 MHz, RAM 2048 MB, твърд диск 500 GB, 52x оптично дисково устройство и струва $299. Нека новият компютър има код 12. Забележка: модел и CD са от тип низ.
INSERT INTO product VALUES ('C','1100', 'PC');
INSERT INTO pc (code, model, speed, ram, hd, cd, price)
VALUES (12, '1100', 2400, 2048, 500, '52x', 299);

SELECT * FROM product AS p
INNER JOIN pc ON p.model = pc.model
WHERE p.model = 1100;

-- 02. Да се изтрие наличната информация за компютри модел 1100.
DELETE FROM product WHERE model = 1100;
DELETE FROM pc WHERE code IN (SELECT code FROM pc WHERE model = 1100);

SELECT * FROM product AS p
JOIN pc ON p.model = pc.model
WHERE p.model = 1100;

-- 03. Да се изтрият всички лаптопи, направени от производител, който не произвежда принтери.
DELETE FROM laptop WHERE model IN (SELECT model FROM product WHERE maker NOT IN (SELECT maker FROM product WHERE [type] = 'printer') AND [type] = 'Laptop');
DELETE FROM product WHERE model IN (SELECT model FROM product WHERE maker NOT IN (SELECT maker FROM product WHERE [type] = 'printer') AND [type] = 'Laptop');

SELECT * FROM product AS p
INNER JOIN laptop AS l ON p.model = l.model
WHERE p.model IN (SELECT model FROM product WHERE maker NOT IN (SELECT maker FROM product WHERE [type] = 'printer') AND [type] = 'Laptop');

-- 04. Производител А купува производител B. На всички продукти на В променете производителя да бъде А.
SELECT * FROM product
UPDATE product 
SET maker = 'A' 
WHERE maker = 'B';

SELECT * FROM product WHERE maker = 'B';

-- 05. Да се намали два пъти цената на всеки компютър и да се добавят по 20 GB към всеки твърд диск.
UPDATE pc
SET price = price / 2, hd = hd + 20;

SELECT * FROM pc

-- 06. За всеки лаптоп от производител B добавете по един инч към диагонала на екрана.
UPDATE laptop
SET screen = screen + 1
WHERE code IN (SELECT code FROM laptop AS l
                INNER JOIN product AS p ON l.model = p.model
                WHERE p.maker = 'B');

SELECT * FROM laptop AS l
INNER JOIN product AS p ON l.model = p.model
WHERE p.maker = 'B';