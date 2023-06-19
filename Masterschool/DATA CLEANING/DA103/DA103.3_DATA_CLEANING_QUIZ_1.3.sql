/* There are 350 company names that start with a letter 
and 1 that starts with a number. 
This gives a ratio of 350/351 
that are company names that start with a letter or 99.7%. */


/*MY Answer*/
WITH total AS
(	SELECT
	COUNT(a.name) as total
	FROM accounts a)

SELECT
CASE
WHEN temp2.company_initial IN ('1','2','3','4','5','6','7','8','9','0')
THEN 'Number Group'
ELSE 'Alphabet Group'
END AS groups,
ROUND(SUM(temp2.count) * 100 / total.total, 1) AS count2
FROM
(	SELECT
	temp.comp_ini AS company_initial,
	COUNT(temp.comp_ini) AS count
	FROM
	(	SELECT 
		LEFT(a.name, 1) as comp_ini
		FROM accounts a) AS temp
		GROUP BY company_initial
		ORDER BY count DESC) AS temp2, total
GROUP BY 1, total.total
ORDER BY 1

/*Answer*/
SELECT 
SUM(num) nums, 
SUM(letter) letters
FROM (
		SELECT name, 
		CASE WHEN LEFT(UPPER(name), 1) IN 
		('0','1','2','3','4','5','6','7','8','9') 
       	THEN 1 ELSE 0 END AS num, 
        CASE WHEN LEFT(UPPER(name), 1) IN 
        ('0','1','2','3','4','5','6','7','8','9') 
        THEN 0 ELSE 1 END AS letter
        FROM accounts) t1;