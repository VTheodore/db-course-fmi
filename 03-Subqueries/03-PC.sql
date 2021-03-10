-- 01. Напишете заявка, която извежда производителите на персонални компютри с честота над 500.
SELECT maker FROM product 
WHERE model IN (SELECT model FROM pc WHERE speed > 500);

-- 02. Напишете заявка, която извежда код, модел и цена на принтерите с най- висока цена.
SELECT code, model, price FROM printer 
WHERE price >= ALL(SELECT price FROM printer);

-- 03. Напишете заявка, която извежда лаптопите, чиято честота е по-ниска от честотата на всички персонални компютри.
SELECT * FROM laptop 
WHERE speed <= ALL(SELECT speed FROM laptop);

-- 04. Напишете заявка, която извежда модела и цената на продукта (PC, лаптоп или принтер) с най-висока цена.
SELECT * FROM 
((SELECT model, price FROM laptop)
UNION
(SELECT model, price FROM pc)
UNION
(SELECT model, price FROM printer)) AS p
WHERE p.price >= ALL(SELECT price FROM laptop UNION SELECT price FROM pc UNION SELECT price FROM printer); 

-- 05. Напишете заявка, която извежда производителя на цветния принтер с най-ниска цена.
SELECT product.maker FROM product, printer 
WHERE product.model =  printer.model AND printer.color = 'y' AND printer.price <= ALL(SELECT price FROM printer WHERE color = 'y');

-- 06. Напишете заявка, която извежда производителите на тези персонални компютри с най-малко RAM памет, които имат най-бързи процесори.
SELECT maker FROM product 
WHERE model IN
(SELECT model FROM pc AS p WHERE ram <= ALL(SELECT ram FROM pc) AND speed >= ALL(SELECT speed FROM pc WHERE p.model = pc.model));