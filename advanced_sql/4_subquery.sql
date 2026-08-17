-- 1st example
SELECT *
FROM (
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    ) AS January_jobs;

-- 2nd example
SELECT
    company_id,
    name AS company_name
FROM
    company_dim
WHERE company_id IN (
        SELECT
            company_id
        FROM
            job_postings_fact
        WHERE 
            job_no_degree_mention = true
)

