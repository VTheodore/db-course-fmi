-- 01. Напишете заявка, която извежда средната честота на персоналните компютри.
SELECT CAST(AVG(pc.speed) AS decimal(38, 2)) AS 'AvgSpeed' FROM pc;

-- 02. Напишете заявка, която извежда средния размер на екраните на лаптопите за всеки производител.
SELECT p.maker, AVG(l.screen) AS 'AvgScreen' FROM product AS p
INNER JOIN laptop AS l ON p.model = l.model
GROUP BY maker;

-- 03. Напишете заявка, която извежда средната честота на лаптопите с цена над 1000.
SELECT AVG(speed) AS 'AvgSpeed' FROM laptop
WHERE price > 1000;

-- 04. Напишете заявка, която извежда средната цена на персоналните компютри, произведени от производител ‘A’.
SELECT p.maker, CAST(AVG(pc.price) AS decimal(38, 2)) AS 'AvgPrice' FROM product AS p
INNER JOIN pc ON p.model = pc.model
WHERE p.maker = 'A'
GROUP BY p.maker;

-- 05. Напишете заявка, която извежда средната цена на персоналните компютри и лаптопите за производител ‘B’.

SELECT m.maker, AVG(m.price) 
FROM ((SELECT p.maker, pc.price FROM pc
    INNER JOIN product AS p ON p.model = pc.model)
    UNION ALL
    (SELECT p.maker, l.price FROM laptop AS l
    INNER JOIN product AS p ON p.model = l.model)) AS m
WHERE m.maker = 'B'
GROUP BY m.maker;

-- 06. Напишете заявка, която извежда средната цена на персоналните компютри според различните им честоти.
SELECT speed, AVG(price) AS 'AvgPrice' FROM pc
GROUP BY speed;

-- 07. Напишете заявка, която извежда производителите, които са произвели поне 3 различни персонални компютъра (с различен код).
SELECT p.maker, COUNT(pc.code) AS 'number_of_pc' FROM product AS p
INNER JOIN pc ON p.model = pc.model
GROUP BY p.maker
HAVING COUNT(pc.code) >= 3;

-- 08. Напишете заявка, която извежда производителите с най-висока цена на персонален компютър.
SELECT TOP 1 p.maker, MAX(pc.price) AS 'price' FROM product AS p
INNER JOIN pc ON p.model = pc.model
GROUP BY p.maker
ORDER BY price DESC;

-- 09. Напишете заявка, която извежда средната цена на персоналните компютри за всяка честота по-голяма от 800.
SELECT speed, AVG(price) AS 'AvgPrice' FROM pc
WHERE speed > 800
GROUP BY speed;

-- 10. Напишете заявка, която извежда средния размер на диска на тези персонални компютри, произведени от производители, които произвеждат и принтери. Резултатът да се изведе за всеки отделен производител.
SELECT p.maker, CAST(AVG(pc.hd) as decimal(38, 2)) AS 'AvgHDD' FROM product AS p
INNER JOIN pc ON p.model = pc.model
WHERE p.maker IN (SELECT maker FROM product WHERE type = 'printer')
GROUP BY p.maker;