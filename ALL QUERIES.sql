--DATABASE
--https://bit.io/emiliano/Capstone_Project
--DATABASE

--Question 1
--How many customers do we have in the data?
SELECT COUNT(*) AS customers_count
FROM customers;

--Question 2 & 3
--What was the city with the most profit for the company in 2015?
--In 2015, what was the most profitable city's profit?
WITH profits AS
(   SELECT 
    o.shipping_city AS city,
    od.order_profits AS profit
    FROM orders AS o
    LEFT JOIN order_details AS od
    ON o.order_id = od.order_id
    WHERE DATE_PART('year', o.order_date) = 2015)

SELECT
profits.city,
SUM(profits.profit)
FROM profits AS profits
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

--Question 4
--How many different cities do we have in the data?
SELECT COUNT(DISTINCT o.shipping_city)
FROM orders o;

--Question 5 (Two null values - Customer did not spent any or missing data)
--Show the total spent by customers from low to high.
SELECT c.customer_id, SUM(od.order_sales) AS total_spent
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN order_details od
ON o.order_id = od.order_id
GROUP BY 1
ORDER BY 2;

--Question 6 & 7
--What is the most profitable city in the State of Tennessee?
--What’s the average annual profit for that city across all years?
WITH tns AS 
(	SELECT 
	o.shipping_city, 
	SUM(od.order_profits) AS city_sum
	FROM orders o
	LEFT JOIN order_details od
	ON o.order_id = od.order_id
	WHERE o.shipping_state LIKE 'Tennessee'
	GROUP BY 1
	ORDER BY 2 DESC
	LIMIT 1)

SELECT 
o.shipping_city,
AVG(od.order_profits) AS  Avg_Profit
FROM tns AS tns, orders o
JOIN order_details as od
ON o.order_id = od.order_id
WHERE o.shipping_city LIKE
    (   SELECT shipping_city
        FROM tns)
GROUP BY 1;

--Question 8
--What is the distribution of customer types in the data?
WITH total AS
(   SELECT
    COUNT(c.customer_segment) as total
    FROM customers c),
cust_seg AS
(   SELECT
    c.customer_segment AS cs,
    COUNT(c.customer_segment) AS counted
    FROM customers AS c
    GROUP BY 1)
SELECT 
cs.cs,
cs.counted AS dis
FROM cust_seg AS cs, total as t
ORDER BY 2 DESC

--Question 9
--What’s the most profitable product category on average in Iowa across all years?
SELECT product_category, AVG(od.order_profits)
FROM order_details AS od
LEFT JOIN product AS prd
ON od.product_id = prd.product_id
RIGHT JOIN orders AS o
ON o.order_id = od.order_id
WHERE o.shipping_state LIKE 'Iowa'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

--Question 10
--What is the most popular product in that category across all states in 2016?
WITH ctgry AS
(   SELECT
    product_category AS product_cat, AVG(od.order_profits)
    FROM order_details AS od
    LEFT JOIN product AS prd
    ON od.product_id = prd.product_id
    RIGHT JOIN orders AS o
    ON o.order_id = od.order_id
    WHERE o.shipping_state LIKE 'Iowa'
    GROUP BY 1
    ORDER BY 2 DESC
    LIMIT 1)

SELECT 
    prd.product_name,
    SUM(od.quantity)
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
LEFT JOIN product AS prd
ON od.product_id = prd.product_id
WHERE DATE_PART('year', o.shipping_date) = 2016
AND prd.product_category LIKE 
(   SELECT product_cat
    FROM ctgry)
GROUP BY 1
ORDER BY 2 DESC;

--Question 11
--Which customer got the most discount in the data? (in total amount)
SELECT
    c.customer_id AS cust,
    (od.order_sales)/(1-od.order_discount) - od.order_sales AS disc
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
ORDER BY 2 DESC;

