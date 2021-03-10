-- 01. Напишете заявка, която извежда производител, модел и тип на продукт за тези производители, за които съответният продукт не се продава (няма го в таблиците PC, Laptop или Printer).
SELECT p.maker, p.model, p.[type] FROM product AS p
LEFT JOIN laptop ON p.model = laptop.model
LEFT JOIN pc ON p.model = pc.model
LEFT JOIN printer ON p.model = printer.model
WHERE laptop.code IS NULL AND pc.code IS NULL AND printer.code IS NULL;

-- 02. Намерете всички производители, които правят както лаптопи, така и принтери.
(SELECT p.maker FROM product AS p INNER JOIN laptop AS l ON p.model = l.model)
INTERSECT
(SELECT p.maker FROM product AS p INNER JOIN printer ON p.model = printer.model);

-- 03. Намерете размерите на тези твърди дискове, които се появяват в два или повече модела лаптопи.
SELECT DISTINCT l1.hd FROM laptop AS l1
INNER JOIN laptop AS l2 ON l1.hd = l2.hd
WHERE l1.code <> l2.code;

-- 04. Намерете всички модели персонални компютри,които нямат регистриран производител.
SELECT p.model FROM product AS p
RIGHT JOIN pc ON p.model = pc.model
WHERE p.maker IS NULL;
