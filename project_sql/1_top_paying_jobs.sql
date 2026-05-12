/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/
USE data_job_analysis

SELECT 
[job_id]
FROM
[data_job_analysis].[dbo].[job_postings_fact]

-- filter remote
-- filter data analyst