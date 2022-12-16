SELECT AVG(c.age) AS avg_age
FROM Customers c
JOIN Orders o
ON o.customer_id = c.customer_id
JOIN Shippings s
ON s.customer = c.customer_id
WHERE o.amount > 300 AND
s.status = 'Pending'