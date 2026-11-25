-- Queries behind the dashboard

-- KPI cards
SELECT
    COUNT(*) AS respondents,
    ROUND(100.0 * AVG(pregnant_before_18), 1)    AS pct_pregnant_before_18,
    ROUND(100.0 * AVG(schooling_interrupted), 1) AS pct_schooling_interrupted,
    ROUND(100.0 * AVG(never_returned), 1)        AS pct_never_returned,
    ROUND(100.0 * AVG(CASE WHEN affected_employment = 'Yes' THEN 1 ELSE 0 END), 1) AS pct_job_prospects_hurt,
    ROUND(100.0 * AVG(CASE WHEN got_govt_ngo_help = 'No' THEN 1 ELSE 0 END), 1)    AS pct_no_govt_ngo_help
FROM survey_responses;

-- age at first pregnancy
SELECT age_first_pregnancy, COUNT(*) AS mothers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM survey_responses
GROUP BY age_first_pregnancy
ORDER BY mothers DESC;

-- what happened to their education
SELECT education_after_pregnancy, COUNT(*) AS mothers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM survey_responses
GROUP BY education_after_pregnancy
ORDER BY mothers DESC;

-- main reason for not continuing school
SELECT reason_not_continuing, COUNT(*) AS mothers,
       ROUND(100.0 * COUNT(*) / SUM(COUNT(*)) OVER (), 1) AS pct
FROM survey_responses
GROUP BY reason_not_continuing
ORDER BY mothers DESC;

-- impact by current age group (table on the dashboard)
SELECT current_age,
       COUNT(*) AS mothers,
       ROUND(100.0 * AVG(schooling_interrupted), 1) AS pct_schooling_cut,
       ROUND(100.0 * AVG(CASE WHEN returned_to_school = 'Yes' THEN 1 ELSE 0 END), 1) AS pct_went_back,
       ROUND(100.0 * AVG(CASE WHEN affected_employment = 'Yes' THEN 1 ELSE 0 END), 1) AS pct_job_hit,
       ROUND(100.0 * AVG(CASE WHEN effect_on_education = 'Severe effect' THEN 1 ELSE 0 END), 1) AS pct_severe
FROM survey_responses
GROUP BY current_age;

-- crosstab used for the chi-square test (run the test in statistical_tests.py)
SELECT education_interrupted, affected_employment, COUNT(*) AS mothers
FROM survey_responses
GROUP BY education_interrupted, affected_employment;
