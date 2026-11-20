
USE CrimeTrace;

-- LOCATIONS
INSERT INTO Location VALUES
(1, 'Sector 18 Market', 'Sector 18', 'Noida', 'Uttar Pradesh', 28.5708, 77.3260),
(2, 'Connaught Place', 'Central Delhi', 'Delhi', 'Delhi', 28.6315, 77.2167),
(3, 'Indirapuram Market', 'Indirapuram', 'Ghaziabad', 'Uttar Pradesh', 28.6410, 77.3710),
(4, 'Sector 62', 'Sector 62', 'Noida', 'Uttar Pradesh', 28.6270, 77.3640),
(5, 'Laxmi Nagar', 'East Delhi', 'Delhi', 'Delhi', 28.6300, 77.2770);

-- CRIME CASES
INSERT INTO crime_case VALUES
(1001, 'Theft', '2026-01-10', NULL, 'Under Investigation', 'Reported theft at a shopping complex', 1),
(1002, 'Cybercrime', '2026-01-15', NULL, 'Open', 'Online financial fraud complaint', 2),
(1003, 'Fraud', '2026-01-20', '2026-02-10', 'Closed', 'Reported financial fraud', 3),
(1004, 'Burglary', '2026-02-01', NULL, 'Under Investigation', 'Residential burglary complaint', 4),
(1005, 'Theft', '2026-02-05', NULL, 'Open', 'Missing electronic equipment', 5);

-- PEOPLE
INSERT INTO Person VALUES
(201, 'Aarav Mehta', 25, 'Male', 'Noida', '9876500001', '2001-03-12'),
(202, 'Riya Sharma', 28, 'Female', 'Delhi', '9876500002', '1998-07-21'),
(203, 'Kabir Verma', 32, 'Male', 'Ghaziabad', '9876500003', '1994-04-15'),
(204, 'Ananya Singh', 24, 'Female', 'Noida', '9876500004', '2002-01-08'),
(205, 'Dev Malhotra', 30, 'Male', 'Delhi', '9876500005', '1996-06-18'),
(206, 'Meera Kapoor', 27, 'Female', 'Noida', '9876500006', '1999-09-10');

-- SUSPECTS
INSERT INTO Suspect VALUES
(201, 'No previous record', 'Not Wanted', 'Under verification'),
(203, 'Previous fraud complaint', 'Wanted', 'Investigation ongoing');

-- WITNESSES
INSERT INTO Witness VALUES
(202, 'Observed the incident near the market', 'Eyewitness', 8.50),
(204, 'Provided information about the incident', 'Local Witness', 7.50);

-- VICTIMS
INSERT INTO Victim VALUES
(301, 'Neha Gupta', 26, 'Female', '9876510001', 'Noida', 1001, 'Complainant'),
(302, 'Rahul Jain', 35, 'Male', '9876510002', 'Delhi', 1002, 'Complainant'),
(303, 'Simran Kaur', 29, 'Female', '9876510003', 'Ghaziabad', 1003, 'Complainant');

-- INFORMANTS
INSERT INTO Informant VALUES
(401, 'Confidential Source', 'Provided information regarding case', 205),
(402, 'Local Source', 'Shared relevant observations', 206);

-- CASE PERSON RELATIONSHIPS
INSERT INTO Case_Person VALUES
(1001, 201, 'Suspect'),
(1001, 202, 'Witness'),
(1002, 203, 'Suspect'),
(1003, 204, 'Witness'),
(1004, 205, 'Informant'),
(1005, 206, 'Informant');