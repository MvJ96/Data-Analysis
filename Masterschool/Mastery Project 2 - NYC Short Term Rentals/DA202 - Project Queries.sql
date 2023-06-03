#Question 1 - Most Popular Neighbourhoods for Short-term rentals in New York City

SELECT 
p.neighbourhood,
COUNT(p.listing_id) AS Top_5
FROM prices p
INNER JOIN reviews r
ON p.listing_id = r.listing_id
GROUP BY p.neighbourhood
ORDER BY Top_5 DESC
LIMIT 5;

#Question 2 - Avg Rental Price in New York City for Short term rentals AND How does it vary by neighbourhood & property type.

### AVG RENTAL PRICE ###
SELECT 
ROUND(AVG(p.price)::numeric, 2) AS avg_rental_price
FROM prices p
JOIN room_types rt
ON p.listing_id = rt.listing_id;
### AVG RENTAL PRICE ###

### Variation by Neighbourhood ###
### TOP 5 ###
SELECT 
p.neighbourhood,
ROUND(AVG(p.price)::numeric, 2) AS avg_rental_price
FROM prices p
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
### TOP 5 ###

### BOTTOM 5 ###
SELECT 
p.neighbourhood,
ROUND(AVG(p.price)::numeric, 2) AS avg_rental_price
FROM prices p
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1
ORDER BY 2
LIMIT 5;
### BOTTOM 5 ###
### Variation by Neighbourhood ###

### Variation BY Property Type ###
SELECT 
rt.room_type,
ROUND(AVG(p.price)::numeric, 2) AS avg_rental_price
FROM prices p
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1
ORDER BY 2 DESC;
### Variation BY Property Type ###

# QUESTION 3 - Most common rental property and variation of that by neighbourhood

### most common rental properties###
SELECT 
rt.room_type,
COUNT(p.listing_id) AS times_rented
FROM prices p
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1
ORDER BY 2 DESC;
### most common rental properties###

### variation by neighbourhood ###
SELECT 
p.neighbourhood,
rt.room_type,
COUNT(p.listing_id) AS times_rented
FROM prices p
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1, 2
ORDER BY 1, 2, 3 DESC;
### variation by neighbourhood ###

# QUESTION 4 - Avg length of stay - Variation by Neighbourhood & Property Type

### AVG Length of Stay ###
SELECT 
ROUND(AVG(r.minimum_nights), 0) AS avg_los
FROM prices p
JOIN reviews r
ON p.listing_id = r.listing_id
JOIN room_types rt
ON p.listing_id = rt.listing_id
### AVG Length of Stay ###

### Variation - Neighbourhood - Top 5
SELECT 
p.neighbourhood,
ROUND(AVG(r.minimum_nights), 0) AS avg_los
FROM prices p
JOIN reviews r
ON p.listing_id = r.listing_id
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
### Variation - Neighbourhood - Top 5

### Variation - Neighbourhood - Bottom 5
SELECT 
p.neighbourhood,
ROUND(AVG(r.minimum_nights), 0) AS avg_los
FROM prices p
JOIN reviews r
ON p.listing_id = r.listing_id
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1
ORDER BY 2
LIMIT 5;
### Variation - Neighbourhood - Bottom 5

### Variation - Room Type
SELECT 
rt.room_type,
ROUND(AVG(r.minimum_nights), 0) AS avg_los
FROM prices p
JOIN reviews r
ON p.listing_id = r.listing_id
JOIN room_types rt
ON p.listing_id = rt.listing_id
GROUP BY 1
ORDER BY 2 DESC;
### Variation - Room Type


# QUESTION 5 - Demand over time - Any seasonal patterns?

SELECT
TO_CHAR(last_review, 'month') AS month,
COUNT(*)
FROM reviews
GROUP BY 1
ORDER BY 2 DESC;