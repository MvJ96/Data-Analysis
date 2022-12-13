SELECT 
p.name,
i.transcript
FROM person p
JOIN interview i
ON i.person_id = p.id
WHERE p.address_street_name = 'Franklin Ave'
AND name LIKE '%Annabel%'

/*  RESULT
    NAME :  Annabel Miller
            I saw the murder happen, 
            and I recognized the killer from my gym 
            when I was working out last week on January the 9th.
*/