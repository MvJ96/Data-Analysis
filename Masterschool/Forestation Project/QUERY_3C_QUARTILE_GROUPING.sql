
SELECT
CASE
	WHEN (forestation.forest_area*100/forestation.total_area_sq_km) > 75 THEN '4th Quartile'
	WHEN (forestation.forest_area*100/forestation.total_area_sq_km) BETWEEN '50' AND '75' THEN '3rd Quartile'
	WHEN (forestation.forest_area*100/forestation.total_area_sq_km) BETWEEN '25' AND '50' THEN '2nd Quartile'
	WHEN (forestation.forest_area*100/forestation.total_area_sq_km) < 25 THEN '1st Quartile'
END AS quartile_category,
COUNT(*) AS country_count
FROM forestation
WHERE (forestation.fa_year = '2016' AND forestation.la_year = '2016') AND
forestation.forest_area IS NOT NULL AND
forestation.total_area_sq_km IS NOT NULL AND
forestation.code NOT LIKE 'WLD'
GROUP BY quartile_category
ORDER BY quartile_category