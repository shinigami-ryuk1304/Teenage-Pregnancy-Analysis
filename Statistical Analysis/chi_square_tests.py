import pandas as pd
from scipy.stats import chi2_contingency

# Define a function to fetch the clean survey data from SQL Server
def fetch_data_from_sql():
    import pyodbc  # only needed when reading from SQL Server
    # Connection string for my local SQL Server instance
    conn_str = (
        "Driver={SQL Server};"
        "Server=localhost\\SQLEXPRESS;"  # Change this to your own SQL Server instance
        "Database=BarigaSurveyDB;"
        "Trusted_Connection=yes;"
    )
    conn = pyodbc.connect(conn_str)
    # The view removes blank forms and duplicate submissions (see Scripts/fact_survey_responses.sql)
    df = pd.read_sql("SELECT * FROM dbo.vw_survey_responses_clean", conn)
    conn.close()
    return df

# If SQL Server is not available, fall back to the CSV and do the same cleaning in pandas
def fetch_data_from_csv():
    df = pd.read_csv("../Data/survey_responses.csv")
    df = df.dropna(subset=["current_age"])  # drop the empty form
    answer_cols = [c for c in df.columns if c != "respondent_id"]
    df = df.drop_duplicates(subset=answer_cols)  # drop duplicate submissions
    return df

try:
    survey = fetch_data_from_sql()
except Exception:
    survey = fetch_data_from_csv()

print("Mothers in the analysis:", len(survey))

# The pairs of questions I tested for a relationship
tests = [
    ("education_interrupted", "affected_employment", "Interrupted schooling vs job prospects"),
    ("age_first_pregnancy", "returned_to_school", "Age at first pregnancy vs going back to school"),
    ("education_interrupted", "income_change", "Interrupted schooling vs change in income"),
]

results = []
for col_a, col_b, label in tests:
    table = pd.crosstab(survey[col_a], survey[col_b])  # cross tabulation of the two questions
    chi2, p, dof, expected = chi2_contingency(table)
    results.append({
        "Test": label,
        "ChiSquare": round(chi2, 2),
        "DegreesOfFreedom": dof,
        "PValue": round(p, 3),
        "Significant": "Yes" if p < 0.05 else "No",  # 0.05 significance level
    })

results = pd.DataFrame(results)
print(results)

# Save the results so they can be loaded into Power BI next to the dashboard
results.to_csv("chi_square_results.csv", index=False)
