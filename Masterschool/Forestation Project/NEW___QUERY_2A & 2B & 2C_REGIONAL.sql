/* 	2016
	MAX LATIN AMERICA WITH 46.16%
	MIN Middle East & North Africa 2.07%
	WORLD 31.38% */

/* 	1990
	MAX LATIN AMERICA WITH 51.03%
	MIN Middle East & North Africa 1.78%
	WORLD 32.42% */

/*  CHANGE
    LATIN AMERICA & CARIBBEAN & SUB-SAHARAN AFRICA DECREASED 
    IN THEIR FOREST AREA */

WITH forest_area_2016 AS
(	SELECT
    a.region,
    ROUND(CAST((SUM(a.forest_area) * 100
        /SUM(a.total_area_sq_km)) AS NUMERIC), 2) AS forest_per_2016,
    ROUND(SUM(a.forest_area)) AS forest_2016
    FROM forestation a
    WHERE a.fa_year = '2016' AND a.la_year = '2016'
    GROUP BY 1
    ORDER BY 2 DESC)

, forest_area_1990 AS
(	SELECT
    a.region,
    ROUND(CAST((SUM(a.forest_area) * 100
        /SUM(a.total_area_sq_km)) AS NUMERIC), 2) AS forest_per_1990,
    ROUND(SUM(a.forest_area)) AS forest_1990
    FROM forestation a
    WHERE a.fa_year = '1990' AND a.la_year = '1990'
    GROUP BY 1
    ORDER BY 2 DESC)
SELECT 
a.region,
a.forest_per_2016,
a.forest_2016,
b.forest_per_1990,
b.forest_1990,
(a.forest_per_2016-b.forest_per_1990) AS change
FROM forest_area_2016 a
JOIN forest_area_1990 b
ON a.region = b.region