USE data_job_analysis
BULK INSERT company_dim
FROM 'C:\Users\siqui\OneDrive\Escritorio\Mauro\Portafolio\Luke Barousse - SQL Courses\csv_files\company_dim.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,        
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '0x0a'
);
BULK INSERT skills_dim
FROM 'C:\Users\siqui\OneDrive\Escritorio\Mauro\Portafolio\Luke Barousse - SQL Courses\csv_files\skills_dim.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,         
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '0x0a'
);
-- As data comes as TRUE or FALSE isntead of 1 or 0, I will alter the columns to VARCHAR
ALTER TABLE job_postings_fact
ALTER COLUMN job_no_degree_mention VARCHAR(MAX);
ALTER TABLE job_postings_fact
ALTER COLUMN job_health_insurance VARCHAR(MAX);
BULK INSERT job_postings_fact
FROM 'C:\Users\siqui\OneDrive\Escritorio\Mauro\Portafolio\Luke Barousse - SQL Courses\csv_files\job_postings_fact.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,        
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '0x0a'
);
-- If FALSE then 0 if TRUE then 1, then convert to bit
UPDATE job_postings_fact
SET 
    job_work_from_home = CASE WHEN job_work_from_home = 'TRUE' THEN '1' ELSE '0' END,
    job_no_degree_mention = CASE WHEN job_no_degree_mention = 'TRUE' THEN '1' ELSE '0' END,
    job_health_insurance = CASE WHEN job_health_insurance = 'TRUE' THEN '1' ELSE '0' END;
ALTER TABLE job_postings_fact ALTER COLUMN job_work_from_home BIT;
ALTER TABLE job_postings_fact ALTER COLUMN job_no_degree_mention BIT;
ALTER TABLE job_postings_fact ALTER COLUMN job_health_insurance BIT;
;
BULK INSERT skills_job_dim
FROM 'C:\Users\siqui\OneDrive\Escritorio\Mauro\Portafolio\Luke Barousse - SQL Courses\csv_files\skills_job_dim.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,         
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '0x0a'
);