/* Now see if you can do the same thing 
for every rep name in the sales_reps table. 
Again provide first and last name columns.. */


SELECT name,
LEFT(name, STRPOS(name, ' ') - 1) AS first_name,
RIGHT(name, LENGTH(name) - STRPOS(name, ' ')) AS last_name
FROM sales_reps
