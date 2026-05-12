/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/
USE data_job_analysis;
WITH top_ten_data_analysis_jobs AS (
	SELECT TOP 10 
		postings.job_id,
		postings.job_title,
		company_dim.name AS company_name,
		postings.job_schedule_type,
		postings.salary_year_avg,
		CAST(postings.job_posted_date AS DATE) as date
	FROM
		job_postings_fact AS postings
	LEFT JOIN
		company_dim ON postings.company_id = company_dim.company_id
	WHERE
		job_location = 'Anywhere' AND
		job_title_short = 'Data Analyst' AND
		salary_year_avg IS NOT NULL
	ORDER BY
		postings.salary_year_avg DESC
)
SELECT
	CAST(
		AVG(top_ten_data_analysis_jobs.salary_year_avg) AS
		DECIMAL (10,2)
		) AS 'Top 10 Job Posts Yearly Salary AVG'
FROM
	top_ten_data_analysis_jobs;
-- Total AVG
SELECT AVG (salary_year_avg) AS 'Total Yearly Salary AVG' FROM job_postings_fact;
-- Data Analyst AVG
SELECT AVG (salary_year_avg) AS 'General Data Analyst Yearly Salary AVG' FROM job_postings_fact WHERE job_title_short = 'Data Analyst'

/*
ANALYSIS SUMMARY: TOP PAYING DATA ANALYST JOBS
==============================================

1. The "Elite Top 10" ($264,506.20): 
   The average salary for the top 10 highest-paying remote ("Anywhere") roles 
   is massive. This figure represents the market ceiling and is typically 
   associated with advanced seniority (Lead, Principal) or niche specialization.

2. The "Remote Premium" ($123,268.84):
   The overall average for all remote roles in this dataset reflects a clear 
   correlation between geographical flexibility and salary competitiveness.

3. The Industry Baseline ($93,875.81):
   This is the global average for 'Data Analyst' roles without location filters. 
   The ~182% gap between the baseline and the Top 10 highlights the massive 
   scalability potential for analysts who transition into high-level technical roles.

STRATEGIC CONCLUSION:
To bridge the gap from $93k to $200k+, the focus must be on mastering 
high-level data engineering stacks (such as Microsoft Fabric and Advanced SQL) 
and targeting the global remote market where location is not a constraint.
*/