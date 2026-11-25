-- Query to prepare the support and coping data

SELECT
    respondent_id,  -- Unique identifier for each mother
    emotional_support_from AS EmotionalSupportFrom,  -- Who gives her the most emotional support
    financial_support_from AS FinancialSupportFrom,  -- Who supports her financially
    got_govt_ngo_help AS GotGovtOrNgoHelp,  -- Has she ever had help from government or an NGO
    CASE WHEN got_govt_ngo_help = 'No' THEN 1 ELSE 0 END AS NoGovtOrNgoHelpFlag,
    joined_skills_programme AS JoinedSkillsProgramme,  -- Has she joined any skills programme since becoming a mother
    childcare_help_from AS ChildcareHelpFrom,  -- Who helps with the baby
    support_frequency AS SupportFrequency,  -- How often family or friends help
    support_effectiveness AS SupportEffectiveness,
    coping_ability AS CopingAbility,  -- Her own rating of how she is coping
    CASE coping_ability  -- Turns the rating into a number so we can average it
        WHEN 'Very good' THEN 4
        WHEN 'Good' THEN 3
        WHEN 'Fair' THEN 2
        WHEN 'Poor' THEN 1
    END AS CopingScore
FROM
    dbo.vw_survey_responses_clean;
