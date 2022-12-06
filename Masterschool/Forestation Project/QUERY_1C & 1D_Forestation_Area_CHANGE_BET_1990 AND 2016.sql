/* result is 1324449* OR 3.2% Change*/


/* OLD CODE
SELECT 
MAX(tab1.forest_area_sqkm) - MIN(tab1.forest_area_sqkm) AS change,
(MAX(tab1.forest_area_sqkm) - MIN(tab1.forest_area_sqkm))* 100/MAX(tab1.forest_area_sqkm) AS perc
FROM
(	SELECT *
	FROM forest_area AS fa
	WHERE fa.country_name = 'World' AND (fa.year = '1990' OR fa.year = '2016')
	ORDER BY fa.year
) AS tab1
*/

SELECT 
(a.forest_area - b.forest_area) AS wld_forest_chng,
ROUND(CAST((a.forest_area - b.forest_area)*100/a.forest_area AS NUMERIC), 2) AS wld_forest_chng_per
FROM forestation a
JOIN forestation b
ON a.code = b.code
WHERE (a.fa_year = '1990' AND a.la_year = '1990')
AND a.code = 'WLD'
AND (b.fa_year = '2016' AND b.la_year = '2016')
AND b.code = 'WLD'