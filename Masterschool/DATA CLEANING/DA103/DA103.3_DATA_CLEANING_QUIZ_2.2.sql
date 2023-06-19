/* From the accounts table, display the name of the client, 
the coordinate as concatenated (latitude, longitude), 
email id of the primary point of contact as 
<first letter of the primary_poc><last letter of the primary_poc>
@<extracted name and domain from the website> */

/*Answer*/
SELECT 
a.name AS client_name,
CONCAT(a.lat, ',', a.long) AS coordinate,
CONCAT(LEFT(a.primary_poc,1), RIGHT(a.primary_poc,1), '@', SUBSTRING(a.website, 5)) AS EMAIL
FROM accounts a