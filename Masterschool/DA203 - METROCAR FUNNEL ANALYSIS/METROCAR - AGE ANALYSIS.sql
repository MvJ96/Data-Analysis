-- AGE ANALYSIS

WITH signedups AS
( SELECT
  su.age_range AS age,
  COUNT(su.user_id) AS users
  FROM signups AS su
  WHERE su.age_range IS NOT NULL
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1),
rides AS
(	SELECT
  su.age_range AS age,
  COUNT(DISTINCT su.user_id) AS users
  FROM signups AS su
  JOIN ride_requests AS rd
  ON rd.user_id = su.user_id
  WHERE su.age_range IS NOT NULL
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1),
transcation AS
(	SELECT
  su.age_range AS age,
  COUNT(DISTINCT su.user_id) AS users
  FROM signups AS su
  JOIN ride_requests AS rd
  ON rd.user_id = su.user_id
 	JOIN transactions AS tr
 	ON tr.ride_id = rd.ride_id
  WHERE su.age_range IS NOT NULL
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1),
reviewed AS
(	SELECT
  su.age_range AS age,
  COUNT(DISTINCT su.user_id) AS users
  FROM signups AS su
  JOIN reviews AS rvw
  ON rvw.user_id = su.user_id
  WHERE su.age_range IS NOT NULL
  GROUP BY 1
  ORDER BY 2 DESC
  LIMIT 1)

SELECT '1' AS index, 'Signed Up' AS user, age, users FROM signedups
UNION
SELECT '2' AS index, 'Ride Done' AS user, age, users FROM rides
UNION
SELECT '3' AS index, 'Transacted' AS user, age, users FROM transcation
UNION
SELECT '4' AS index, 'Reviewed' AS user, age, users FROM reviewed
ORDER BY 1, 3;
