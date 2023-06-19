/* From the web_events table, 
display the concatenated value of 
account_id, '_' , channel, '_', 
count of web events of the particular channel. */

/*MY Answer*/
SELECT 
CONCAT(we.account_id, '_', we.channel, '_', COUNT(*)) AS a
FROM web_events AS we
GROUP BY we.account_id, we.channel
ORDER BY 1 

/*Answer*/
WITH T1 AS (
 SELECT ACCOUNT_ID, CHANNEL, COUNT(*) 
 FROM WEB_EVENTS
 GROUP BY ACCOUNT_ID, CHANNEL
 ORDER BY ACCOUNT_ID
)
SELECT CONCAT(T1.ACCOUNT_ID, '_', T1.CHANNEL, '_', COUNT)
FROM T1
ORDER BY 1;