import pandas as pd

def topLearnerCourseTransitions(course_completions: pd.DataFrame) -> pd.DataFrame:
    
    res = course_completions.groupby('user_id', as_index=False).agg({'course_id' : 'nunique','course_rating':'mean'})

    users = res[(res["course_id"] >= 5) & (res["course_rating"] >= 4.0)]['user_id'].unique()

    ans = course_completions[course_completions['user_id'].isin(users)]

    ans["second_course"] = ans.groupby('user_id')['course_name'].shift(-1)

    final = ans[ans["second_course"].notnull()][['course_name', 'second_course']].rename(columns={'course_name':'first_course'})

    return (
        final
        .groupby(['first_course', 'second_course'])
        .size()
        .reset_index(name="transition_count")
    ).sort_values(by=['transition_count', 'first_course', 'second_course'], ascending=[False, True, True],key=lambda col: col.str.lower() if col.dtype == object else col)



if __name__ == '__main__':
    """ Example 1: """

    data = [[1, 101, 'Python Basics', '2024-01-05', 5], [1, 102, 'SQL Fundamentals', '2024-02-10', 4], [1, 103, 'JavaScript', '2024-03-15', 5], [1, 104, 'React Basics', '2024-04-20', 4], [1, 105, 'Node.js', '2024-05-25', 5], [1, 106, 'Docker', '2024-06-30', 4], [2, 101, 'Python Basics', '2024-01-08', 4], [2, 104, 'React Basics', '2024-02-14', 5], [2, 105, 'Node.js', '2024-03-20', 4], [2, 106, 'Docker', '2024-04-25', 5], [2, 107, 'AWS Fundamentals', '2024-05-30', 4], [3, 101, 'Python Basics', '2024-01-10', 3], [3, 102, 'SQL Fundamentals', '2024-02-12', 3], [3, 103, 'JavaScript', '2024-03-18', 3], [3, 104, 'React Basics', '2024-04-22', 2], [3, 105, 'Node.js', '2024-05-28', 3], [4, 101, 'Python Basics', '2024-01-12', 5], [4, 108, 'Data Science', '2024-02-16', 5], [4, 109, 'Machine Learning', '2024-03-22', 5]]
    course_completions = pd.DataFrame(data, columns=list({
    "user_id": pd.Series(dtype="int"),
    "course_id": pd.Series(dtype="int"),
    "course_name": pd.Series(dtype="string"),           # corresponds to SQL VARCHAR
    "completion_date": pd.Series(dtype="datetime64[ns]"),  # corresponds to SQL DATE
    "course_rating": pd.Series(dtype="Int64")           # corresponds to SQL INT (nullable)
}.keys()))
    
    resut_df = topLearnerCourseTransitions(course_completions)
    print(resut_df)