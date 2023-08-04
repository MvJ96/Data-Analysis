-- BASE METROCAR FUNNEL

WITH ad AS
( SELECT
  ad.app_download_key
  FROM app_downloads AS ad),
su AS
( SELECT
  su.user_id
  FROM signups AS su),
rr AS
( SELECT
  DISTINCT rr.user_id
  FROM ride_requests AS rr),
rc AS
( SELECT
  DISTINCT rc.user_id
  FROM ride_requests AS rc
  WHERE rc.dropoff_ts IS NOT NULL),

steps AS
( SELECT 'Download' AS step, COUNT(*) FROM ad
  UNION
  SELECT 'SignUps' AS step, COUNT(*) FROM su
  UNION
  SELECT 'Ride Requests' AS step, COUNT(*) FROM rr
  UNION
  SELECT 'Ride Completed' AS step, COUNT(*) FROM rc
  ORDER BY 2 DESC),

lags AS
( SELECT
  steps.step,
  steps.count,
  lag(steps.count, 1) over () AS lags
  FROM steps)

SELECT
lags.step,
lags.count,
lags.lags,
ROUND(((lags.count::numeric/lags.lags))*100, 2) AS pep,
ROUND((lags.count::numeric/COUNT(su.user_id))*100, 2) AS pot
FROM lags, su
GROUP BY 1,2,3
ORDER BY 2 DESC;
