SELECT
p.name
FROM person p
JOIN drivers_license dl
ON dl.id = p.license_id
JOIN income inc
ON inc.ssn = p.ssn
JOIN facebook_event_checkin fb
ON fb.person_id = p.id
WHERE dl.height >= 65
AND dl.hair_color = 'red'
AND dl.car_make = 'Tesla'
AND dl.car_model = 'Model S'
AND dl.gender = 'female'
GROUP BY 1
HAVING COUNT(fb.event_id) >= 3

/*  RESULTS
    MAIN VILLAIN AS PER THE MURDERER IS 
    Miranda Priestly
*/