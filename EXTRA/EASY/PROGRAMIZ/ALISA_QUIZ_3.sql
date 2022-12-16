SELECT DISTINCT
c.first_name,
c.last_name,
c.country,
CASE
WHEN o.amount > 0 THEN 'Have Placed AN ORDER'
ELSE 'NO ORDERS' END AS order_status
FROM Customers c
LEFT JOIN Orders o
ON o.customer_id = c.customer_id