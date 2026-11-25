# Teenage Pregnancy Analysis (Bariga, Lagos)

A lot of girls in Bariga Local Government Area get pregnant while still in their teens. Everyone knows it happens, but there was very little local data on what happens after: do they go back to school, can they find work, and is anyone helping them? I designed the analysis for a survey of young mothers in Bariga and analysed it to answer those questions.

Key Points:
* School disruption: many of the girls leave school once they get pregnant and never return.
* Money and work: missing school seems to hurt their chances of getting a job and earning well.
* Support: it was not clear how much help these mothers get from government or NGOs.

Tools I used: Google Forms, Python (pandas, SciPy), SQL, SPSS, Excel, Power BI

Data: 200 young mothers filled the survey (199 usable responses), 41 questions on education, income and support. Collected in 2026.

## Objectives
1. Find out how teenage pregnancy affected their education
2. See how it affected their work and income
3. Look at what support they get and how they are coping

## Dashboard
![Teenage Pregnancy Dashboard](Dashboard/dashboard.png)

## What I found
* 88% said the pregnancy interrupted their education. Half of all the mothers (51%) dropped out for good and 69% never went back to school.
* 55% got pregnant before 18, and 17% before 15.
* Money was the biggest reason they could not continue (47%), followed by childcare (39%).
* 60% said the pregnancy affected their chances of getting a job. The chi-square test shows the mothers whose schooling was interrupted were more likely to say this (χ² = 5.92, df = 1, p = .015).
* 44% earn less than before they became mothers, but 74% have never received any help from government or an NGO.

## Recommendations
* Back-to-school programmes for young mothers, with flexible hours
* Childcare close to schools and skills centres, since childcare is the second biggest barrier
* Bursaries or cash support, because money is the main reason they drop out
* More NGO and government outreach in Bariga, where most of these mothers have never been reached

## Repo structure
```
Data/
  raw_survey_responses.csv        original export
  cleaned_survey_responses.csv    after data_cleaning.py
  codebook.csv                    what each column means
Scripts/
  data_cleaning.py
  01_create_table.sql
  02_data_checks.sql
  03_analysis_queries.sql
  statistical_tests.py
Dashboard/
  dashboard.png / dashboard.html
  Excel workbook (dashboard, charts, data, tests)
```

## How to run it
1. Run `python Scripts/data_cleaning.py` to create the cleaned file in the Data folder.
2. Create the table with `Scripts/01_create_table.sql`, load `Data/cleaned_survey_responses.csv` into it, then run `02_data_checks.sql` and `03_analysis_queries.sql`. I wrote them in standard SQL, so they run in SQL Server, PostgreSQL, MySQL 8 or SQLite.
3. Run `python Scripts/statistical_tests.py` for the hypothesis tests.
4. Open the Excel workbook in the Dashboard folder, or load it into Power BI (Get data > Excel workbook).

Researcher and analyst: Daniel Oluwaseun David. The data is anonymised, there are no names or contact details in it.
