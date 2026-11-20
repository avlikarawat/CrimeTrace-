
USE CrimeTrace;

-- REMOVE OLD PROCEDURES IF THEY EXIST
DROP PROCEDURE IF EXISTS GetCaseEvidence;
DROP PROCEDURE IF EXISTS EvidenceProcessingSummary;

DELIMITER $$


-- 1. STORED PROCEDURE
-- Retrieve evidence for a particular case

CREATE PROCEDURE GetCaseEvidence(IN p_case_id INT)
BEGIN
    SELECT
        evidence_id,
        description,
        evidence_type,
        collection_date,
        location_found
    FROM Evidence
    WHERE case_id = p_case_id;
END $$

DELIMITER ;

-- EXECUTE PROCEDURE
CALL GetCaseEvidence(1001);


DELIMITER $$


-- 2. CURSOR
-- Count analysed and pending evidence

CREATE PROCEDURE EvidenceProcessingSummary(IN p_case_id INT)
BEGIN
    DECLARE finished INT DEFAULT 0;
    DECLARE current_evidence INT;

    DECLARE total_count INT DEFAULT 0;
    DECLARE analysed_count INT DEFAULT 0;

    DECLARE evidence_cursor CURSOR FOR
        SELECT evidence_id
        FROM Evidence
        WHERE case_id = p_case_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET finished = 1;

    OPEN evidence_cursor;

    evidence_loop: LOOP

        FETCH evidence_cursor INTO current_evidence;

        IF finished = 1 THEN
            LEAVE evidence_loop;
        END IF;

        SET total_count = total_count + 1;

        IF EXISTS (
            SELECT 1
            FROM Evidence_Analysis
            WHERE evidence_id = current_evidence
        ) THEN
            SET analysed_count = analysed_count + 1;
        END IF;

    END LOOP;

    CLOSE evidence_cursor;

    SELECT
        p_case_id AS case_id,
        total_count AS total_evidence,
        analysed_count AS analysed_evidence,
        (total_count - analysed_count) AS pending_evidence;

END $$

DELIMITER ;

-- EXECUTE CURSOR PROCEDURE
CALL EvidenceProcessingSummary(1001);


DELIMITER $$


-- 3. TRIGGER
-- Prevent future evidence collection dates

DROP TRIGGER IF EXISTS ValidateEvidenceDate;

CREATE TRIGGER ValidateEvidenceDate
BEFORE INSERT ON Evidence
FOR EACH ROW
BEGIN

    IF NEW.collection_date > CURDATE() THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
        'Evidence collection date cannot be in the future';

    END IF;

END $$

DELIMITER ;


-- 4. TRANSACTION
-- Demonstrate COMMIT

START TRANSACTION;

UPDATE Evidence
SET storage_id = 703
WHERE evidence_id = 401;

SELECT * FROM Evidence
WHERE evidence_id = 401;

COMMIT;


-- DEMONSTRATE ROLLBACK

START TRANSACTION;

UPDATE Evidence
SET storage_id = 701
WHERE evidence_id = 401;

SELECT * FROM Evidence
WHERE evidence_id = 401;

ROLLBACK;


-- CHECK FINAL VALUE
SELECT * FROM Evidence
WHERE evidence_id = 401;
