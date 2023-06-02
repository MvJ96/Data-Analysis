# 1) What is the average amount spent per user for the control and treatment groups? 
# ANS: Control (A) 	: 3.3745 -- FILTER WITH g.group AS "A"
# ANS: Treatment (B): 3.3908 -- FILTER WITH g.group AS "B"

WITH tsa AS
(   SELECT 
    SUM(a.spent) AS tsa
    FROM groups g
    RIGHT JOIN activity a
    ON a.uid = g.uid
    WHERE g.group = 'A'),
ta AS
(   SELECT 
    DISTINCT COUNT(g.uid) AS ta
    FROM groups g
    WHERE g.group = 'A')

SELECT
    tsa.tsa/ta.ta
FROM tsa, ta;

# 2) What is the 95% confidence interval for the average amount 
#	 spent per user in the control? This question is required.
# ANS: 	t = 1.96 @ df = 1023 and sig. lvl of 5% two side
# 	   	Avg X = 3.375
#	   	N = 24343
#		S = 25.367
#		ME = 0.319	
#		CI = 3.056 - 3.694

#### To get STDDEV
WITH newA AS
(   SELECT 
    a.uid, 
    COALESCE(a.spent, 0) AS newSpent
    FROM groups g
    FULL JOIN activity a
    ON g.uid = a.uid
    WHERE g.group = 'A')
SELECT
STDDEV(newA.newSpent)
FROM newA
###

# 3) What is the 95% confidence interval for the average amount 
#	 spent per user in the treatment? This question is required.
# ANS: 	t = 1.96 @ df = 1023 and sig. lvl of 5% two side
# 	   	Avg X = 3.391
#	   	N = 24600
#		S = 24.793
#		ME = 0.310	
#		CI = 3.081 - 3.701

#### To get STDDEV
WITH newA AS
(   SELECT 
    a.uid, 
    COALESCE(a.spent, 0) AS newSpent
    FROM groups g
    FULL JOIN activity a
    ON g.uid = a.uid
    WHERE g.group = 'A')
SELECT
STDDEV(newA.newSpent)
FROM newA
###

# 6) What is the user conversion rate for the control and treatment groups?
# ANS:	0.0392 FOR CONTROL
# ANS: 	0.0463 FOR TREATMENT
WITH actA AS
(   SELECT 
    CAST(COUNT(DISTINCT a.uid) AS float) AS actA
    FROM activity a
    JOIN groups g
    ON a.uid = g.uid
    WHERE g.group = 'A'),
totA AS
(   SELECT
    CAST(COUNT(g.uid) AS float) AS totA
    FROM groups g
    WHERE g.group = 'A'
)

SELECT actA.actA/totA.totA
FROM actA, totA

# 7) What is the 95% confidence interval for the conversion rate of users in the control?
#ANS: 	Pa = 0.0392
#		Na = 24343
#		Z = 1.96 for z = 0.9750
#		MEa = 0.0024
#		CIa = 0.0368 - 0.0417

# 8) What is the 95% confidence interval for the conversion rate of users in the treatment?
#		Pb = 0.0463
#		Nb = 24600
#		Z = 1.96 for z = 0.9750
#		MEb = 0.0026
#		CIb = 0.0437 - 0.0489