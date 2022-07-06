SELECT * FROM [dbo].[international football]

-- CREATE TABLE -- 
IF OBJECT_ID('results_1872_2020') IS NOT NULL DROP TABLE results_1872_2020
CREATE TABLE results_1872_2020(
[Date] NVARCHAR(100),
Home_team NVARCHAR(100),
Away_team NVARCHAR(100),
Home_score INT,
Away_score INT,
Tournament NVARCHAR(100),
City NVARCHAR(50),
Country NVARCHAR(25),
Neutral NVARCHAR(15))

-- POINTING SQL TO THE FILE LOCATION USING BULK INSERT-- 

--SELECT * FROM [dbo].[results_1872_2020]

--BULK INSERT results_1872_2020
--FROM 'C:\Users\okiad\OneDrive\Desktop\results 2020.csv'
--WITH (FORMAT = 'CSV')

 -- - ----- -- EDA - - - ---------

SELECT * FROM [dbo].[international football]

-- UGANDA -- -
SELECT * FROM [dbo].[international football]
WHERE home_team = 'Uganda' OR away_team = 'Uganda'
-- AS OF 8TH JUNE, UGANDA HAS PLAYED 643 INTERNATIONAL GAMES SINCE 1926 WHERE THEY DREW AGAINST KENYA AND NIGER
------------------------------------------------------------------------------------------------------------------------

---- HOME WINS FOR UGANDA ----
SELECT * FROM [dbo].[international football]
WHERE home_team = 'Uganda' AND home_score > away_score

---- HOME LOSSES FOR UGANDA ----
SELECT * FROM [dbo].[international football]
WHERE home_team = 'Uganda' AND home_score < away_score
-- UGANDA HAS 165 WINS AND ONLY 52 LOSSES AT HOME
-------------------------------------------------------------------------------------------------------------------------
---- AWAY WINS FOR UGANDA ----
SELECT * FROM [dbo].[international football]
WHERE away_team = 'Uganda' AND away_score > home_score

---- AWAY LOSSES FOR UGANDA ----
SELECT * FROM [dbo].[international football]
WHERE away_team = 'Uganda' AND home_score > away_score
-- 105 WINS AND 146 LOSSES AWAY
-------------------------------------------------------------------------------------------------------------------------
--TOTAL HOME AND AWAY SCORES FOR UGANDA -- -- 
SELECT home_team,away_team ,SUM(home_score) [Total Home Goals],SUM(away_score) [Total Away Goals]
FROM [dbo].[international football]
WHERE home_team = 'Uganda' OR away_team = 'Uganda'
GROUP BY home_team,away_team

SELECT home_team ,SUM(home_score) [Total Home Goals]
FROM [dbo].[international football]
WHERE home_team = 'Uganda'
GROUP BY home_team
------- TOTAL HOME GOALS BY TOURNAMENT -----------------
SELECT home_team,tournament,SUM(home_score) [Total Home Goals]
FROM [dbo].[international football]
WHERE home_team = 'Uganda'
GROUP BY home_team,tournament

SELECT away_team ,SUM(away_score) [Total Away Goals]
FROM [dbo].[international football]
WHERE away_team = 'Uganda'
GROUP BY away_team

------- TOTAL AWAY GOALS BY TOURNAMENT -----------------
SELECT away_team,tournament,SUM(away_score) [Total Away Goals]
FROM [dbo].[international football]
WHERE away_team = 'Uganda'
GROUP BY away_team,tournament

SELECT home_team, COUNT(home_team)[Games],SUM(home_score) [Total Home Goals],SUM(away_score)[Goals Conceded]
FROM [dbo].[international football]
WHERE home_team = 'Uganda'
GROUP BY home_team



--- TOURNAMENTS - - -
SELECT DISTINCT tournament  FROM  [dbo].[international football]
-- 135 different International competitions

-- UEFA TOURNAMENTS -----
SELECT DISTINCT tournament FROM [dbo].[international football]
WHERE tournament LIKE '%UEFA%'

