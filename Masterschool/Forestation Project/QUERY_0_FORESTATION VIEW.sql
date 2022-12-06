CREATE VIEW forestation AS
SELECT DISTINCT
reg.country_code code,
reg.country_name country,
reg.region region,
reg.income_group income,
fa.year fa_year,
la.year la_year,
fa.forest_area_sqkm forest_area,
(la.total_area_sq_mi * 2.59) AS total_area_sq_km,
(fa.forest_area_sqkm/(la.total_area_sq_mi * 2.59)) * 100 AS forest_area_per

FROM regions AS reg
JOIN forest_area AS fa
ON fa.country_code = reg.country_code
JOIN land_area AS la
ON la.country_code = reg.country_code
WHERE fa.forest_area_sqkm IS NOT NULL
AND la.total_area_sq_mi IS NOT NULL
