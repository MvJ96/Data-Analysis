SELECT
o.order_id,
o.amount,
c.first_name,
c.last_name,
c.country
FROM Orders o
JOIN Customers c
ON c.customer_id = o.customer_id
WHERE o.amount BETWEEN 300 AND 2000