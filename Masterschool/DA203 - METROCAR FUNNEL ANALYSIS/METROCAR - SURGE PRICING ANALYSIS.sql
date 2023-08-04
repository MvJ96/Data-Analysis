-- SURGE PRICING ANALYSIS

WITH hours AS
(	SELECT 
  DATE_PART('hour', rd.request_ts) AS hours,
 	rd.user_id, 
 	rd.driver_id,
 	rd.accept_ts,
 	rd.cancel_ts,
 	rd.pickup_ts,
 	rd.dropoff_ts
  FROM ride_requests AS rd)

SELECT
CASE
	WHEN hours.hours IN (0,1,2) THEN '00-03'
  WHEN hours.hours IN (3,4,5) THEN '03-06'
  WHEN hours.hours IN (6,7,8) THEN '06-09'
  WHEN hours.hours IN (9,10,11) THEN '09-12'
  WHEN hours.hours IN (12,13,14) THEN '12-15'
  WHEN hours.hours IN (15,16,17) THEN '15-18'
  WHEN hours.hours IN (18,19,20) THEN '18-21'
  WHEN hours.hours IN (21,22,23) THEN '21-24'
END AS TIME_ZONE,
COUNT(hours) AS rides,
COUNT(DISTINCT user_id) AS users,
COUNT(DISTINCT driver_id) AS drivers
FROM hours AS hours
GROUP BY 1
ORDER BY 1;
