import pandas as pd

# Example 1:
data = [
    {"user_id": 1, "action_date": "2024-01-01", "action": "login"},
    {"user_id": 1, "action_date": "2024-01-02", "action": "login"},
    {"user_id": 1, "action_date": "2024-01-03", "action": "login"},
    {"user_id": 1, "action_date": "2024-01-04", "action": "login"},
    {"user_id": 1, "action_date": "2024-01-05", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-01", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-02", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-03", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-04", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-05", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-06", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-07", "action": "login"},
    {"user_id": 2, "action_date": "2024-01-08", "action": "login"},
    {"user_id": 3, "action_date": "2024-01-01", "action": "click"},
    {"user_id": 3, "action_date": "2024-01-02", "action": "click"},
    {"user_id": 3, "action_date": "2024-01-03", "action": "click"},
    {"user_id": 3, "action_date": "2024-01-04", "action": "click"},
    {"user_id": 3, "action_date": "2024-01-06", "action": "login"},
    {"user_id": 3, "action_date": "2024-01-07", "action": "login"},
    {"user_id": 3, "action_date": "2024-01-08", "action": "login"},
    {"user_id": 3, "action_date": "2024-01-09", "action": "login"},
    {"user_id": 3, "action_date": "2024-01-10", "action": "login"},
    {"user_id": 3, "action_date": "2024-01-11", "action": "login"},
    {"user_id": 4, "action_date": "2024-01-01", "action": "view"},
    {"user_id": 4, "action_date": "2024-01-02", "action": "login"},
    {"user_id": 4, "action_date": "2024-01-04", "action": "login"},
    {"user_id": 4, "action_date": "2024-01-05", "action": "login"},
    {"user_id": 5, "action_date": "2024-01-01", "action": "view"},
    {"user_id": 5, "action_date": "2024-01-02", "action": "view"},
    {"user_id": 5, "action_date": "2024-01-03", "action": "view"},
    {"user_id": 5, "action_date": "2024-01-04", "action": "view"},
    {"user_id": 5, "action_date": "2024-01-05", "action": "view"},
    {"user_id": 6, "action_date": "2024-01-01", "action": "login"},
    {"user_id": 6, "action_date": "2024-01-02", "action": "login"},
    {"user_id": 6, "action_date": "2024-01-03", "action": "login"},
    {"user_id": 6, "action_date": "2024-01-04", "action": "login"},
    {"user_id": 6, "action_date": "2024-01-05", "action": "login"},
    {"user_id": 6, "action_date": "2024-01-06", "action": "login"},
    {"user_id": 6, "action_date": "2024-01-07", "action": "login"},
    {"user_id": 6, "action_date": "2024-01-08", "action": "login"},
    {"user_id": 7, "action_date": "2024-01-01", "action": "view"},
    {"user_id": 7, "action_date": "2024-01-02", "action": "view"},
    {"user_id": 7, "action_date": "2024-01-03", "action": "view"},
    {"user_id": 7, "action_date": "2024-01-04", "action": "view"},
    {"user_id": 7, "action_date": "2024-01-06", "action": "logout"},
    {"user_id": 7, "action_date": "2024-01-07", "action": "logout"},
    {"user_id": 7, "action_date": "2024-01-08", "action": "logout"},
    {"user_id": 7, "action_date": "2024-01-09", "action": "logout"},
    {"user_id": 7, "action_date": "2024-01-10", "action": "logout"},
    {"user_id": 7, "action_date": "2024-01-11", "action": "logout"},
    {"user_id": 8, "action_date": "2024-01-01", "action": "view"},
    {"user_id": 8, "action_date": "2024-01-03", "action": "click"},
    {"user_id": 8, "action_date": "2024-01-04", "action": "view"},
    {"user_id": 8, "action_date": "2024-01-06", "action": "click"},
    {"user_id": 8, "action_date": "2024-01-08", "action": "view"},
    {"user_id": 8, "action_date": "2024-01-09", "action": "click"},
    {"user_id": 9, "action_date": "2024-01-01", "action": "login"},
    {"user_id": 9, "action_date": "2024-01-02", "action": "login"},
    {"user_id": 9, "action_date": "2024-01-03", "action": "login"},
    {"user_id": 9, "action_date": "2024-01-04", "action": "login"},
    {"user_id": 9, "action_date": "2024-01-05", "action": "login"},
    {"user_id": 10, "action_date": "2024-01-01", "action": "logout"},
    {"user_id": 10, "action_date": "2024-01-02", "action": "logout"},
    {"user_id": 10, "action_date": "2024-01-03", "action": "logout"},
    {"user_id": 10, "action_date": "2024-01-04", "action": "logout"},
    {"user_id": 10, "action_date": "2024-01-05", "action": "logout"},
    {"user_id": 10, "action_date": "2024-01-06", "action": "logout"},
    {"user_id": 11, "action_date": "2024-01-01", "action": "click"},
    {"user_id": 11, "action_date": "2024-01-02", "action": "click"},
    {"user_id": 11, "action_date": "2024-01-03", "action": "click"},
    {"user_id": 11, "action_date": "2024-01-04", "action": "click"},
    {"user_id": 11, "action_date": "2024-01-06", "action": "view"},
    {"user_id": 11, "action_date": "2024-01-07", "action": "view"},
    {"user_id": 11, "action_date": "2024-01-08", "action": "view"},
    {"user_id": 11, "action_date": "2024-01-09", "action": "view"},
    {"user_id": 11, "action_date": "2024-01-10", "action": "view"},
    {"user_id": 11, "action_date": "2024-01-11", "action": "view"},
]

df = pd.DataFrame(data)

# Example 2:
data = [[1, '2024-01-01', 'login'], [1, '2024-01-02', 'login'], [1, '2024-01-03', 'login'], [1, '2024-01-04', 'login'], [1, '2024-01-05', 'login'], [1, '2024-01-06', 'logout'], [2, '2024-01-01', 'click'], [2, '2024-01-02', 'click'], [2, '2024-01-03', 'click'], [2, '2024-01-04', 'click'], [3, '2024-01-01', 'view'], [3, '2024-01-02', 'view'], [3, '2024-01-03', 'view'], [3, '2024-01-04', 'view'], [3, '2024-01-05', 'view'], [3, '2024-01-06', 'view'], [3, '2024-01-07', 'view']]
activity = pd.DataFrame(data, columns={
    "user_id": pd.Series(dtype="int"),
    "action_date": pd.Series(dtype="datetime64[ns]"),
    "action": pd.Series(dtype="string")
}.keys())



def find_behaviorally_stable_users(activity: pd.DataFrame) -> pd.DataFrame:
    activity["action_date"] = pd.to_datetime(activity["action_date"])

    df = activity.copy()

    ids = df.groupby(['user_id', 'action'])["action_date"].nunique().reset_index(name="ttl_actions").query("ttl_actions >= 5")["user_id"].unique()
    df = df[df['user_id'].isin(ids)]

    df.sort_values(by=['user_id', 'action_date'], inplace=True)

    df["delta"] = df.groupby(['user_id', 'action'])["action_date"].shift()

    df["delta_diff"] = (df["action_date"] - df["delta"]).dt.days

    df["streak_length"] = df.groupby(['user_id', 'action'])["delta_diff"].cumsum() +1

    res_df = (
        df.groupby(['user_id', 'action'])
        .agg(
            streak_length=('streak_length','max'),
            start_date=('action_date', 'min'),
            end_date=('action_date', 'max')
        )
        .reset_index()
    )

    return res_df.query("streak_length >= 5").sort_values(by=['streak_length', 'user_id'], ascending=[False, True])



if __name__ == '__main__':

    """ Test 1: """
    print(find_behaviorally_stable_users(activity=activity))

    """ Test 2: """
    print(find_behaviorally_stable_users(activity=df))
