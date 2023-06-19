/* We would also like to create an initial password, 
which they will change after their first log in. 
The first password will be the first letter of the 
primary_poc's first name (lowercase), 
then the last letter of their first name (lowercase), 
the first letter of their last name (lowercase), 
the last letter of their last name (lowercase), 
the number of letters in their first name, 
the number of letters in their last name, 
and then the name of the company they are working with, 
all capitalized with no spaces. */

/* MY ANSWER */
SELECT 
CONCAT(tab1.first_name_fl, tab1.first_name_ll, 
	tab1.last_name_fl, tab1.last_name_ll, first_name_numbers,
	last_name_numbers, company_name) AS password
FROM
(	SELECT
	LOWER(LEFT(a.primary_poc, 1)) AS first_name_fl,
	RIGHT(LEFT(a.primary_poc, STRPOS(a.primary_poc, ' ') - 1) , 1) 
	AS first_name_ll,
	LOWER(LEFT(RIGHT(a.primary_poc, LENGTH(a.primary_poc) - 
		STRPOS(a.primary_poc, ' ')), 1)) AS last_name_fl,
	RIGHT(RIGHT(a.primary_poc, LENGTH(a.primary_poc) - 
		STRPOS(a.primary_poc, ' ')), 1) AS last_name_ll,
	LENGTH(LEFT(a.primary_poc, STRPOS(a.primary_poc, ' ') - 1)) 
	AS first_name_numbers,
	LENGTH(RIGHT(a.primary_poc, LENGTH(a.primary_poc) - 
		STRPOS(a.primary_poc, ' '))) AS last_name_numbers,
	UPPER(REPLACE(a.name, ' ', '')) AS company_name
	FROM accounts a
	GROUP BY a.primary_poc, a.name) AS tab1

/* ANSWER */
WITH t1 AS (
 SELECT 
 LEFT(primary_poc, STRPOS(primary_poc, ' ') -1 ) first_name,  
 RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) last_name, 
 name
 FROM accounts)

SELECT 
first_name, 
last_name, 
CONCAT(first_name, '.', last_name, '@', name, '.com'), 
LEFT(LOWER(first_name), 1) 
|| RIGHT(LOWER(first_name), 1) 
|| LEFT(LOWER(last_name), 1) 
|| RIGHT(LOWER(last_name), 1) 
|| LENGTH(first_name) 
|| LENGTH(last_name) 
|| REPLACE(UPPER(name), ' ', '')
FROM t1;

WITH tab1 AS
(	SELECT
	LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) AS first_name,
	RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) 	
	AS last_name,
    name                                                
	FROM accounts)
SELECT
first_name,
last_name,
CONCAT(first_name, '.', last_name, '@', 
	REPLACE(tab1.name, ' ', ''), '.com') 
AS email_id,
LOWER(LEFT(first_name, 1)) ||
LOWER(RIGHT(first_name, 1)) ||
LOWER(LEFT(last_name, 1)) ||
LOWER(RIGHT(last_name, 1)) ||
LENGTH(first_name) ||
LENGTH(last_name) ||
UPPER(REPLACE(tab1.name, ' ', '')) AS password          
FROM tab1
WHERE password IN ('pebs56CHEVRON')                                               