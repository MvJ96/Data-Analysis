/*  Area Lost for Forest Area during 1990 AND 2016
	Compared to total area sqkm of all countries in 2016*/
/* COUNTRY IS PERU with 1279999 sqkm of total land area in 2016
	Which is closest to 1324449 sqkm */

WITH change AS
(     SELECT 
      (MAX(tab1.forest_area_sqkm) - MIN(tab1.forest_area_sqkm)) AS change
      FROM
      (     SELECT *
            FROM forest_area AS fa
            WHERE fa.country_name = 'World' AND (fa.year = '1990' OR fa.year = '2016')
            ORDER BY fa.year
      ) AS tab1
)
SELECT
la.country_code,
la.country_name,
la.year,
la.total_area_sq_mi * 2.59 AS total_area_sqkm
FROM change, land_area AS la
WHERE la.year = '2016' AND
((la.total_area_sq_mi * 2.59) - change.change)*100/change.change BETWEEN '-5' AND '5'
ORDER BY total_area_sqkm DESC
LIMIT 1
