WITH temp1 AS
(
    WITH temp AS
    (   SELECT 
            DISTINCT g.uid AS uid,
            COALESCE(SUM(a.spent), 0) AS spent,
            g.group AS group
        FROM activity a
        RIGHT JOIN groups g
        ON a.uid = g.uid
        GROUP BY g.uid, g.group)

    SELECT
    CASE
        WHEN t1.group = 'B' THEN 'Treatment'
        WHEN t1.group = 'A' THEN 'Control'
    END AS user_group,
    ROUND(SUM(t1.spent)) AS group_spent,
    ROUND(AVG(t1.spent)::numeric, 3) AS group_avg,
    COUNT(DISTINCT t1.uid) group_pop,
    ROUND(STDDEV(t1.spent)::numeric, 3) group_pop_stddev
    FROM temp AS t1
    GROUP BY t1.group),

temp2 AS
(   SELECT 
    CASE
        WHEN g.group = 'A' THEN 'Control'
        WHEN g.group = 'B' THEN 'Treatment'
    End AS user_group,
    COUNT (DISTINCT a.uid) AS user_conv,
    ROUND(SUM (a.spent)) AS user_spent
    FROM groups g
    INNER JOIN activity a
    ON g.uid = a.uid
    GROUP BY g.group)

SELECT *,
ROUND((t2.user_conv::float * 100/t1.group_pop::float)::numeric, 3) AS conv_rate
FROM temp1 AS t1
JOIN temp2 AS t2
ON t1.user_group = t2.user_group

#   1) What is the average amount spent per user for the control and treatment groups? 
#   ANS: Control (A)  : 3.375
#   ANS: Treatment (B): 3.391

#   2) What is the 95% confidence interval for the average amount 
#   spent per user in the control?

#   N: 24343
#   u: 3.375
#   t: 1.96 @ 95% Confidence using two tail test
#   s: 25.936
#   ME: 0.326
#   CI: = 3.375 +- 0.326 ==> (3.049, 3.701)

#   3) What is the 95% confidence interval for the average amount 
#   spent per user in the treatment?

#   N: 24600
#   u: 3.391
#   t: 1.96 @ 95% Confidence using two tail test
#   s: 25.414
#   ME: 0.318
#   CI: = 3.391 +- 0.318 ==> (3.073, 3.709)

#   4) Conduct a hypothesis test to see whether there is a difference in the average amount spent per user between the two groups. 
#   What are the resulting p-value and conclusion? Use the t distribution and a 5% significance level. Assume unequal variance.

    Na: 24343
    Nb: 24600

    Xa: 3.375
    Xb: 3.391

    Sa: 25.936
    Sb: 25.414

    Ho: Xa - Xb = 0 <===> Xo = 0
    Ha: Xa - Xb != 0

    T = ((Xb-Xa) - Xo)/(Sa/Na + Sb/Nb) ^ (1/2)

    Xb-Xa = 0.016
    Sa/Na = 0.00107
    Sb/Nb = 0.00103
    (Sa/Na + Sb/Nb) ^ (1/2) = 0.0458

    T = 0.349

