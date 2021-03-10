-- 01. Напишете заявка, която извежда имената на актьорите мъже, участвали във филма The Usual Suspects.
(SELECT NAME FROM MOVIESTAR WHERE GENDER = 'M')
INTERSECT
(SELECT STARNAME FROM STARSIN WHERE MOVIETITLE = 'The Usual Suspects');

-- 02. Напишетезаявка,коятоизвеждаименатанаактьорите,участваливъвфилмиот 1995, продуцирани от студио MGM.
SELECT S.STARNAME FROM STARSIN AS S, MOVIE AS M 
WHERE S.MOVIETITLE = M.TITLE AND STUDIONAME = 'MGM' AND S.MOVIEYEAR = 1995;

-- 03. Напишете заявка, която извежда имената на продуцентите, които са продуцирали филми на студио MGM.
SELECT DISTINCT NAME FROM MOVIEEXEC AS E, MOVIE AS M 
WHERE E.CERT# = M.PRODUCERC# AND STUDIONAME = 'MGM';

-- 04. Напишете заявка, която извежда имената на всички филми с дължина, по- голяма от дължината на филма Star Wars.
SELECT TITLE FROM MOVIE 
WHERE LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars');
SELECT M1.TITLE FROM MOVIE AS M1, MOVIE AS M2 
WHERE M2.TITLE = 'Star Wars' AND M1.LENGTH > M2.LENGTH;

-- 05. Напишете заявка, която извежда имената на продуцентите с нетни активи по- големи от тези на Stephen Spielberg.
SELECT NAME FROM MOVIEEXEC 
WHERE NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Stephen Spielberg');
SELECT ME1.NAME FROM MOVIEEXEC AS ME1, MOVIEEXEC AS ME2 
WHERE ME2.NAME = 'Stephen Spielberg' AND ME1.NETWORTH > ME2.NETWORTH;

-- 06. Напишете заявка, която извежда имената на всички филми, които са продуцирани от продуценти с нетни активи по-големи от тези на Stephen Spielberg.
SELECT M.TITLE FROM MOVIE AS M, MOVIEEXEC AS ME1, MOVIEEXEC AS ME2 
WHERE M.PRODUCERC# = ME1.CERT# AND ME2.NAME = 'Stephen Spielberg' AND ME1.NETWORTH > ME2.NETWORTH;
SELECT TITLE FROM MOVIE 
WHERE PRODUCERC# IN (SELECT CERT# FROM MOVIEEXEC WHERE NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Stephen Spielberg'));