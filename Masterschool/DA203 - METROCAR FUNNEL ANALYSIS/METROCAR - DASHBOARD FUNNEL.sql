--METROCAR DASHBOARD FUNNEL QUERY

WITH main AS
(   SELECT 
 ad.platform AS platform,
 DATE_TRUNC('day', ad.download_ts) as download_ts,
 ad.app_download_key AS app_download_key,
 su.user_id AS su_user_id,
 su.age_range AS age_range,
 rr.ride_id AS rr_ride_id,
 rr.request_ts,
 rr.accept_ts,
 rr.dropoff_ts,
 tra.charge_status AS charge_status,
 rev.user_id AS rev_user_id,
 rev.ride_id AS rev_ride_id
FROM app_downloads AS ad
FULL JOIN signups AS su
ON su.session_id = ad.app_download_key
FULL JOIN ride_requests AS rr
ON rr.user_id = su.user_id
FULL JOIN transactions AS tra
ON tra.ride_id = rr.ride_id
FULL JOIN reviews AS rev
ON rev.ride_id = rr.ride_id),

funnel AS
(SELECT '0' AS funnel_step, 'download' AS funnel_name, main.platform, main.age_range, main.download_ts, COUNT(DISTINCT main.app_download_key) AS user_count, 0 AS ride_count
FROM main AS main
GROUP BY 3, 4, 5
UNION
SELECT '1' AS funnel_step, 'signups' AS funnel_name, main.platform, main.age_range, main.download_ts, COUNT(DISTINCT main.su_user_id) AS user_count, 0 AS ride_count
FROM main AS main
GROUP BY 3, 4, 5
UNION
SELECT '2' AS funnel_step, 'ride_requested' AS funnel_name, main.platform, main.age_range, main.download_ts, COUNT(DISTINCT main.su_user_id) AS user_count, COUNT(DISTINCT main.rr_ride_id) AS ride_count
FROM main AS main
WHERE main.request_ts IS NOT NULL
GROUP BY 3, 4, 5
UNION
SELECT '3' AS funnel_step, 'ride_accepted' AS funnel_name, main.platform, main.age_range, main.download_ts, COUNT(DISTINCT main.su_user_id) AS user_count, COUNT(DISTINCT main.rr_ride_id) AS ride_count
FROM main AS main
WHERE main.accept_ts IS NOT NULL
GROUP BY 3, 4, 5
UNION
SELECT '4' AS funnel_step, 'ride_completed' AS funnel_name, main.platform, main.age_range, main.download_ts, COUNT(DISTINCT main.su_user_id) AS user_count, COUNT(DISTINCT main.rr_ride_id) AS ride_count
FROM main AS main
WHERE main.dropoff_ts IS NOT NULL
GROUP BY 3, 4, 5
UNION
SELECT '5' AS funnel_step, 'payment' AS funnel_name, main.platform, main.age_range, main.download_ts, COUNT(DISTINCT main.su_user_id) AS user_count, COUNT(DISTINCT main.rr_ride_id) AS ride_count
FROM main AS main
WHERE main.charge_status LIKE 'Approved'
GROUP BY 3, 4, 5
UNION
SELECT '6' AS funnel_step, 'review' AS funnel_name, main.platform, main.age_range, main.download_ts, COUNT(DISTINCT main.rev_user_id) AS user_count, COUNT(DISTINCT main.rev_ride_id) AS ride_count
FROM main AS main
GROUP BY 3, 4, 5)

SELECT *
FROM funnel AS funnel
ORDER BY 1, 3, 4, 5
