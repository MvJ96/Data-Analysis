SELECT *
FROM forest_area AS fa
WHERE fa.country_name = 'World' 
AND (fa.year = '2016' OR fa.year = '1990')