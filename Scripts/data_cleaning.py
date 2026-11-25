# Cleans the raw Google Form export for the Bariga teenage pregnancy survey.
# Input:  Data/raw_survey_responses.csv
# Output: Data/cleaned_survey_responses.csv

import pandas as pd

raw = pd.read_csv("Data/raw_survey_responses.csv")
codebook = pd.read_csv("Data/codebook.csv")

# the form had one blank submission, drop rows where every answer is empty
df = raw.dropna(how="all").copy()

# long question text -> short column names (see Data/codebook.csv)
df.columns = codebook["column"].tolist()[1:]

# tidy text answers
for col in df.columns:
    df[col] = df[col].astype(str).str.strip().replace({"nan": None})

# respondent number instead of timestamps, so nobody can be identified
df.insert(0, "respondent_id", range(1, len(df) + 1))

# a few flags used in the dashboard
df["pregnant_before_18"] = df["age_first_pregnancy"].isin(["Below 15 years", "15–17 years"]).astype(int)
df["schooling_interrupted"] = (df["education_interrupted"] == "Yes").astype(int)
df["never_returned"] = (df["returned_to_school"] == "No").astype(int)

df.to_csv("Data/cleaned_survey_responses.csv", index=False)
print(f"{len(raw)} rows in, {len(df)} rows out")
