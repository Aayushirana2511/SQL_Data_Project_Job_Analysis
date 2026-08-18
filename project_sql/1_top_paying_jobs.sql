/*
Question: What are the top-paying data analyst jobs?
Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries (remove nulls).
Why? Highlight the top-paying opportunities for Data Analysts, offering insights into emp
-
*/

SELECT
        jpf.job_id,
        jpf.job_location,
        jpf.job_title,
        jpf.salary_year_avg,
        jpf.job_schedule_type,
        jpf.job_posted_date,
        company_dim.name AS company_name
FROM job_postings_fact AS jpf
LEFT JOIN company_dim ON company_dim.company_id= jpf.company_id
WHERE
        jpf.job_title_short = 'Data Analyst' AND
        jpf.job_location = 'Anywhere' AND
        jpf.salary_year_avg IS NOT NULL
ORDER BY
        jpf.salary_year_avg DESC
LIMIT 10;
