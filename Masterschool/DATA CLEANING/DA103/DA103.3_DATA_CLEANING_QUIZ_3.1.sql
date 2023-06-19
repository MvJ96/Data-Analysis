/* Use the accounts table to create first 
and last name columns that hold the first 
and last names for the primary_poc. */


SELECT 
LEFT(primary_poc, STRPOS(primary_poc, ' ') - 1) AS first_name,
RIGHT(primary_poc, LENGTH(primary_poc) - STRPOS(primary_poc, ' ')) AS last_name
FROM accounts a
