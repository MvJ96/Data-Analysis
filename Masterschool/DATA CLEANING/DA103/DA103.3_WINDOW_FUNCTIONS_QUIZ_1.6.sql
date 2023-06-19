/* Use the NTILE functionality to divide the accounts 
into 4 levels in terms of the amount of standard_qty 
for their orders. Your resulting table should have 
the account_id, the occurred_at time for each order, 
the total amount of standard_qty paper purchased, 
and one of four levels in a standard_quartile column. */

SELECT
o.account_id,
o.occurred_at,
o.standard_qty,
NTILE(4) OVER (PARTITION BY o.account_id ORDER BY o.standard_qty) 
AS quartiles
FROM orders o
ORDER BY o.account_id DESC                                           