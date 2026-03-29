/*
Question: what are top skills based on salary?
-focus on average salaries
-use only salaries with entries in it , removes null values
*/


SELECT skills_dim.skills , 
    ROUND(AVG(salary_year_avg)) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short LIKE '%Data Analyst%' AND salary_year_avg IS NOT NULL
GROUP BY 
    skills_dim.skills
ORDER BY
    avg_salary DESC
LIMIT 5