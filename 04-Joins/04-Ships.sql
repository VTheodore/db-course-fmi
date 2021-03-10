-- 01. Напишете заявка, която извежда цялата налична информация за всеки кораб, включително и данните за неговия клас. В резултата не трябва да се включват тези класове, които нямат кораби.
SELECT * FROM SHIPS AS S
INNER JOIN CLASSES AS C ON S.CLASS = C.CLASS;

-- 02. Повторете горната заявка, като този път включите в резултата и класовете, които нямат кораби, но съществуват кораби със същото име като тяхното.
(SELECT * FROM SHIPS AS S
INNER JOIN CLASSES AS C ON S.CLASS = C.CLASS)
UNION
(SELECT * FROM SHIPS AS S
RIGHT JOIN CLASSES AS C ON S.CLASS = C.CLASS
WHERE S.CLASS IS NULL AND C.CLASS IN (SELECT NAME FROM SHIPS));

-- 03. За всяка страна изведете имената на корабите, които никога не са участвали в битка.
SELECT C.COUNTRY, S.NAME FROM CLASSES AS C
INNER JOIN SHIPS AS S ON C.CLASS = S.CLASS
LEFT JOIN OUTCOMES AS O ON S.NAME = O.SHIP
WHERE O.BATTLE IS NULL
ORDER BY C.COUNTRY ASC, S.NAME;

-- 04. Намерете имената на всички кораби с поне 7 оръдия, пуснати на вода през 1916, но наречете резултатната колона Ship Name.
SELECT S.NAME AS 'Ship Name' FROM CLASSES AS C
INNER JOIN SHIPS AS S ON C.CLASS = S.CLASS
WHERE S.LAUNCHED = 1916 AND C.NUMGUNS >= 7;

-- 05. Изведете имената на всички потънали в битка кораби, името и дата на провеждане на битките, в които те са потънали. Подредете резултата по име на битката.
SELECT O.SHIP, O.BATTLE, B.[DATE] FROM OUTCOMES AS O
INNER JOIN BATTLES AS B ON O.BATTLE = B.NAME
WHERE O.RESULT = 'sunk' 
ORDER BY O.BATTLE ASC;