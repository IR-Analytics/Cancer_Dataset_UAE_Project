USE healthcare;

CREATE TABLE cancer_patients_uae (
    Patient_ID VARCHAR(20),
    Age INT,
    Gender VARCHAR(10),
    Nationality VARCHAR(50),
    Emirate VARCHAR(50),
    Diagnosis_Date DATE,
    Cancer_Type VARCHAR(100),
    Cancer_Stage VARCHAR(10),
    Treatment_Type VARCHAR(50),
    Treatment_Start_Date DATE,
    Hospital VARCHAR(100),
    Primary_Physician VARCHAR(50),
    Outcome VARCHAR(50),
    Death_Date VARCHAR(20),
    Cause_of_Death VARCHAR(100),
    Smoking_Status VARCHAR(50),
    Comorbidities VARCHAR(100),
    Ethnicity VARCHAR(50),
    Weight FLOAT,
    Height FLOAT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/_cancer_dataset_uae.csv'
INTO TABLE healthcare.cancer_patients_uae
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT Patient_ID, COUNT(*) 
FROM cancer_patients_uae 
GROUP BY Patient_ID 
HAVING COUNT(*) > 1;

-- To create another table with only unique rows
CREATE TABLE cancer_patients_dedup AS
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY Patient_ID ORDER BY Diagnosis_Date DESC) AS row_num
    FROM cancer_patients_uae
) AS temp_table
WHERE row_num = 1;

SELECT Patient_ID, COUNT(*) 
FROM cancer_patients_dedup 
GROUP BY Patient_ID 
HAVING COUNT(*) > 1;

SELECT * FROM cancer_patients_dedup
WHERE Age IS NULL OR Age NOT REGEXP '^[0-9]+$';

SELECT * FROM cancer_patients_dedup
WHERE Weight IS NULL OR Weight NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

SELECT * FROM cancer_patients_dedup
WHERE Height IS NULL OR Height NOT REGEXP '^[0-9]+(\.[0-9]+)?$';

SELECT * FROM cancer_patients_dedup
WHERE Diagnosis_Date IS NULL
   OR Treatment_Start_Date IS NULL;
   
   -- To convert 'N/A' to NULL
UPDATE cancer_patients_dedup
SET Death_Date = NULL
WHERE Death_Date IN ('N/A', 'Unknown', '');

UPDATE cancer_patients_dedup
SET Cause_of_Death = NULL
WHERE Cause_of_Death IN ('N/A', 'Unknown', '');

SELECT COUNT(*) AS total_rows FROM cancer_patients_dedup;

SHOW COLUMNS FROM cancer_patients_dedup;

ALTER TABLE cancer_patients_dedup ADD Clean_Death_Date DATE;

UPDATE cancer_patients_dedup
SET Clean_Death_Date = STR_TO_DATE(Death_Date, '%d/%m/%Y')
WHERE Death_Date REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$';

UPDATE cancer_patients_dedup
SET Clean_Death_Date = Death_Date
WHERE Death_Date REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$';

ALTER TABLE cancer_patients_dedup
DROP COLUMN Death_Date;

ALTER TABLE cancer_patients_dedup
CHANGE Clean_Death_Date Death_Date DATE;

ALTER TABLE cancer_patients_dedup
MODIFY COLUMN Death_Date DATE
AFTER Outcome;

SHOW COLUMNS FROM cancer_patients_dedup;


-- To view variations
SELECT DISTINCT Smoking_Status FROM cancer_patients_dedup;

#To fix inconsistent casing or spelling
UPDATE cancer_patients_dedup
SET Smoking_Status = 'Non-Smoker'
WHERE Smoking_Status IN ('non smoker', 'non-smoker', 'Non smoker');

SELECT DISTINCT Gender FROM cancer_patients_dedup;

SELECT DISTINCT Comorbidities FROM cancer_patients_dedup;

SELECT DISTINCT Cancer_Type FROM cancer_patients_dedup;

#Check for odd ages
SELECT * FROM cancer_patients_dedup WHERE Age < 0 OR Age > 120;

#Height/Weight sanity check
SELECT * FROM cancer_patients_dedup WHERE Height < 50 OR Height > 250;
SELECT * FROM cancer_patients_dedup WHERE Weight < 20 OR Weight > 300;

ALTER TABLE cancer_patients_dedup
DROP COLUMN row_num;

#Total cleaned rows
SELECT COUNT(*) FROM cancer_patients_dedup;

#Spot check
SELECT * FROM cancer_patients_dedup LIMIT 10;



SELECT * FROM cancer_patients_dedup;