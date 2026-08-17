SELECT
        COUNT(job_id) AS number_of_jobs,
        CASE
                WHEN job_location = 'Anywhere' THEN 'Remote'
                WHEN job_location = 'New York, NY' THEN 'Local'
                ELSE 'Onsite'
        END AS location_category
FROM job_postings_fact
WHERE
        job_title_short = 'Data Analyst'
GROUP BY
        location_category;

SELECT
    job_title_short,  -- Shows whether the job is Data Analyst or Data Scientist
    COUNT(job_id) AS number_of_jobs,

    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category

FROM job_postings_fact

WHERE
    job_title_short IN ('Data Analyst', 'Data Scientist')  -- Include both job types

GROUP BY
    job_title_short,
    location_category;



/*  

I want to categorize the averagesalaries from Data Analyst & Data scientist. To see if it fits in my desired salary range.

. Put salary into different buckets

. Define what's a high, standard, or low salary with our own conditions
. Why? It is easy to determine which job postings are worth looking at based on salary.
Bucketing is a common practice in data analysis when viewing categories.
. I only want to look at data analyst roles
· Order from highest to lowest
*/

SELECT
        job_title_short,
        job_location,
        AVG(salary_year_avg), 
        CASE
                WHEN salary_year_avg < 50000 THEN 'Lowest Salary'
                WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN 'Midium Salary'
                ELSE 'Highest Salary'
        END AS salary_category
FROM
        job_postings_fact
WHERE
        job_title_short IN ('Data Analyst', 'Data Scientist')
         AND salary_year_avg IS NOT NULL
         AND job_location = 'Anywhere'
GROUP BY
        job_title_short,
        job_location,
        salary_category
ORDER BY        
        AVG(salary_year_avg) DESC;