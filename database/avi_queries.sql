
USE CrimeTrace;

-- 1. Display all crime cases
SELECT * FROM crime_case;

-- 2. Display cases under investigation
SELECT *
FROM crime_case
WHERE status = 'Under Investigation';

-- 3. Display cases with their locations
SELECT c.case_id, c.crime_type, l.city, l.area
FROM crime_case c
INNER JOIN Location l
ON c.location_id = l.location_id;

-- 4. Count cases in each city
SELECT l.city, COUNT(c.case_id) AS total_cases
FROM Location l
JOIN crime_case c
ON l.location_id = c.location_id
GROUP BY l.city;

-- 5. Find cities having more than one case
SELECT l.city, COUNT(c.case_id) AS total_cases
FROM Location l
JOIN crime_case c
ON l.location_id = c.location_id
GROUP BY l.city
HAVING COUNT(c.case_id) > 1;

-- 6. Display suspects and their details
SELECT p.person_id, p.name, s.criminal_record,
       s.wanted_status
FROM Person p
JOIN Suspect s
ON p.person_id = s.person_id;

-- 7. Find people associated with a particular case
SELECT p.name, cp.role_in_case
FROM Case_Person cp
JOIN Person p
ON cp.person_id = p.person_id
WHERE cp.case_id = 1001;

-- 8. Find cases having at least one suspect
SELECT *
FROM crime_case c
WHERE EXISTS (
    SELECT 1
    FROM Case_Person cp
    WHERE cp.case_id = c.case_id
    AND cp.role_in_case = 'Suspect'
);

-- 9. Find cases without any associated people
SELECT *
FROM crime_case c
WHERE NOT EXISTS (
    SELECT 1
    FROM Case_Person cp
    WHERE cp.case_id = c.case_id
);

-- 10. Count victims in each case
SELECT case_id, COUNT(*) AS victim_count
FROM Victim
GROUP BY case_id;

-- 11. Create a view for case details
CREATE VIEW Case_Location_Details AS
SELECT c.case_id, c.crime_type, c.status,
       c.date_reported, l.city, l.area
FROM crime_case c
JOIN Location l
ON c.location_id = l.location_id;

-- Display the view
SELECT * FROM Case_Location_Details;