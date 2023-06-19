/* Each company in the accounts table wants to 
create an email address for each primary_poc. 
	The email address should be the first name 
	of the primary_poc . last name primary_poc @ company name .com. */


SELECT
CONCAT(tab1.first_name, '.', tab1.last_name, '@', tab1.company_name, '.com')
 AS email
FROM
(	SELECT
	LEFT(a.primary_poc, STRPOS(a.primary_poc, ' ') - 1) AS first_name,
	RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, 		' ')) AS last_name,
	REPLACE(a.name, ' ', '') AS company_name                               
	FROM accounts a) AS tab1
