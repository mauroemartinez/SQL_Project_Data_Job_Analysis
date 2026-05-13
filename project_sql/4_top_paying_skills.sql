/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

USE data_job_analysis;
SELECT TOP 25
	skills_dim.skills,
	ROUND(AVG(salary_year_avg), 2) AS avg_salary,
	COUNT(job_postings_fact.job_id) AS demand_count
FROM
	job_postings_fact
INNER JOIN
	skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
	skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
	job_title_short = 'Data Analyst' AND
	salary_year_avg IS NOT NULL AND
	job_work_from_home = 1
GROUP BY
	skills_dim.skills
ORDER BY
	avg_salary DESC;
-- General Avg: 123268.835027 - Remoet increases to: 131779.223648
-- Avg Data Analyst: 93875.810177 - Remote increases to: 94769.874172
-- Avg Data Engineer: 130266.883122 - Remote increases  to: 132363.575033
-- Avg Data Scientist: 135929.504893 - Remote increases to: 144398.258132