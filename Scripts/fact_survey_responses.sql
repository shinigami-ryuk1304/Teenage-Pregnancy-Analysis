-- Common Table Expression (CTE) to find duplicate submissions
-- The Google Form export had some people submitting the same form twice, so the rows are identical apart from respondent_id

WITH DuplicateRecords AS (
    SELECT
        respondent_id,  -- Row number given to each submission at import
        current_age,  -- Age group of the mother today
        age_first_pregnancy,  -- Age when she first got pregnant
        ROW_NUMBER() OVER (
            -- PARTITION BY every answer column, so only rows where all the answers match are treated as duplicates
            PARTITION BY current_age, age_first_pregnancy, marital_status, religion, education_level, in_school_before_pregnancy, education_status_now, occupation, number_of_children, lives_with, monthly_income, education_interrupted, education_after_pregnancy, returned_to_school, time_before_resuming, reason_not_continuing, effect_on_grades, faced_stigma_in_school, education_status_now_2, reduced_higher_ed_chance, effect_on_education, has_income_activity, main_income_source, monthly_income_now, affected_employment, income_change, main_financial_support, economic_activity, affected_skills, household_expenses_met_by, effect_on_economic_wellbeing, emotional_support_from, financial_support_from, got_govt_ngo_help, support_type, joined_skills_programme, supports_self_by, childcare_help_from, support_frequency, support_effectiveness, coping_ability
            ORDER BY respondent_id  -- Keeps the earliest submission as number 1
        ) AS row_num
    FROM
        dbo.survey_responses  -- Raw survey table imported from Data/survey_responses.csv
)

-- Shows the duplicate rows only (row_num > 1)
SELECT *
FROM DuplicateRecords
WHERE row_num > 1
ORDER BY respondent_id;
GO

-- View holding the clean survey: one row per mother, no blank forms
CREATE VIEW dbo.vw_survey_responses_clean AS
SELECT *
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER (
                PARTITION BY current_age,
            age_first_pregnancy,
            marital_status,
            religion,
            education_level,
            in_school_before_pregnancy,
            education_status_now,
            occupation,
            number_of_children,
            lives_with,
            monthly_income,
            education_interrupted,
            education_after_pregnancy,
            returned_to_school,
            time_before_resuming,
            reason_not_continuing,
            effect_on_grades,
            faced_stigma_in_school,
            education_status_now_2,
            reduced_higher_ed_chance,
            effect_on_education,
            has_income_activity,
            main_income_source,
            monthly_income_now,
            affected_employment,
            income_change,
            main_financial_support,
            economic_activity,
            affected_skills,
            household_expenses_met_by,
            effect_on_economic_wellbeing,
            emotional_support_from,
            financial_support_from,
            got_govt_ngo_help,
            support_type,
            joined_skills_programme,
            supports_self_by,
            childcare_help_from,
            support_frequency,
            support_effectiveness,
            coping_ability
                ORDER BY respondent_id
            ) AS row_num  -- Numbers each copy of the same submission
        FROM
            dbo.survey_responses
        WHERE
            current_age IS NOT NULL  -- Drops the one empty form
    ) AS subquery
WHERE
    row_num = 1;  -- Keeps only the first copy of each submission
GO
