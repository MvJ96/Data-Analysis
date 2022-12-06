
SELECT
quartile.country AS country,
quartile.forest_area AS forest_area,
quartile.quartile_category AS quartile,
quartile.region,
quartile.forest,
quartile.income
FROM
(	SELECT
	forestation.country,
	forestation.forest_area,
	forestation.region,
	forestation.income,
	(forestation.forest_area*100/forestation.total_area_sq_km) AS forest,
	CASE
		WHEN (forestation.forest_area*100/forestation.total_area_sq_km) > 75 THEN '4th Quartile'
		WHEN (forestation.forest_area*100/forestation.total_area_sq_km) BETWEEN '50' AND '75' THEN '3rd Quartile'
		WHEN (forestation.forest_area*100/forestation.total_area_sq_km) BETWEEN '25' AND '50' THEN '2nd Quartile'
		WHEN (forestation.forest_area*100/forestation.total_area_sq_km) < 25 THEN '1st Quartile'
	END AS quartile_category
	FROM forestation
	WHERE (forestation.fa_year = '2016' AND forestation.la_year = '2016') AND
	forestation.forest_area IS NOT NULL AND
	forestation.total_area_sq_km IS NOT NULL
	GROUP BY 1,2,3,4,5,6
	ORDER BY 1
) AS quartile

WHERE quartile.quartile_category = '4th Quartile'
GROUP BY 1, 2, 3, 4, 5, 6
ORDER BY quartile