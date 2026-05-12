-- Create company_dim table with primary key
CREATE TABLE company_dim
(
    company_id INT PRIMARY KEY,
    name VARCHAR(MAX),
    link VARCHAR(MAX),
    link_google VARCHAR(MAX),
    thumbnail VARCHAR(MAX)
);

-- Create skills_dim table with primary key
CREATE TABLE skills_dim
(
    skill_id INT PRIMARY KEY,
    skills VARCHAR(MAX),
    type VARCHAR(MAX)
);

-- Create job_postings_fact table with primary key
CREATE TABLE job_postings_fact
(
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short VARCHAR(255),
    job_title VARCHAR(MAX),
    job_location VARCHAR(MAX),
    job_via VARCHAR(MAX),
    job_schedule_type VARCHAR(MAX),
    job_work_from_home NVARCHAR(MAX),
    search_location VARCHAR(MAX),
    job_posted_date DATETIME,
    job_no_degree_mention BIT,
    job_health_insurance BIT,
    job_country VARCHAR(MAX),
    salary_rate VARCHAR(MAX),
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES company_dim (company_id)
);

-- Create skills_job_dim table with a composite primary key and foreign keys
CREATE TABLE skills_job_dim
(
    job_id INT,
    skill_id INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES job_postings_fact (job_id),
    FOREIGN KEY (skill_id) REFERENCES skills_dim (skill_id)
);