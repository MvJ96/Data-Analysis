/* Use the NTILE functionality to divide the accounts 
into two levels in terms of the amount of gloss_qty 
for their orders. Your resulting table should have 
the account_id, the occurred_at time for each order, 
the total amount of gloss_qty paper purchased, and 
one of two levels in a gloss_half column. */

SELECT
o.account_id,
o.occurred_at,
o.gloss_qty,
NTILE(2) OVER (PARTITION BY o.account_id ORDER BY o.gloss_qty) AS gloss_half
FROM orders o
ORDER BY o.account_id DESC                                          