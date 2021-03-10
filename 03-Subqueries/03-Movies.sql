-- 01. Напишете заявка, която извежда имената на актрисите, които са също и продуценти с нетни активи над 10 милиона.
SELECT NAME FROM MOVIESTAR 
WHERE GENDER = 'F' AND NAME IN (SELECT NAME FROM MOVIEEXEC WHERE NETWORTH > 1000000);

-- 02. Напишете заявка, която извежда имената на тези актьори (мъже и жени), които не са продуценти.
SELECT NAME FROM MOVIESTAR 
WHERE NAME NOT IN (SELECT NAME FROM MOVIEEXEC);

-- 03. Напишете заявка, която извежда имената на всички филми с дължина, по-голяма от дължината на филма ‘Star Wars’.
SELECT TITLE FROM MOVIE 
WHERE LENGTH > (SELECT LENGTH FROM MOVIE WHERE TITLE = 'Star Wars');

-- 04. Напишете заявка, която извежда имената на продуцентите и имената на филмите за всички филми, които са продуцирани от продуценти с нетни активи по-големи от тези на ‘Merv Griffin’
SELECT M.TITLE, E.NAME FROM MOVIE AS M, MOVIEEXEC AS E 
WHERE M.PRODUCERC# = E.CERT# AND E.NETWORTH > (SELECT NETWORTH FROM MOVIEEXEC WHERE NAME = 'Merv Griffin');