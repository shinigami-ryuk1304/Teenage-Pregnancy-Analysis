-- Query to prepare the work and income data

SELECT
    respondent_id,  -- Unique identifier for each mother
    has_income_activity AS HasIncomeActivity,  -- Is she doing anything that brings in money
    main_income_source AS MainIncomeSource,  -- Where most of her money comes from
    REPLACE(monthly_income_now, N'–', '-') AS MonthlyIncomeNow,  -- Current income band
    affected_employment AS AffectedEmployment,  -- Did the pregnancy affect her chances of getting a job
    CASE WHEN affected_employment = 'Yes' THEN 1 ELSE 0 END AS AffectedEmploymentFlag,
    income_change AS IncomeChange,  -- Went down, stayed the same, went up
    economic_activity AS EconomicActivity,  -- Petty trading, salaried job, artisan, farming
    affected_skills AS AffectedSkills,  -- Did it stop her learning a trade or skill
    household_expenses_met_by AS HouseholdExpensesMetBy,
    effect_on_economic_wellbeing AS OverallEffectOnEconomy  -- Severe, moderate, slight or no effect
FROM
    dbo.vw_survey_responses_clean;
