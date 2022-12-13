SELECT 
p.name,
i.transcript
FROM person p
JOIN drivers_license dl
ON dl.id = p.license_id
JOIN get_fit_now_member gfnm
ON gfnm.person_id = p.id
JOIN get_fit_now_check_in gfnc
ON gfnc.membership_id = gfnm.id
JOIN interview i
ON i.person_id = p.id
WHERE gfnm.id LIKE '48Z%'
AND gfnm.membership_status = 'gold'
AND dl.plate_number LIKE '%H42W%'
AND gfnc.check_in_date = 20180109

/*  RESULT
    NAME :  Jeremy Bowers
            I was hired by a woman with a lot of money. 
            I don't know her name but I know she's around 
            5'5" (65") or 5'7" (67"). 
            She has red hair and she drives a Tesla Model S. 
            I know that she attended the 
            SQL Symphony Concert 3 times in December 2017.
*/
   