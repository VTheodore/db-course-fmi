-- 01. Напишете заявка, която извежда класа и страната за всички класове с по-малко от 10 оръдия.
SELECT CLASS, COUNTRY FROM CLASSES WHERE NUMGUNS < 10;

-- 02. Напишете заявка, която извежда имената на корабите, пуснати на вода преди 1918. Задайте псевдоним shipName на колоната.
SELECT NAME AS 'shipName' FROM SHIPS WHERE LAUNCHED < 1918;

-- 03. Напишете заявка, която извежда имената на корабите потънали в битка и имената на съответните битки.
SELECT SHIP, BATTLE FROM OUTCOMES WHERE RESULT = 'sunk';

-- 04. Напишете заявка, която извежда имената на корабите с име, съвпадащо с името на техния клас.
SELECT NAME FROM SHIPS AS s WHERE s.NAME = s.CLASS;

-- 05. Напишете заявка, която извежда имената на корабите, които започват с буквата R.
SELECT * FROM SHIPS WHERE NAME LIKE 'R%';

-- 06. Напишете заявка, която извежда имената на корабите, които съдържат 2 или повече думи.
SELECT NAME FROM SHIPS WHERE NAME LIKE '% %';