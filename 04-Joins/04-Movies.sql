-- 01. Напишете заявка, която извежда името на продуцента и имената на филмите, продуцирани от продуцента на филма ‘Star Wars’.
SELECT M.TITLE, ME.NAME FROM MOVIEEXEC AS ME 
INNER JOIN MOVIE AS M ON ME.CERT# = M.PRODUCERC#
WHERE M.PRODUCERC# = (SELECT PRODUCERC# FROM MOVIE WHERE TITLE = 'Star Wars');

-- 02. Напишете заявка, която извежда имената на продуцентите на филмите, в които е участвал ‘Harrison Ford’.
SELECT DISTINCT ME.NAME FROM MOVIE AS M
INNER JOIN STARSIN AS S ON M.TITLE = S.MOVIETITLE
INNER JOIN MOVIEEXEC AS ME ON M.PRODUCERC# = ME.CERT#
WHERE S.STARNAME = 'Harrison Ford';

-- 03. Напишете заявка, която извежда името на студиото и имената на актьорите, участвали във филми, произведени от това студио, подредени по име на студио.
SELECT M.STUDIONAME, S.STARNAME FROM MOVIE AS M
INNER JOIN STARSIN AS S ON M.TITLE = S.MOVIETITLE
ORDER BY M.STUDIONAME ASC;

-- 04. Напишете заявка, която извежда имената на актьорите, участвали във филми на продуценти с най-големи нетни активи.
SELECT S.STARNAME, ME.NETWORTH, M.TITLE FROM MOVIE AS M
INNER JOIN MOVIEEXEC AS ME ON M.PRODUCERC# = ME.CERT#
INNER JOIN STARSIN AS S ON M.TITLE = S.MOVIETITLE
WHERE ME.NETWORTH >= ALL(SELECT NETWORTH FROM MOVIEEXEC);

-- 05. Напишете заявка, която извежда имената на актьорите, които не са участвали в нито един филм.
SELECT MS.NAME, S.MOVIETITLE FROM MOVIESTAR AS MS
LEFT JOIN STARSIN AS S ON MS.NAME = S.STARNAME
WHERE S.MOVIETITLE IS NULL;