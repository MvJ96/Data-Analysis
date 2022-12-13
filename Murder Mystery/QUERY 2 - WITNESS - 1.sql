SELECT 
p.name,
i.transcript
FROM person p
JOIN interview i
ON i.person_id = p.id
WHERE p.address_street_name = 'Northwestern Dr'
ORDER BY p.address_number DESC
LIMIT 1

/*  RESULT
    NAME :  Morty Schapiro
            I heard a gunshot and then saw a man run out. 
            He had a "Get Fit Now Gym" bag. 
            The membership number on the bag started with "48Z". 
            Only gold members have those bags. 
            The man got into a car with a plate that included "H42W".
*/