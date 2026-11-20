
USE CrimeTrace;

-- 1. LOCATION
CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    address VARCHAR(200) NOT NULL,
    area VARCHAR(100),
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7)
) ENGINE=InnoDB;

-- 2. CRIME CASE
CREATE TABLE crime_case (
    case_id INT PRIMARY KEY,
    crime_type VARCHAR(60) NOT NULL,
    date_reported DATE NOT NULL,
    date_closed DATE,
    status VARCHAR(30) DEFAULT 'Open',
    description TEXT,
    location_id INT NOT NULL,

    CONSTRAINT fk_case_location
        FOREIGN KEY (location_id)
        REFERENCES Location(location_id),

    CONSTRAINT chk_case_dates
        CHECK (date_closed IS NULL OR date_closed >= date_reported),

    CONSTRAINT chk_case_status
        CHECK (status IN ('Open', 'Under Investigation', 'Closed'))
) ENGINE=InnoDB;

-- 3. PERSON
CREATE TABLE Person (
    person_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(20),
    address VARCHAR(200),
    phone VARCHAR(15),
    date_of_birth DATE,

    CONSTRAINT chk_person_age
        CHECK (age IS NULL OR age BETWEEN 0 AND 120)
) ENGINE=InnoDB;

-- 4. SUSPECT
CREATE TABLE Suspect (
    person_id INT PRIMARY KEY,
    criminal_record TEXT,
    wanted_status VARCHAR(30) DEFAULT 'Not Wanted',
    notes TEXT,

    FOREIGN KEY (person_id)
        REFERENCES Person(person_id)
) ENGINE=InnoDB;

-- 5. WITNESS
CREATE TABLE Witness (
    person_id INT PRIMARY KEY,
    statement TEXT,
    witness_type VARCHAR(50),
    reliability_score DECIMAL(3,2),

    CONSTRAINT fk_witness_person
        FOREIGN KEY (person_id)
        REFERENCES Person(person_id),

    CONSTRAINT chk_reliability
        CHECK (reliability_score IS NULL OR
               reliability_score BETWEEN 0 AND 10)
) ENGINE=InnoDB;

-- 6. VICTIM
CREATE TABLE Victim (
    victim_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender VARCHAR(20),
    contact VARCHAR(15),
    address VARCHAR(200),
    case_id INT NOT NULL,
    relation VARCHAR(50),

    FOREIGN KEY (case_id)
        REFERENCES crime_case(case_id)
) ENGINE=InnoDB;

-- 7. INFORMANT
CREATE TABLE Informant (
    informant_id INT PRIMARY KEY,
    source_type VARCHAR(50),
    notes TEXT,
    person_id INT UNIQUE,

    FOREIGN KEY (person_id)
        REFERENCES Person(person_id)
) ENGINE=InnoDB;

-- 8. CASE_PERSON
CREATE TABLE Case_Person (
    case_id INT,
    person_id INT,
    role_in_case VARCHAR(30) NOT NULL,

    PRIMARY KEY (case_id, person_id),

    FOREIGN KEY (case_id)
        REFERENCES crime_case(case_id),

    FOREIGN KEY (person_id)
        REFERENCES Person(person_id),

    CONSTRAINT chk_role
        CHECK (role_in_case IN
        ('Suspect', 'Witness', 'Informant'))
);