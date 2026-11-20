
USE CrimeTrace;

-- 1. DISPLAY ALL INVESTIGATORS
SELECT * FROM Investigator;


-- 2. DISPLAY ALL EVIDENCE
SELECT * FROM Evidence;


-- 3. EVIDENCE WITH CRIME CASE DETAILS
SELECT
    e.evidence_id,
    e.evidence_type,
    e.description,
    c.case_id,
    c.crime_type
FROM Evidence e
JOIN crime_case c
ON e.case_id = c.case_id;


-- 4. INVESTIGATORS ASSIGNED TO EACH CASE
SELECT
    c.case_id,
    c.crime_type,
    i.name,
    ci.role
FROM Case_Investigator ci
JOIN Investigator i
ON ci.investigator_id = i.investigator_id
JOIN crime_case c
ON ci.case_id = c.case_id;


-- 5. COUNT EVIDENCE FOR EACH CASE
SELECT
    case_id,
    COUNT(*) AS total_evidence
FROM Evidence
GROUP BY case_id;


-- 6. CASES HAVING MORE THAN ONE INVESTIGATOR
SELECT
    case_id,
    COUNT(investigator_id) AS investigator_count
FROM Case_Investigator
GROUP BY case_id
HAVING COUNT(investigator_id) > 1;


-- 7. EVIDENCE AND ITS FORENSIC LAB
SELECT
    e.evidence_id,
    e.evidence_type,
    f.name AS laboratory,
    ea.analysis_date
FROM Evidence e
JOIN Evidence_Analysis ea
ON e.evidence_id = ea.evidence_id
JOIN Forensic_Lab f
ON ea.lab_id = f.lab_id;


-- 8. EVIDENCE NOT YET ANALYSED
SELECT *
FROM Evidence e
WHERE NOT EXISTS (
    SELECT 1
    FROM Evidence_Analysis ea
    WHERE ea.evidence_id = e.evidence_id
);


-- 9. INVESTIGATORS WITH MORE THAN 5 YEARS EXPERIENCE
SELECT name, rank, years_experience
FROM Investigator
WHERE years_experience > 5;


-- 10. COURT RECORDS WITH CRIME CASE DETAILS
SELECT
    cc.court_id,
    cc.case_number,
    cc.verdict,
    c.crime_type,
    c.status
FROM Court_Case cc
JOIN crime_case c
ON cc.case_id = c.case_id;


-- 11. EVIDENCE STORAGE DETAILS
SELECT
    e.evidence_id,
    e.evidence_type,
    s.storage_type,
    s.location
FROM Evidence e
JOIN Evidence_Storage s
ON e.storage_id = s.storage_id;


-- 12. CREATE EVIDENCE VIEW
CREATE VIEW Evidence_Details AS
SELECT
    e.evidence_id,
    e.description,
    e.evidence_type,
    c.case_id,
    c.crime_type,
    s.storage_type
FROM Evidence e
JOIN crime_case c
ON e.case_id = c.case_id
LEFT JOIN Evidence_Storage s
ON e.storage_id = s.storage_id;


-- DISPLAY VIEW
SELECT * FROM Evidence_Details;
