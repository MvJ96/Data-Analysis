-- BASE FUNNEL

WITH ad AS
(	SELECT
 	ad.app_download_key
 	FROM app_downloads AS ad),
su AS
(	SELECT
 	su.user_id
 	FROM signups AS su),
rr AS
(	SELECT
 	DISTINCT rr.user_id
 	FROM ride_requests AS rr),
rvw AS
(	SELECT
 	DISTINCT rvw.user_id
 	FROM reviews AS rvw),

steps AS
(	SELECT 'Download' AS step, COUNT(*) FROM ad
  UNION
  SELECT 'SignUps' AS step, COUNT(*) FROM su
  UNION
  SELECT 'Ride Requests' AS step, COUNT(*) FROM rr
  UNION
  SELECT 'Reviews' AS step, COUNT(*) FROM rvw
  ORDER BY 2 DESC),

lags AS
(	SELECT
 	steps.step,
 	steps.count,
 	lag(steps.count, 1) over () AS lags
 	FROM steps)

SELECT
lags.step,
lags.count,
lags.lags,
ROUND((1.0 - (lags.count::numeric/lags.lags))*100, 2)
FROM lags
