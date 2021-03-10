-- 01. Напишете заявка, която извежда производителя и честотата на лаптопите с размер на диска поне 9 GB.
SELECT product.maker, laptop.speed FROM product, laptop
WHERE product.model = laptop.model AND laptop.hd >=9;

-- 02. Напишете заявка, която извежда модел и цена на продуктите, произведени от производител с име B.
(SELECT product.model, pc.price FROM product, pc WHERE  product.maker = 'B' AND product.model = pc.model)
UNION
(SELECT product.model, laptop.price FROM product, laptop WHERE product.maker = 'B' AND product.model = laptop.model)
UNION
(SELECT product.model, printer.price FROM product, printer WHERE  product.maker = 'B' AND product.model = printer.model);

-- 03. Напишете заявка, която извежда производителите, които произвеждат лаптопи, но не произвеждат персонални компютри.
(SELECT maker FROM product WHERE [type] = 'Laptop')
EXCEPT
(SELECT maker FROM product WHERE [type] = 'PC');

-- 04. Напишете заявка, която извежда размерите на тези дискове, които се предлагат в поне два различни персонални компютъра (два компютъра с различен код).
SELECT DISTINCT pc1.hd FROM pc AS pc1, pc AS pc2
WHERE pc1.code <> pc2.code AND pc1.hd = pc2.hd;
SELECT pc.hd FROM pc
GROUP BY pc.hd
HAVING COUNT(pc.hd) > 1;

-- 05. Напишете заявка, която извежда двойките модели на персонални компютри, които имат еднаква честота и памет. Двойките трябва да се показват само по веднъж, например само (i, j), но не и (j, i).
SELECT DISTINCT pc1.model, pc2.model FROM pc AS pc1, pc AS pc2
WHERE pc1.speed = pc2.speed AND pc1.ram = pc2.ram AND pc1.model <> pc2.model AND pc1.model < pc2.model;

-- 06. Напишете заявка, която извежда производителите на поне два различни персонални компютъра с честота поне 400.
SELECT DISTINCT p1.maker
FROM pc AS pc1, pc AS pc2, product AS p1, product AS p2
WHERE pc1.speed >= 400 AND pc2.speed >= 400 AND pc1.code <> pc2.code AND p1.model = pc1.model AND pc2.model = p2.model AND p1.maker = p2.maker;
