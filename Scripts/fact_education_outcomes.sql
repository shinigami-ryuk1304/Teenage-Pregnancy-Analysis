-- Query to prepare the education outcome data for the dashboard

SELECT
    respondent_id,  -- Unique identifier for each mother
    REPLACE(age_first_pregnancy, N'–', '-') AS AgeFirstPregnancy,  -- Age band at first pregnancy, normal hyphen
    CASE  -- Flags mothers who got pregnant before 18
        WHEN age_first_pregnancy IN ('Below 15 years', N'15–17 years') THEN 1
        ELSE 0
    END AS PregnantBefore18,
    in_school_before_pregnancy AS InSchoolBeforePregnancy,  -- Was she in school before the pregnancy
    education_interrupted AS EducationInterrupted,  -- Yes / No
    CASE WHEN education_interrupted = 'Yes' THEN 1 ELSE 0 END AS EducationInterruptedFlag,  -- 1 = interrupted, used for percentages
    education_after_pregnancy AS EducationAfterPregnancy,  -- Dropped out, stopped for a while, continued, etc.
    returned_to_school AS ReturnedToSchool,  -- Yes / No
    CASE WHEN returned_to_school = 'No' THEN 1 ELSE 0 END AS NeverReturnedFlag,  -- 1 = never went back
    reason_not_continuing AS ReasonNotContinuing,  -- Main reason she could not continue
    effect_on_grades AS EffectOnGrades,  -- How her grades changed
    faced_stigma_in_school AS FacedStigma,  -- Yes / No
    effect_on_education AS OverallEffectOnEducation  -- Severe, moderate, slight or no effect
FROM
    dbo.vw_survey_responses_clean;
