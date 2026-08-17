/*

Find the companies that have the most job openings.
Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS (
        SELECT
            company_id,
            COUNT(*)
        FROM 
            job_postings_fact
        GROUP BY
            company_id
)

SELECT *
FROM company_job_count;

---- Extended
WITH company_job_count AS (
        SELECT
            company_id,
            COUNT(*)
        FROM 
            job_postings_fact
        GROUP BY
            company_id
)

SELECT name 
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id;


--3rd extension
WITH company_job_count AS (
        SELECT
            company_id,
            COUNT(*) AS total_jobs
        FROM 
            job_postings_fact
        GROUP BY
            company_id
)

SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC;

/*
Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to
find the skill IDs with the highest counts in the skills_job_dim table and then join this result
with the skills_dim table to get the skill names.
*/

WITH skill_count AS (
        SELECT
            skill_id,
            COUNT(*) AS total_skill_count
        FROM 
            skills_job_dim
        GROUP BY
            skill_id
)

SELECT 
        skills_dim.skills,
        skill_count.total_skill_count
FROM 
        skills_dim
LEFT JOIN skill_count ON skill_count.skill_id = skills_dim.skill_id
ORDER BY
        skill_count.total_skill_count DESC
LIMIT 5;

/*
Determine the size category ('Small', 'Medium', or 'Large') for each company by first identifying
the number of job postings they have. Use a subquery to calculate the total job postings per
company. A company is considered 'Small' if it has less than 10 job postings, 'Medium' if the
number of job postings is between 10 and 50, and 'Large' if it has more than 50 job postings.
Implement a subquery to aggregate job counts per company before classifying them based on
size.
*/

with job_count AS (
        SELECT
        company_id,
        COUNT(*) AS total_job_count
        FROM job_postings_fact
        GROUP BY
        company_id
)

SELECT 
        company_dim.name,
        job_count.total_job_count,
         CASE
                WHEN total_job_count < 10 THEN 'small'
                WHEN total_job_count BETWEEN 10 AND 50 THEN 'Midium'
                ELSE 'Large'
        END AS job_count_category
FROM
        company_dim
LEFT JOIN job_count ON job_count.company_id = company_dim.company_id
ORDER BY 
    job_count.total_job_count DESC;


/*
Find the count of the number of remote job postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include skill ID, name, and count of postings requiring the skill
*/
WITH remote_job_skills AS (
SELECT
        -- job_postings.job_id,
        skill_id,
        -- job_postings.job_work_from_home
        COUNT(*) AS skill_count
FROM
        skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_postings ON job_postings.job_id = skills_to_job.job_id
WHERE
        job_postings.job_work_from_home = True 
        AND job_title_short = 'Data Analyst'
GROUP BY
        skill_id
)    

SELECt 
        skill.skill_id,
        skill.skills,
        remote_job_skills.skill_count
FROM remote_job_skills
INNER JOIN skills_dim AS skill ON skill.skill_id = remote_job_skills.skill_id
ORDER BY
        remote_job_skills.skill_count DESC
LIMIT 5;
