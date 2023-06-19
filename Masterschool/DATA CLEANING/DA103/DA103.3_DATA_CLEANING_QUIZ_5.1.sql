SELECT 
COALESCE(a.id, a.id) AS filled_id,
a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id,
o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL; 