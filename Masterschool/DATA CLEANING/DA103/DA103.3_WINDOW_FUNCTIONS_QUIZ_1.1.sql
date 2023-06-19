/* Create a running total of standard_amt_usd 
(in the orders table) over order time with 
no date truncation. Your final table should 
have two columns: one with the amount being 
added for each new row, and a second with the running total. */

SELECT standard_amt_usd,
       SUM(standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders