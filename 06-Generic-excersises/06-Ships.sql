-- 01. Напишете заявка, която извежда имената на всички кораби без повторения, които са участвали в поне една битка и чиито имена започват с C или K.
SELECT DISTINCT SHIP FROM OUTCOMES
WHERE SHIP LIKE 'C%' OR SHIP LIKE 'K%';

-- 02. Напишете заявка, която извежда име и държава на всички кораби, които никога не са потъвали в битка (може и да не са участвали).
SELECT DISTINCT S.NAME, c.COUNTRY FROM CLASSES AS C
INNER JOIN SHIPS AS S ON C.CLASS = S.CLASS
LEFT JOIN OUTCOMES AS O ON S.NAME = O.SHIP
WHERE O.RESULT <> 'sunk' OR O.RESULT IS NULL;

-- 03. Напишете заявка, която извежда държавата и броя на потъналите кораби за тази държава. Държави, които нямат кораби или имат кораб, но той не е участвал в битка, също да бъдат изведени.
SELECT C.COUNTRY, COUNT(O.SHIP) FROM CLASSES AS C
LEFT JOIN SHIPS AS S ON C.CLASS = S.CLASS
LEFT JOIN OUTCOMES AS O ON S.NAME = O.SHIP
WHERE O.RESULT = 'sunk' OR O.RESULT IS NULL
GROUP BY C.COUNTRY;

-- 04. Напишете заявка, която извежда име на битките, които са по-мащабни (с повече участващи кораби) от битката при Guadalcanal.
SELECT BATTLE FROM OUTCOMES
GROUP BY BATTLE
HAVING COUNT(SHIP) > (SELECT COUNT(SHIP) FROM OUTCOMES WHERE BATTLE = 'Guadalcanal' GROUP BY BATTLE);

-- 05. Напишете заявка, която извежда име на битките, които са по-мащабни (с повече участващи страни) от битката при Surigao Strait.
SELECT O.BATTLE FROM OUTCOMES AS O
INNER JOIN SHIPS AS S ON O.SHIP = S.NAME
INNER JOIN CLASSES AS C ON S.CLASS = C.CLASS
GROUP BY BATTLE
HAVING 
COUNT(C.COUNTRY) > (SELECT COUNT(C.COUNTRY) FROM OUTCOMES AS O
                    INNER JOIN SHIPS AS S ON O.SHIP = S.NAME
                    INNER JOIN CLASSES AS C ON S.CLASS = C.CLASS
                    WHERE O.BATTLE = 'Surigao Strait'
                    GROUP BY BATTLE);

-- 06. Напишете заявка, която извежда имената на най-леките кораби с най-много оръдия.
SELECT S.NAME, C.DISPLACEMENT, C.NUMGUNS FROM 
    (SELECT CLASS, DISPLACEMENT, NUMGUNS
    FROM CLASSES
    WHERE DISPLACEMENT = (SELECT MIN(DISPLACEMENT) FROM CLASSES)) AS C
INNER JOIN SHIPS AS S ON C.CLASS = S.CLASS
WHERE NUMGUNS = (SELECT MAX(NUMGUNS) FROM (SELECT NUMGUNS FROM CLASSES WHERE DISPLACEMENT = (SELECT MIN(DISPLACEMENT) FROM CLASSES)) AS C1);

-- 07. Изведете броя на корабите, които са били увредени в битка, но са били поправени и по-късно са победили в друга битка.
SELECT COUNT(DISTINCT O1.SHIP) AS 'num_ships' FROM OUTCOMES AS O1
WHERE O1.RESULT = 'damaged'
AND (SELECT COUNT(*) FROM OUTCOMES AS O2
    INNER JOIN BATTLES AS B1 ON O2.BATTLE = B1.NAME
    WHERE O2.SHIP = O1.SHIP AND O2.RESULT = 'ok' AND B1.[DATE] > (SELECT B2.[DATE] FROM BATTLES AS B2 WHERE B2.NAME = O1.BATTLE)) > 0;

-- 08. Изведете име на корабите, които са били увредени в битка, но са били поправени и по-късно са победили в по-мащабна битка (с повече кораби).
SELECT O1.SHIP AS 'ship_name' FROM OUTCOMES AS O1
WHERE O1.RESULT = 'damaged'
AND (SELECT COUNT(*) FROM OUTCOMES AS O2
    INNER JOIN BATTLES AS B1 ON O2.BATTLE = B1.NAME
    WHERE O2.SHIP = O1.SHIP
    AND O2.RESULT = 'ok'
    AND B1.[DATE] > (SELECT B2.[DATE] FROM BATTLES AS B2 WHERE B2.NAME = O1.BATTLE)
    AND (SELECT COUNT(SHIP) FROM OUTCOMES
        WHERE BATTLE = B1.NAME
        GROUP BY BATTLE) >
        (SELECT COUNT(SHIP) FROM OUTCOMES
        WHERE BATTLE = O1.BATTLE
        GROUP BY BATTLE)) > 0;