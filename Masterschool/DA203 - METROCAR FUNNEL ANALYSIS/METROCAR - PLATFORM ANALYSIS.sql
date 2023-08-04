-- PLATFORM ANALYSIS

WITH dwn AS
(	SELECT
 	platform,
 	COUNT(platform) AS dwnlds
	FROM app_downloads AS ad
	GROUP BY 1
	ORDER BY 2 DESC),
  
sups AS
(	SELECT
 	platform,
 	COUNT(platform) AS signups
	FROM app_downloads AS ad
 	JOIN signups AS su
 	ON su.session_id = ad.app_download_key
	GROUP BY 1
	ORDER BY 2 DESC),
  
ride_req AS
(	SELECT
 	platform,
 	COUNT(DISTINCT rr.user_id) AS requests
	FROM app_downloads AS ad
 	JOIN signups AS su
 	ON su.session_id = ad.app_download_key
 	JOIN ride_requests AS rr
 	ON rr.user_id = su.user_id
	GROUP BY 1
	ORDER BY 2 DESC),

total_rides AS
(	SELECT
 	COUNT(platform) AS dwnlds
	FROM app_downloads AS ad),

table1 AS
(	SELECT
  dwn.platform,
  dwn.dwnlds,
  sups.signups,
  ROUND((1.0 - (sups.signups::numeric/dwn.dwnlds))*100, 2) AS signup_drops,
  ride_req.requests,
  ROUND((1.0 - (ride_req.requests::numeric/sups.signups))*100, 2) AS ride_req_drops
  FROM dwn AS dwn
  JOIN sups AS sups
  ON sups.platform = dwn.platform
  JOIN ride_req AS ride_req
  ON ride_req.platform = dwn.platform
  ORDER BY 2 DESC)

SELECT
table1.platform,
table1.dwnlds,
ROUND((table1.dwnlds::numeric/total_rides.dwnlds)*100,2) AS ride_perc,
--table1.signups,
table1.signup_drops,
--table1.requests,
table1.ride_req_drops
FROM table1, total_rides
