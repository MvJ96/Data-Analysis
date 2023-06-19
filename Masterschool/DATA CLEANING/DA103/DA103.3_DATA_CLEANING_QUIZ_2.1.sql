/* Suppose the company wants to assess the performance of 
all the sales representatives. 
Each sales representative is assigned to work in a particular region. 
To make it easier to understand for the HR team, 
display the concatenated sales_reps.id, ‘_’ (underscore), 
and region.name as EMP_ID_REGION for each sales representative. */

/*Answer*/
SELECT
CONCAT(s.id, '_', r.name) AS EMP_ID_REGION
FROM sales_reps s
JOIN region AS r
ON s.region_id = r.id