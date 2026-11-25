# Chi-square tests for the Bariga study
import pandas as pd
from scipy.stats import chi2_contingency

df = pd.read_csv("Data/cleaned_survey_responses.csv")

tests = [
    ("education_interrupted", "affected_employment"),
    ("age_first_pregnancy", "returned_to_school"),
]
for a, b in tests:
    table = pd.crosstab(df[a], df[b])
    chi2, p, dof, _ = chi2_contingency(table)
    print(f"{a} x {b}: chi2 = {chi2:.2f}, df = {dof}, p = {p:.3f}")
