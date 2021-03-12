-- 01. Напишете заявка, която извежда всички модели лаптопи, за които се предлагат както разновидности с 15" екран, така и с 11" екран.
SELECT model, code, screen FROM laptop
WHERE screen = 15 OR screen = 11;

-- 02. Да се изведат различните модели компютри, чиято цена е по-ниска от най- евтиния лаптоп, произвеждан от същия производител.
SELECT DISTINCT p.model 
FROM 
    (SELECT p.maker, MIN(l.price) AS 'min_price'
    FROM laptop AS l
    INNER JOIN product AS p ON l.model = p.model
    GROUP BY p.maker) AS l,
    (SELECT p.maker, p.model, pc.price
    FROM pc
    INNER JOIN product AS p ON pc.model = p.model) AS p
WHERE p.maker = l.maker AND p.price < l.min_price;

-- 03. Един модел компютри може да се предлага в няколко разновидности с различна цена. Да се изведат тези модели компютри, чиято средна цена (на различните му разновидности) е по-ниска от най-евтиния лаптоп, произвеждан от същия производител.
SELECT p.model, p.avg_price FROM 
    (SELECT p.maker, pc.model, AVG(pc.price) AS 'avg_price'
    FROM pc 
    INNER JOIN product AS p ON pc.model = p.model
    GROUP BY pc.model, p.maker) AS p,
    (SELECT p.maker, MIN(l.price) AS 'min_price'
    FROM laptop AS l
    INNER JOIN product AS p ON l.model = p.model
    GROUP BY p.maker) AS l
WHERE p.maker = l.maker AND p.avg_price < l.min_price;

-- 04. Напишете заявка, която извежда за всеки компютър код на продукта, производител и брой компютри, които имат цена, по-голяма или равна на неговата.
SELECT t1.code, t1.maker, COUNT(DISTINCT pc.code) AS 'num_pc_higher_price' FROM 
    (SELECT p.maker, pc.code, pc.price  
    FROM pc
    INNER JOIN product AS p ON pc.model = p.model) AS t1,
    pc
WHERE t1.price <= pc.price
GROUP BY t1.code, t1.maker;
