-- Quick checks after loading the data

-- 1. row count (should be 199)
SELECT COUNT(*) AS total_respondents FROM survey_responses;

-- 2. any blank answers on the key questions?
SELECT
    SUM(CASE WHEN age_first_pregnancy IS NULL THEN 1 ELSE 0 END) AS missing_age_first_pregnancy,
    SUM(CASE WHEN education_interrupted IS NULL THEN 1 ELSE 0 END) AS missing_education_interrupted,
    SUM(CASE WHEN affected_employment IS NULL THEN 1 ELSE 0 END) AS missing_affected_employment
FROM survey_responses;

-- 3. duplicate respondent ids
SELECT respondent_id, COUNT(*) FROM survey_responses GROUP BY respondent_id HAVING COUNT(*) > 1;
