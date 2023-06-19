/* Use the NTILE functionality to divide the orders for 
each account into 100 levels in terms of the amount of 
total_amt_usd for their orders. Your resulting table 
should have the account_id, the occurred_at time for 
each order, the total amount of total_amt_usd paper 
purchased, and one of 100 levels in a total_percentile column. */

SELECT
o.account_id,
o.occurred_at,
o.total_amt_usd,
NTILE(100) OVER (PARTITION BY o.account_id ORDER BY o.total_amt_usd) 
AS total_percentile
FROM orders o
ORDER BY o.account_id DESC                                        