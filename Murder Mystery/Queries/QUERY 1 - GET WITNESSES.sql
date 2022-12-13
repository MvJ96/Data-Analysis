SELECT *
FROM crime_scene_report csr
WHERE csr.date = 20180115 AND type = 'murder' AND city = 'SQL City'

/*  RESULT
    Security footage shows that there were 2 witnesses. 
    The first witness lives at the last house on "Northwestern Dr". 
    The second witness, named Annabel, lives somewhere on "Franklin Ave".
*/