---- THE WORLD CUP -------------------------
SELECT * FROM [dbo].[international football]
WHERE tournament LIKE '%Fifa World Cup%'
-- Since 1930, 8675 world cup games have been played up to date making it approximately 23 world cup tournaments or less
-------------------------------------------------------------------------------------------------------------------------

--------------- SCORES ------------------------
SELECT date,tournament,home_team,home_score,away_score,away_team FROM [dbo].[international football]
WHERE home_score > 20

SELECT date,tournament,away_team, MAX(home_score) MaxHomeScore
FROM [dbo].[international football]
WHERE home_team = 'Uganda'
GROUP BY date,tournament,away_team
ORDER BY MaxHomeScore DESC


------------------ COUNTRY TABLE --------------------------------------------------------------

SELECT * FROM [dbo].[countries]

-- SUBQUERRIES 
SELECT * FROM [dbo].[international football]
WHERE country IN 
(SELECT DISTINCT Country FROM [dbo].[countries] WHERE [Population] > 20000000)

-----------------------LATEST GAMES --------------------------------------------------------------

SELECT * FROM [dbo].[international football]
WHERE date = (SELECT MAX(date) FROM [dbo].[international football])

----- WORLD CUP HOST BY YEAR-------------
SELECT DISTINCT country 
FROM [dbo].[international football] 
WHERE tournament LIKE '%Fifa World Cup%' AND YEAR(date) = 2010

------ TEAMS PARTICIPATED IN WOLD CUP---------------------
SELECT * FROM [dbo].[international football]
WHERE home_team IN (
SELECT DISTINCT home_team FROM [dbo].[international football]
WHERE tournament LIKE '%World Cup%')

-------- IF STATEMENT -------------------
SELECT date,home_team,away_team,home_score,away_score,tournament, IIF(Country = 'Uganda','Uganda-256',Country) Country
FROM [dbo].[international football]

SELECT date,home_team,away_team,home_score,away_score,tournament, 
IIF(Country IN ('England','Scotland','Wales'),Country + ' - UK',Country) Country
FROM [dbo].[international football]

----------OR----------------
SELECT date,home_team,away_team,home_score,away_score,tournament, 
CASE 
	WHEN country = 'England' THEN 'Engand-UK'
	WHEN country = 'Scotland' THEN 'Scotland-UK'
	WHEN country = 'Wales' THEN 'Wales-UK'
	ELSE country
END AS country
FROM [dbo].[international football]

------------ RENAMING AND UPDATING COLUMNS ----------------------------------------
UPDATE [dbo].[international football]
SET country = IIF(Country IN ('England','Scotland','Wales'),Country + ' - UK',Country)

-------------REPLACE METHOD ----------------
SELECT date,home_team,away_team,home_score,away_score,tournament, IIF(Country = 'Uganda','Uganda-256',Country) Country,
REPLACE(Country,'Uganda','Uganda-256') Country2
FROM [dbo].[international football]

UPDATE [dbo].[international football]
SET country = REPLACE(Country,'Uganda','Uganda-256')

---- INSERT INTO ----
INSERT INTO [dbo].[international football]
SELECT '2022-07-06','Uganda','France',4,1,'Friendly','Paris','France',5

SELECT * FROM [dbo].[international football] 
WHERE home_team = 'Uganda' AND away_team = 'France'

---- delete rows ------
DELETE FROM [dbo].[international football]
WHERE home_team = 'Uganda' AND away_team = 'France'

--- DELETE COLUMNS ---------------
ALTER TABLE [dbo].[international football]
DROP COLUMN neutral

----- CREATING NEW COLUMN ---------------
SELECT date,home_team,away_team,home_score,away_score,tournament,city,country,
CAST(home_score AS NVARCHAR) + '-' + CAST(away_score AS NVARCHAR) AS Score
FROM [dbo].[international football]

ALTER TABLE [dbo].[international football]
ADD Score VARCHAR(10)

UPDATE [dbo].[international football]
SET Score = CAST(home_score AS NVARCHAR) + '-' + CAST(away_score AS NVARCHAR)

select * from [dbo].[international football]











































































