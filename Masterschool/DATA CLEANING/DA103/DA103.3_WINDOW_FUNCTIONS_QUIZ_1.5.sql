/* Modify Derek's query from the previous video in 
the SQL Explorer below to perform this analysis. 
You'll need to use occurred_at and total_amt_usd 
in the orders table along with LEAD to do so. 
In your query results, there should be four columns: 
occurred_at, total_amt_usd, lead, and lead_difference. */

SELECT
o.occurred_at,
o.total_amt_usd,
LEAD(o.total_amt_usd) OVER (ORDER BY o.occurred_at) AS lead,
LEAD(o.total_amt_usd) OVER (ORDER BY o.occurred_at) - o.total_amt_usd 
AS lead_dif
FROM orders o                                            