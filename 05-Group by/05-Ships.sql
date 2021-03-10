-- 01. Напишете заявка, която извежда броя на класовете бойни кораби.
SELECT COUNT(*) AS 'NO_Classes' FROM CLASSES
WHERE [TYPE] = 'bb'
GROUP BY [TYPE];

-- 02. Напишете заявка, която извежда средния брой оръдия за всеки клас боен кораб.
SELECT CLASS, AVG(NUMGUNS) AS 'avgGuns' FROM CLASSES
WHERE [TYPE] = 'bb'
GROUP BY CLASS;

-- 03. Напишете заявка, която извежда средния брой оръдия за всички бойни кораби.
SELECT AVG(NUMGUNS) AS 'avgGuns' FROM CLASSES
WHERE [TYPE] = 'bb'
GROUP BY [TYPE];

-- 04. Напишете заявка, която извежда за всеки клас първата и последната година, в която кораб от съответния клас е пуснат на вода.
SELECT CLASS, MIN(LAUNCHED) AS 'FirstYear', MAX(LAUNCHED) AS 'LastYear' FROM SHIPS
GROUP BY CLASS;

-- 05. Напишете заявка, която извежда броя на корабите, потънали в битка според класа.
SELECT S.CLASS, COUNT(*) AS 'No_Sunk' FROM OUTCOMES AS O
INNER JOIN SHIPS AS S ON O.SHIP = S.NAME
WHERE RESULT = 'sunk'
GROUP BY S.CLASS;

-- 06. Напишете заявка, която извежда броя на корабите, потънали в битка според класа, за тези класове с повече от 2 кораба.
SELECT S.CLASS, COUNT(*) AS 'No_Sunk' FROM OUTCOMES AS O
INNER JOIN SHIPS AS S ON O.SHIP = S.NAME
WHERE O.RESULT = 'sunk' AND (SELECT COUNT(*) FROM SHIPS WHERE CLASS = S.CLASS) > 2
GROUP BY S.CLASS;

-- 07. Напишете заявка, която извежда средния калибър на оръдията на корабите за всяка страна.
SELECT COUNTRY, CAST(AVG(BORE) AS decimal(38, 2)) AS 'avg_bore' FROM SHIPS AS S
INNER JOIN CLASSES AS C ON S.CLASS = C.CLASS
GROUP BY C.COUNTRY;