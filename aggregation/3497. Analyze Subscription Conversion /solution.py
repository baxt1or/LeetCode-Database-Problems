import pandas as pd


def get_valid_users(df:pd.DataFrame) -> pd.DataFrame:
        
    df = df[df["activity_type"] != 'cancelled']

    df = df.groupby("user_id")["activity_type"].nunique().reset_index(name="total")

    df = df[df["total"] > 1]

    return df


def analyze_subscription_conversion(user_activity: pd.DataFrame) -> pd.DataFrame:
    
    result_df  = get_valid_users(user_activity)

    df = pd.merge(user_activity, result_df, on="user_id", how="inner")

    agg_func = {
        
        acc : ("activity_duration", lambda x, acc=acc: round(x[df.loc[x.index ,"activity_type"] == acc].mean(), 2) )
        for acc in ["free_trial",'paid']
    }

    df = df.groupby("user_id").agg(**agg_func).reset_index().rename(columns={"free_trial":"trial_avg_duration", "paid":"paid_avg_duration"}).sort_values(by="user_id")
    

    return df



if __name__ == '__main__':

    """ Example 1: """
    columns  = ['user_id', 'activity_date',  'activity_type', 'activity_duration']
    data = [[1, '2023-01-01', 'free_trial', 45], [1, '2023-01-02', 'free_trial', 30], [1, '2023-01-05', 'free_trial', 60], [1, '2023-01-10', 'paid', 75], [1, '2023-01-12', 'paid', 90], [1, '2023-01-15', 'paid', 65], [2, '2023-02-01', 'free_trial', 55], [2, '2023-02-03', 'free_trial', 25], [2, '2023-02-07', 'free_trial', 50], [2, '2023-02-10', 'cancelled', 0], [3, '2023-03-05', 'free_trial', 70], [3, '2023-03-06', 'free_trial', 60], [3, '2023-03-08', 'free_trial', 80], [3, '2023-03-12', 'paid', 50], [3, '2023-03-15', 'paid', 55], [3, '2023-03-20', 'paid', 85], [4, '2023-04-01', 'free_trial', 40], [4, '2023-04-03', 'free_trial', 35], [4, '2023-04-05', 'paid', 45], [4, '2023-04-07', 'cancelled', 0]]
    user_activity = pd.DataFrame(data, columns=columns)

    """ Result: """
    analyze_subscription_conversion(user_activity)