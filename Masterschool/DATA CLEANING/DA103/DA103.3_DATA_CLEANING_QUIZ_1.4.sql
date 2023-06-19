/* There are 80 company names that start with a vowel 
and 271 that start with other characters. 
Therefore 80/351 are vowels or 22.8%. 
Therefore, 77.2% of company names do not start with vowels. */

/*Answer*/
SELECT 
SUM(num) vowels, 
SUM(letter) others
FROM (
		SELECT name, 
		CASE WHEN LEFT(UPPER(name), 1) IN 
		('A','E','I','O','U') 
       	THEN 1 ELSE 0 END AS num, 
        CASE WHEN LEFT(UPPER(name), 1) IN 
        ('A','E','I','O','U') 
        THEN 0 ELSE 1 END AS letter
        FROM accounts) t1;