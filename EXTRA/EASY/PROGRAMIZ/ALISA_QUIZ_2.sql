SELECT 
c.first_name,
c.last_name,
o.item
FROM Orders o
JOIN Customers c
ON c.customer_id = o.customer_id
JOIN Shippings s
ON s.customer = c.customer_id
WHERE s.status LIKE 'Pending'