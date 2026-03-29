/*
Question: what are the most in-demand skills for data analysis?
-identify the top 5 in-demand skills for data analysis.
-why? providing insights into the most valuable skills for job seekers.
*/

SELECT skills_dim.skills , count(skills_job_dim.job_id) AS total_jobs
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data Analyst%' AND job_location = 'Anywhere'
GROUP BY skills_dim.skills
ORDER BY total_jobs DESC
LIMIT 5