--Question 12
--How widely did monthly profits vary in 2018?
WITH month_profit AS
(   SELECT 
    TO_CHAR(o.order_date, 'Month') AS month,
    DATE_PART('month', o.order_date) AS month_num,
    SUM(od.order_profits) AS monthly_profits
    FROM orders AS o
    LEFT JOIN order_details AS od
    ON o.order_id = od.order_id
    WHERE DATE_PART('year', o.order_date) = 2018
    GROUP BY 1, 2
    ORDER BY 2)

SELECT
month.month,
month.monthly_profits AS cur_profit,
LAG(month.monthly_profits) OVER (ORDER BY month.month_num) AS pre_profits,
month.monthly_profits - LAG(month.monthly_profits) OVER (ORDER BY month.month_num) AS diff
FROM month_profit AS month;

--Question 13
	--Which order was the highest in 2015?
	--FOR SALES
SELECT
o.order_id,
od.order_details_id,
od.quantity,
od.order_sales
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
WHERE DATE_PART('year', o.order_date) = 2015
ORDER BY 4 DESC
LIMIT 1;

	--FOR QTY
SELECT
o.order_id,
od.order_details_id,
od.quantity,
od.order_sales
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
WHERE DATE_PART('year', o.order_date) = 2015
ORDER BY 3 DESC
LIMIT 1;

--Question 14
--What was the rank of each city in the East region in 2015?
SELECT 
o.shipping_city AS cities,
SUM(od.quantity) AS amount_ordered,
RANK () OVER 
(   
    ORDER BY COUNT(*) DESC
)
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
WHERE o.shipping_region = 'East' AND
DATE_PART('year', o.order_date) = 2015
GROUP BY 1
ORDER BY 2 DESC;

--Question 15
	--Display customer names for customers who are in the segment ‘Consumer’ or ‘Corporate.’ 
	--Names of Customers in Corpo and Consumer
SELECT DISTINCT c.customer_name
FROM customers c
WHERE c.customer_segment IN ('Consumer', 'Corporate');

	--How many customers are there in total?
	--Total Customers
SELECT COUNT(DISTINCT c.customer_name)
FROM customers c
WHERE c.customer_segment IN ('Consumer', 'Corporate');

--Question 16
--Calculate the difference between the largest and smallest order quantities for product id ‘100.’
SELECT 
MAX(od.quantity) - MIN(od.quantity) AS diff
FROM order_details AS od
WHERE od.product_id = 100;

--Question 17
--Calculate the percent of products that are within the category ‘Furniture.’
WITH furn_count AS
(   SELECT
    COUNT(prd.product_category) AS prd_cat_count
    FROM product prd
    WHERE prd.product_category = 'Furniture'),
total_count AS
(   SELECT
    COUNT(prd.product_category) AS total_count
    FROM product prd)
SELECT
CAST(furn_count.prd_cat_count AS FLOAT) * 100 / CAST(total_count.total_count AS FLOAT) AS per_prd
FROM furn_count, total_count;

--Question 18
--Find what product manufacturers has more than 2 products?
WITH temp1 AS
(   SELECT
    prd.product_manufacturer AS name,
    COUNT(*) AS counts
    FROM product AS prd
    GROUP BY 1
    ORDER BY 2)

SELECT
temp1.name,
temp1.counts
FROM temp1 As temp1
WHERE temp1.counts > 2 AND temp1.name LIKE 'SanDisk';


--Question 19
--Show the product_subcategory and the total number of products in the subcategory.
SELECT
prd.product_subcategory AS prd_sub,
COUNT(*) AS count_prd_sub
FROM product AS prd
GROUP BY 1
ORDER BY 2 DESC;

--Question 20
--Show the product_id(s), the sum of quantities, 
--where the total sum of its product quantities is greater than or equal to 100.
SELECT
od.product_id AS product_id,
SUM(od.quantity) AS sum_quantity
FROM order_details AS od
GROUP BY 1
HAVING SUM(od.quantity) >= 100
ORDER BY 1;

--BONUS QUESTION
SELECT *
FROM customers AS c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
LEFT JOIN product AS prd
ON od.product_id = prd.product_id;