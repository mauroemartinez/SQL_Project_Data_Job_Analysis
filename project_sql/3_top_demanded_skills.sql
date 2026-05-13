/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/
USE data_job_analysis;
-- calculate aggregated demand of skills for Data Analyst & Anywhere
WITH total_jobs_data_analyst_anywhere AS (
	SELECT
		COUNT(*) AS total_demand_count
	FROM
		job_postings_fact
	WHERE
		job_title_short = 'Data Analyst' AND job_location = 'Anywhere'
	),
-- calculate top 10 skills for Data Analyst & Anywhere
tops_skills_demand as (
SELECT TOP 10
	skills_dim.skills,
	COUNT(job_postings_fact.job_id) AS 'Demand Count',
	-- to calculate % we need to multiply the numerator 100 times, and it will be converted into a float number
	-- if you do not do this, SQL will think it's an INT and truncate it to 0
	CAST(ROUND(COUNT(job_postings_fact.job_id) * 100.0 / (SELECT total_demand_count FROM total_jobs_data_analyst_anywhere), 2) AS DECIMAL(5,2)) AS '% of Total'
FROM job_postings_fact
INNER JOIN
	skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN
	skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
	job_title_short = 'Data Analyst' AND job_location = 'Anywhere'
GROUP BY
	skills_dim.skills
ORDER BY
	[Demand Count] DESC
	)
SELECT * FROM tops_skills_demand
UNION ALL
SELECT 'Top 10 Total', SUM([Demand Count]), SUM([% of Total]/100) 
FROM tops_skills_demand;
-- 2.183 top 10 skillsare required from the top 10 on each job post