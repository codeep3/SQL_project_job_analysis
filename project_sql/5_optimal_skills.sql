/*
Question: what are the most optimal skills (aka high demand and high paying skill?)
-concentrate on remote jobs with specified salaries
-identify skills in high demand and associated with high average salaries for Data Analyst roles
*/

WITH high_paying_skills AS(
    SELECT skills_dim.skill_id,
        skills_dim.skills , 
        ROUND(AVG(salary_year_avg)) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short LIKE '%Data Analyst%' AND salary_year_avg IS NOT NULL AND job_work_from_home = True
    GROUP BY 
        skills_dim.skill_id

), high_demand_skills AS (
    SELECT skills_dim.skill_id, skills_dim.skills , count(skills_job_dim.job_id) AS total_jobs
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id=skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id=skills_dim.skill_id
    WHERE
        job_title_short LIKE '%Data Analyst%' AND job_location = 'Anywhere'
    GROUP BY skills_dim.skill_id
)


SELECT 
    high_paying_skills.skill_id,
    high_demand_skills.skills,
    high_demand_skills.total_jobs,
    high_paying_skills.avg_salary
FROM 
    high_paying_skills
INNER JOIN high_demand_skills ON high_paying_skills.skill_id=high_demand_skills.skill_id
ORDER BY total_jobs DESC, avg_salary DESC
LIMIT 25