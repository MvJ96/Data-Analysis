SELECT 
date orig_date, 
(	SUBSTR(date, 7, 4) || '-' || 
	LEFT(date, 2) || '-' || 
	SUBSTR(date, 4, 2))::DATE new_date
FROM sf_crime_data;