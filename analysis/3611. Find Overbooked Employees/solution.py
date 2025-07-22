import pandas as pd

def find_overbooked_employees(employees: pd.DataFrame, meetings: pd.DataFrame) -> pd.DataFrame:
    
    
    meetings["meeting_date"] = pd.to_datetime(meetings["meeting_date"], errors='coerce')

    meetings['year_week'] = meetings['meeting_date'].dt.strftime('%Y-%W')

    result_df = (
        meetings
        .groupby(["employee_id", 'year_week'])["duration_hours"]
        .sum()
        .reset_index(name="ttl_hours")
    )

    result_df = result_df[result_df["ttl_hours"] > 20]

    result_df["meeting_heavy_weeks"] = result_df.groupby('employee_id')['year_week'].transform('nunique')

    final_df = result_df[result_df["meeting_heavy_weeks"] > 1][['employee_id', 'meeting_heavy_weeks']]

    res = pd.merge(final_df, employees, on='employee_id', how="inner")[['employee_id','employee_name', 'department', 'meeting_heavy_weeks']].drop_duplicates()
    
    res.sort_values(by=['meeting_heavy_weeks', 'employee_name'], ascending=[False, True], inplace=True)

    return res