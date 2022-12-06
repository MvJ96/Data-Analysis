WITH usa AS 
(	SELECT forest_area_per AS usa_per
 	FROM forestation WHERE
 	code = 'USA' AND (fa_year = '2016' 
    AND la_year = '2016')
),
countries AS 
(	SELECT country 
 	FROM forestation, usa 	 
  	WHERE forest_area_per > usa_per AND (fa_year = '2016' 
    AND la_year = '2016')
 )
 SELECT COUNT(*) FROM countries