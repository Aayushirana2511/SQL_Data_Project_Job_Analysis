SELECt 
        COUNT(job_postings_fact.job_id) AS job_posted_count,
        EXTRACT (MONTH FROM job_posted_date) AS month
FROM
        job_postings_fact
WHERE 
        job_title_short = 'Data Analyst'
GROUP by
        month
ORDER BY
        job_posted_count;


SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
LIMIT 10;

CREATE TABLE january_jobs AS
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

SELECT *
FROM january_jobs;

CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- Create a table containing March job postings
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3;