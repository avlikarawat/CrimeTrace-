
USE CrimeTrace;

-- 1. INVESTIGATOR
CREATE TABLE Investigator (
    investigator_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
   'rank' VARCHAR(50),
    phone VARCHAR(15),
    email VARCHAR(100) UNIQUE,
    department VARCHAR(100),
    years_experience INT,

    CHECK (years_experience IS NULL OR years_experience >= 0)
) ENGINE=InnoDB;


-- 2. FORENSIC LAB
CREATE TABLE Forensic_Lab (
    lab_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(60),
    contact VARCHAR(15)
) ENGINE=InnoDB;


-- 3. EVIDENCE STORAGE
CREATE TABLE Evidence_Storage (
    storage_id INT PRIMARY KEY,
    storage_type VARCHAR(50),
    location VARCHAR(100),
    capacity INT,

    CHECK (capacity IS NULL OR capacity >= 0)
) ENGINE=InnoDB;


-- 4. CASE INVESTIGATOR
CREATE TABLE Case_Investigator (
    case_id INT,
    investigator_id INT,
    role VARCHAR(50),
    assignment_date DATE,

    PRIMARY KEY (case_id, investigator_id),

    FOREIGN KEY (case_id)
        REFERENCES crime_case(case_id),

    FOREIGN KEY (investigator_id)
        REFERENCES Investigator(investigator_id)
) ENGINE=InnoDB;


-- 5. CHARGE
CREATE TABLE Charge (
    charge_id INT PRIMARY KEY,
    charge_type VARCHAR(100) NOT NULL,
    charge_status VARCHAR(50),
    verdict VARCHAR(100),
    case_id INT NOT NULL,

    FOREIGN KEY (case_id)
        REFERENCES crime_case(case_id)
) ENGINE=InnoDB;


-- 6. CHARGE PERSON
CREATE TABLE Charge_Person (
    charge_id INT,
    person_id INT,
    filing_date DATE,

    PRIMARY KEY (charge_id, person_id),

    FOREIGN KEY (charge_id)
        REFERENCES Charge(charge_id),

    FOREIGN KEY (person_id)
        REFERENCES Person(person_id)
) ENGINE=InnoDB;


-- 7. EVIDENCE
CREATE TABLE Evidence (
    evidence_id INT PRIMARY KEY,
    description TEXT,
    evidence_type VARCHAR(60),
    collection_date DATE,
    location_found VARCHAR(150),
    file_path VARCHAR(255),
    case_id INT NOT NULL,
    storage_id INT,

    FOREIGN KEY (case_id)
        REFERENCES crime_case(case_id),

    FOREIGN KEY (storage_id)
        REFERENCES Evidence_Storage(storage_id)
) ENGINE=InnoDB;


-- 8. EVIDENCE ANALYSIS
CREATE TABLE Evidence_Analysis (
    evidence_id INT,
    lab_id INT,
    analysis_date DATE,

    PRIMARY KEY (evidence_id, lab_id),

    FOREIGN KEY (evidence_id)
        REFERENCES Evidence(evidence_id),

    FOREIGN KEY (lab_id)
        REFERENCES Forensic_Lab(lab_id)
) ENGINE=InnoDB;


-- 9. COURT CASE
CREATE TABLE Court_Case (
    court_id INT PRIMARY KEY,
    case_number VARCHAR(50) UNIQUE,
    verdict VARCHAR(100),
    sentence VARCHAR(200),
    case_id INT UNIQUE NOT NULL,

    FOREIGN KEY (case_id)
        REFERENCES crime_case(case_id)
) ENGINE=InnoDB;


-- VERIFY TABLE CREATION
SHOW TABLES;
