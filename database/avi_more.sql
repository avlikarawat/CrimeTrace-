
USE CrimeTrace;

DELIMITER $$

-- 1. STORED PROCEDURE
-- Retrieve details of a particular case

CREATE PROCEDURE GetCaseDetails(IN p_case_id INT)
BEGIN
    SELECT c.case_id, c.crime_type, c.status,
           c.date_reported, c.description,
           l.city, l.area
    FROM crime_case c
    JOIN Location l
    ON c.location_id = l.location_id
    WHERE c.case_id = p_case_id;
END $$

-- 2. FUNCTION
-- Calculate how many days a case has remained open

CREATE FUNCTION CalculateCaseDays(p_case_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE total_days INT;

    SELECT DATEDIFF(
        COALESCE(date_closed, CURDATE()),
        date_reported
    )
    INTO total_days
    FROM crime_case
    WHERE case_id = p_case_id;

    RETURN total_days;
END $$

DELIMITER ;

-- Execute procedure
CALL GetCaseDetails(1001);

-- Execute function
SELECT CalculateCaseDays(1001);

DELIMITER $$

-- 3. TRIGGER
-- Prevent invalid case closing dates

CREATE TRIGGER ValidateCaseClosingDate
BEFORE UPDATE ON crime_case
FOR EACH ROW
BEGIN
    IF NEW.date_closed IS NOT NULL
       AND NEW.date_closed < NEW.date_reported THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Closing date cannot be earlier than reporting date';

    END IF;
END $$

DELIMITER ;

-- 4. TRANSACTION DEMONSTRATION

START TRANSACTION;

UPDATE crime_case
SET status = 'Closed',
    date_closed = '2026-03-01'
WHERE case_id = 1001;

-- Check the change
SELECT * FROM crime_case WHERE case_id = 1001;

-- Save the changes
COMMIT;

-- Example rollback demonstration
START TRANSACTION;

UPDATE crime_case
SET status = 'Open',
    date_closed = NULL
WHERE case_id = 1001;

-- Undo this temporary change
ROLLBACK;