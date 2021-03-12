-- 01. Напишете заявка, която извежда заглавие и година на всички филми, които са по-дълги от 120 минути и са снимани преди 2000 г. Ако дължината на филма е неизвестна, заглавието и годината на този филм също да се изведат.
SELECT TITLE, [YEAR], LENGTH FROM MOVIE
WHERE (LENGTH > 120 OR LENGTH IS NULL) AND [YEAR] < 2000;

-- 02. Напишете заявка, която извежда име и пол на всички актьори (мъже и жени), чието име започва с 'J' и са родени след 1948 година. Резултатът да бъде подреден по име в намаляващ ред.
SELECT NAME, GENDER FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND BIRTHDATE > CONVERT(datetime, '1948-12-31')
ORDER BY NAME DESC;
-- OR
SELECT NAME, GENDER FROM MOVIESTAR
WHERE NAME LIKE 'J%' AND YEAR(BIRTHDATE) > 1948
ORDER BY NAME DESC;

-- 03. Напишете заявка, която извежда име на студио и брой на актьорите, участвали във филми, които са създадени от това студио.
SELECT DISTINCT M.STUDIONAME, COUNT(DISTINCT S.STARNAME) AS 'num_actors' FROM MOVIE AS M
INNER JOIN STARSIN AS S ON M.TITLE = S.MOVIETITLE
GROUP BY M.STUDIONAME;

-- 04. Напишете заявка, която за всеки актьор извежда име на актьора и броя на филмите, в които актьорът е участвал.
SELECT STARNAME, COUNT(DISTINCT MOVIETITLE) FROM STARSIN
GROUP BY STARNAME;

-- 05. Напишете заявка, която за всяко студио извежда име на студиото и заглавие на филма, излязъл последно на екран за това студио.
SELECT M.STUDIONAME, M.TITLE, M.[YEAR] 
FROM 
    (SELECT STUDIONAME, MAX([YEAR]) AS 'YEAR'
    FROM MOVIE 
    GROUP BY STUDIONAME) AS S
INNER JOIN MOVIE AS M ON S.STUDIONAME = M.STUDIONAME AND M.[YEAR] = S.[YEAR];

-- 06. Напишете заявка, която извежда името на най-младия актьор (мъж).
SELECT TOP 1 NAME FROM MOVIESTAR
WHERE GENDER = 'M'
ORDER BY BIRTHDATE DESC;

-- 07. Напишете заявка, която извежда име на актьор и име на студио за тези актьори, участвали в най-много филми на това студио.
SELECT S1.STUDIONAME, S1.STARNAME, S2.num_movies 
FROM
    (SELECT M.STUDIONAME, S.STARNAME, COUNT(S.MOVIETITLE) AS 'num_movies' FROM STARSIN AS S
    INNER JOIN MOVIE AS M ON S.MOVIETITLE = M.TITLE
    GROUP BY M.STUDIONAME, S.STARNAME) AS S1
INNER JOIN
    (SELECT S.STUDIONAME, MAX(S.[num_movies]) AS 'num_movies' FROM 
    (SELECT M.STUDIONAME, S.STARNAME, COUNT(S.MOVIETITLE) AS 'num_movies' FROM STARSIN AS S
    INNER JOIN MOVIE AS M ON S.MOVIETITLE = M.TITLE
    GROUP BY M.STUDIONAME, S.STARNAME) AS S
GROUP BY S.STUDIONAME) AS S2 ON S1.STUDIONAME = S2.STUDIONAME AND S1.num_movies = S2.num_movies;

-- 08. Напишете заявка, която извежда заглавие и година на филма, и брой на актьорите, участвали в този филм за тези филми с повече от двама актьори.
SELECT M.TITLE, M.[YEAR], S.num_actors FROM MOVIE AS M
INNER JOIN 
    (SELECT MOVIETITLE, COUNT(STARNAME) AS 'num_actors' 
    FROM STARSIN
    GROUP BY MOVIETITLE
    HAVING COUNT(STARNAME)> 2) AS S ON M.TITLE = S.MOVIETITLE;