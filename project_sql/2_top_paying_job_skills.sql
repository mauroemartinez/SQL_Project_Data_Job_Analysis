/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
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
	top_ten_data_analysis_jobs.*,
	skills
FROM
	top_ten_data_analysis_jobs
INNER JOIN
	skills_job_dim AS skills_job ON  top_ten_data_analysis_jobs.job_id = skills_job.job_id
INNER JOIN
	skills_dim AS skills ON skills.skill_id = skills_job.skill_id 
ORDER BY
	salary_year_avg
/*
| Skill     | Frequency |
| --------- | --------: |
| SQL       |         8 |
| Python    |         7 |
| Tableau   |         6 |
| R         |         4 |
| Snowflake |         3 |
| Pandas    |         3 |
| Excel     |         3 |

Key Insights


SQL and Python were the most in-demand skills across top-paying remote Data Analyst roles.


Tableau appeared more frequently than Power BI in high-salary positions.


The highest salaries were tied to roles with strong business impact, leadership, and strategic decision-making.


Modern analyst jobs increasingly require knowledge of cloud and data stack tools like Snowflake, AWS, and Azure.


Specialized analysts (marketing, insights, performance analytics) earned significantly more than generalist roles.


The dataset shows that top Data Analysts combine technical skills + business understanding + communication.


*/