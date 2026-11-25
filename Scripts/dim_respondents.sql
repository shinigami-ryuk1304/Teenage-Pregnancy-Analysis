-- Query to clean and standardise the respondent profile (who the mothers are)

SELECT
    respondent_id,  -- Unique identifier for each mother
    REPLACE(current_age, N'–', '-') AS AgeGroup,  -- Replaces the long dash from the form with a normal hyphen
    CASE current_age  -- Sort order so Power BI shows age groups from youngest to oldest
        WHEN N'15–19 years' THEN 1
        WHEN N'20–24 years' THEN 2
        WHEN N'25–29 years' THEN 3
        ELSE 4
    END AS AgeGroupOrder,
    LTRIM(RTRIM(marital_status)) AS MaritalStatus,  -- Removes stray spaces
    religion AS Religion,  -- Religion of the respondent
    education_level AS HighestEducation,  -- Highest level of education completed
    occupation AS Occupation,  -- Current occupation
    number_of_children AS NumberOfChildren,  -- How many children she has
    lives_with AS LivesWith,  -- Who she lives with
    REPLACE(monthly_income, N'–', '-') AS MonthlyIncome,  -- Income band with a normal hyphen
    CASE  -- Sort order for the income bands, lowest to highest
        WHEN monthly_income = 'No personal income' THEN 0
        WHEN monthly_income LIKE 'Less than%' THEN 1
        WHEN monthly_income LIKE N'₦30,000%' THEN 2
        WHEN monthly_income LIKE N'₦60,000%' THEN 3
        ELSE 4
    END AS IncomeBandOrder
FROM
    dbo.vw_survey_responses_clean;  -- Clean view created in fact_survey_responses.sql
