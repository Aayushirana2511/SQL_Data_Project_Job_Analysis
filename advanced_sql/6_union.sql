-- Get jobs and companies from January
SELECT
    job_title_short,
    job_id,
    job_location
FROM 
    january_jobs

UNION

-- Get jobs and companies from January
SELECT
    job_title_short,
    job_id,
    job_location
FROM 
    february_jobs

UNION

-- Get jobs and companies from January
SELECT
    job_title_short,
    job_id,
    job_location
FROM 
    march_jobs

/* Using UNION ALL */
-- Get jobs and companies from January
SELECT
    job_title_short,
    job_id,
    job_location
FROM 
    january_jobs

UNION ALL

-- Get jobs and companies from January
SELECT
    job_title_short,
    job_id,
    job_location
FROM 
    february_jobs

UNION ALL

-- Get jobs and companies from January
SELECT
    job_title_short,
    job_id,
    job_location
FROM 
    march_jobs

/*
using UNION and UNION ALL operator solve this: Get the corresponding skill and skill type for each job posting in q1
. Includes those without any skills, too
. Why? Look at the skills and the type for each job in the first quarter that has a salary >
$70,000
*/
-- Get skills and skill types for Q1 jobs earning more than $70,000

-- Part 1: Jobs that have skills
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    sd.skills,
    sd.type AS skill_type

FROM job_postings_fact AS jpf

INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id

WHERE
    jpf.job_posted_date BETWEEN '2023-01-01' AND '2023-03-31'
    AND jpf.salary_year_avg > 70000

UNION ALL

-- Part 2: Jobs that have NO skills
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.salary_year_avg,
    NULL AS skills,
    NULL AS skill_type

FROM job_postings_fact AS jpf

LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id

WHERE
    jpf.job_posted_date BETWEEN '2023-01-01' AND '2023-03-31'
    AND jpf.salary_year_avg > 70000
    AND sjd.job_id IS NULL

ORDER BY
    salary_year_avg DESC;


/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
Gets job postings with an average yearly salary > $70,000
*/

SELECT 
        quarter1_job_postings.job_title_short,
        quarter1_job_postings.job_location,
        quarter1_job_postings.job_via,
        quarter1_job_postings.job_posted_date::DATE,
        quarter1_job_postings.salary_year_avg
FROM (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
) AS quarter1_job_postings
WHERE
        quarter1_job_postings.salary_year_avg > 70000 AND
        quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
       quarter1_job_postings.salary_year_avg DESC;