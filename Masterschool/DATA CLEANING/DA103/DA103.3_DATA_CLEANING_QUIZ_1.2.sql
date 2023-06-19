/* There is much debate about how much the name 
(or even the first letter of a company name) matters. 
Use the accounts table to pull the first letter of 
each company name to see the distribution of company 
names that begin with each letter (or number). */

SELECT
temp.comp_ini AS company_initial,
COUNT(temp.comp_ini) AS count
FROM
	(	SELECT 
		LEFT(a.name, 1) as comp_ini
		FROM accounts a) AS temp
GROUP BY company_initial
ORDER BY count DESC