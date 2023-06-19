/* Now, create and use an alias to shorten the 
following query (which is different from the 
one in the Aggregates in Windows Functions video) 
that has multiple window functions. 
Name the alias account_year_window, which 
is more descriptive than main_window in the example above. */

SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER main_wind AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER main_wind AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER main_wind AS count_total_amt_usd,
       AVG(total_amt_usd) OVER main_wind AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER main_wind AS min_total_amt_usd,
       MAX(total_amt_usd) OVER main_wind AS max_total_amt_usd
FROM orders
WINDOW main_wind AS
(PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))                                                      