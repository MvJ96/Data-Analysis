SELECT
tab1.country_name,
tab1.forest_area_sqkm AS forest_1990,
tab2.forest_area_sqkm AS forest_2016,
tab1.forest_area_sqkm - tab2.forest_area_sqkm AS change,
((tab1.forest_area_sqkm - tab2.forest_area_sqkm)*100
/tab1.forest_area_sqkm) AS percentage
FROM
	(SELECT 
		reg.country_name,
		reg.country_code,
		fa.forest_area_sqkm
		FROM forest_area AS fa
		JOIN regions AS reg
		ON reg.country_code = fa.country_code
	WHERE fa.year = '1990') AS tab1
LEFT JOIN 
	(SELECT 
		reg.country_name,
		reg.country_code,
		fa.forest_area_sqkm
		FROM forest_area AS fa
		JOIN regions AS reg
		ON reg.country_code = fa.country_code
	WHERE fa.year = '2016') AS tab2
ON tab2.country_code = tab1.country_code
WHERE tab1.forest_area_sqkm - tab2.forest_area_sqkm IS NOT NULL
AND tab1.country_name NOT LIKE 'World'
ORDER BY percentage DESC
LIMIT 5;

