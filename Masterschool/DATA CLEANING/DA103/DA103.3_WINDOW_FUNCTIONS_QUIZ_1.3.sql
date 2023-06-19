/* Select the id, account_id, and total variable 
from the orders table, then create a column 
called total_rank that ranks this total amount 
of paper ordered (from highest to lowest) 
for each account using a partition. 
Your final table should have these four columns. */

SELECT
o.id,
o.account_id,
o.total,
RANK() OVER (PARTITION BY o.account_id ORDER BY o.total DESC) AS total_rank
FROM orders o