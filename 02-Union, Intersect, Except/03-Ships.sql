-- 01. Напишете заявка, която извежда името на корабите с водоизместимост над 50000.
SELECT S.NAME FROM SHIPS AS S, CLASSES AS C 
WHERE S.CLASS = C.CLASS AND C.DISPLACEMENT > 50000;

-- 02. Напишете заявка, която извежда имената, водоизместимостта и броя оръдия на всички кораби, участвали в битката при Guadalcanal.
SELECT S.NAME, C.DISPLACEMENT, C.NUMGUNS FROM CLASSES AS C, SHIPS AS S, OUTCOMES AS O 
WHERE C.CLASS = S.CLASS AND S.NAME = O.SHIP AND O.BATTLE = 'Guadalcanal';

-- 03. Напишете заявка, която извежда имената на тези държави, които имат както бойни кораби, така и бойни крайцери.
SELECT DISTINCT C1.COUNTRY FROM CLASSES AS C1, CLASSES AS C2 
WHERE C1.COUNTRY = C2.COUNTRY AND C1.CLASS <> C2.CLASS AND ((C1.[TYPE] = 'bb' AND C2.[TYPE] = 'bc') OR (C1.[TYPE] = 'bc' AND C2.[TYPE] = 'bb'))

-- 04. Напишете заявка, която извежда имената на тези кораби, които са били повредени в една битка, но по-късно са участвали в друга битка.
SELECT O1.SHIP FROM OUTCOMES AS O1, OUTCOMES AS O2, BATTLES AS B1, BATTLES AS B2 
WHERE O1.SHIP = O2.SHIP AND O1.BATTLE <> O2.BATTLE AND O1.RESULT = 'damaged' AND O1.BATTLE = B1.NAME AND O2.BATTLE = B2.NAME AND B1.[DATE] < B2.[DATE]