/* Now, modify your query from the previous quiz 
to include partitions. Still create a running 
total of standard_amt_usd (in the orders table) 
over order time, but this time, date truncate 
occurred_at by year and partition by that same 
year-truncated occurred_at variable. */

SELECT
o.standard_amt_usd,
DATE_TRUNC('year', o.occurred_at),
SUM(o.standard_amt_usd) OVER
(	PARTITION BY (DATE_TRUNC('year', o.occurred_at)) 
 	ORDER BY o.occurred_at) AS running_total
FROM orders o