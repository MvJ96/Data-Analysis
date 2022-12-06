SELECT
forest_1990.country,
forest_1990.forest_area - forest_2016.forest_area AS change,
((forest_1990.forest_area - forest_2016.forest_area)*100
/forest_1990.forest_area) AS percentage
FROM
	(	SELECT 
		forestation.country,
		forestation.code,
		forestation.forest_area
		FROM forestation
		WHERE forestation.la_year = '1990' 
		AND forestation.fa_year = '1990') AS forest_1990
LEFT JOIN 
	(SELECT 
		forestation.country,
		forestation.code,
		forestation.forest_area
		FROM forestation
		WHERE forestation.la_year = '2016' 
		AND forestation.fa_year = '2016') AS forest_2016
ON forest_2016.code = forest_1990.code
WHERE forest_1990.forest_area - forest_2016.forest_area IS NOT NULL
AND forest_1990.country NOT LIKE 'World'
ORDER BY change DESC
LIMIT 5;