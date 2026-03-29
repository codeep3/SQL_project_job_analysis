/*
Question:what skills are required for top-paying data analyst jobs?
-use the result from the first query
-add the specific skills required for these roles
-why? it provides a detailed look at which high-paying jobs demand certain skills,
    helping job seekers understand which skills to develop.
*/


WITH top_paying_jobs AS(
    SELECT 
        job_id,
        job_title,
        company_dim.name AS company_name,
        salary_year_avg 
        
    FROM 
        job_postings_fact 
    LEFT JOIN 
        company_dim
    ON
        job_postings_fact.company_id=company_dim.company_id
    WHERE 
        job_title_short LIKE '%Data Analyst%' AND job_location ='Anywhere' AND salary_year_avg IS NOT NULL 
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)


SELECT skills,
    top_paying_jobs.*
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
ORDER BY
    salary_year_avg DESC


-- The results show all the skills required in top-paying job postings,
-- some columns may appear to be identical that is due to the fact that 
-- each job posting require multiple skill sets and not just one,
-- hence creating multiple entries (one for each skill required).