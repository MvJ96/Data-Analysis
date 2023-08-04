-- RIDE ANALYSIS

WITH rr AS
(	SELECT
	rr.ride_id AS total_rides
	FROM ride_requests AS rr),
accepted AS
(	SELECT
 	rr.accept_ts AS accepted_rides
 	FROM ride_requests AS rr
	WHERE rr.accept_ts IS NOT NULL),
 pickedup AS
( SELECT
 	rr.pickup_ts AS pickedup_rides
 	FROM ride_requests AS rr
	WHERE rr.pickup_ts IS NOT NULL),
 dropoffs AS
(	SELECT
 	rr.dropoff_ts AS dropoff_rides
 	FROM ride_requests AS rr
 	WHERE rr.dropoff_ts IS NOT NULL),

step AS
(	SELECT 'Total Rides' AS step, COUNT(*) AS count FROM rr
  UNION
  SELECT 'Accepted Rides' AS step, COUNT(*) AS count FROM accepted
  UNION
  SELECT 'Picked Up Rides' AS step, COUNT(*) AS count FROM pickedup
  UNION
  SELECT 'Dropped Off Rides' AS step, COUNT(*) AS count FROM dropoffs
  ORDER BY count DESC, 1 DESC),

lags AS
(	SELECT
 	step.step,
 	step.count,
 	lag(step.count, 1) over ()
 	FROM step)

SELECT
step,
count,
lag,
ROUND((1-count::numeric/lag)*100, 2) AS drop_off
FROM lags;
