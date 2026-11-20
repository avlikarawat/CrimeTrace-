
USE CrimeTrace;

-- 1. INVESTIGATORS
INSERT INTO Investigator VALUES
(301, 'Rajiv Khanna', 'Inspector', '9811100001',
 'rajiv@example.com', 'Crime Branch', 12),

(302, 'Priya Nair', 'Sub Inspector', '9811100002',
 'priya@example.com', 'Cyber Cell', 6),

(303, 'Amit Verma', 'Inspector', '9811100003',
 'amit@example.com', 'Investigation Unit', 9),

(304, 'Sneha Rao', 'Sub Inspector', '9811100004',
 'sneha@example.com', 'Crime Branch', 5);


-- 2. FORENSIC LABS
INSERT INTO Forensic_Lab VALUES
(601, 'Central Forensic Lab', 'Digital Forensics', '01122000001'),
(602, 'Regional Forensic Lab', 'Fingerprint Analysis', '01122000002'),
(603, 'Cyber Analysis Lab', 'Cyber Investigation', '01122000003');


-- 3. EVIDENCE STORAGE
INSERT INTO Evidence_Storage VALUES
(701, 'Secure Locker', 'Noida Evidence Room', 100),
(702, 'Digital Storage', 'Delhi Cyber Unit', 500),
(703, 'Physical Archive', 'Ghaziabad Record Room', 200);


-- 4. CASE INVESTIGATOR
INSERT INTO Case_Investigator VALUES
(1001, 301, 'Lead Investigator', '2026-01-11'),
(1001, 303, 'Supporting Investigator', '2026-01-12'),
(1002, 302, 'Lead Investigator', '2026-01-16'),
(1003, 304, 'Lead Investigator', '2026-01-21'),
(1004, 301, 'Lead Investigator', '2026-02-02'),
(1005, 303, 'Supporting Investigator', '2026-02-06');


-- 5. CHARGES
INSERT INTO Charge VALUES
(501, 'Theft', 'Filed', NULL, 1001),
(502, 'Cyber Fraud', 'Filed', NULL, 1002),
(503, 'Financial Fraud', 'Disposed', 'Guilty', 1003),
(504, 'Burglary', 'Under Review', NULL, 1004);


-- 6. CHARGE PERSON
INSERT INTO Charge_Person VALUES
(501, 201, '2026-01-20'),
(502, 203, '2026-01-25'),
(503, 204, '2026-01-28');


-- 7. EVIDENCE
INSERT INTO Evidence VALUES
(401, 'CCTV footage from shopping complex',
 'Digital', '2026-01-11', 'Sector 18 Market',
 'evidence/cctv401.txt', 1001, 702),

(402, 'Fingerprint report sample',
 'Physical', '2026-01-12', 'Shopping Complex',
 'evidence/fingerprint402.txt', 1001, 701),

(403, 'Online transaction records',
 'Digital', '2026-01-16', 'Online Platform',
 'evidence/transaction403.txt', 1002, 702),

(404, 'Financial document copies',
 'Document', '2026-01-22', 'Indirapuram',
 'evidence/documents404.txt', 1003, 703),

(405, 'Entry camera recording',
 'Digital', '2026-02-02', 'Sector 62',
 'evidence/camera405.txt', 1004, 702),

(406, 'Recovered electronic device',
 'Physical', '2026-02-06', 'Laxmi Nagar',
 'evidence/device406.txt', 1005, 701);


-- 8. EVIDENCE ANALYSIS
INSERT INTO Evidence_Analysis VALUES
(401, 601, '2026-01-13'),
(402, 602, '2026-01-14'),
(403, 603, '2026-01-18'),
(404, 601, '2026-01-25'),
(405, 602, '2026-02-04');


-- 9. COURT CASES
INSERT INTO Court_Case VALUES
(801, 'CT-2026-001', NULL, NULL, 1001),
(802, 'CT-2026-002', NULL, NULL, 1002),
(803, 'CT-2026-003', 'Guilty',
 'As decided by court', 1003);


-- VERIFY INSERTED DATA
SELECT * FROM Investigator;
SELECT * FROM Evidence;
SELECT * FROM Charge;
SELECT * FROM Court_Case;
