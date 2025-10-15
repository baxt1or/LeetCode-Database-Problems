import pandas as pd



def find_churn_risk_customers(subscription_events: pd.DataFrame) -> pd.DataFrame:
    
    subscription_events["event_date"] = pd.to_datetime(subscription_events["event_date"], errors='coerce')

    subscription_events["last_event_date"] = subscription_events.groupby('user_id')['event_date'].transform('max')

    con1_filtered_users_df = subscription_events.query("event_date == last_event_date and event_type != 'cancel'")

    con2_filtered_users_df =  subscription_events.groupby(['user_id', 'event_type'])["event_id"].nunique().reset_index(name="total").query("event_type == 'downgrade' and total >= 1")

    con4_filtered_users_df = (
        subscription_events
        .groupby("user_id")
        .agg(first_day=("event_date","min"), last_day=("event_date","max"))
        .assign(
            days_as_subscriber=lambda x: (x["last_day"] - x["first_day"]).dt.days
        )
        .query("days_as_subscriber >= 60")
        .reset_index()
    
    )

    flt_df = subscription_events.groupby('user_id').agg(event_date=('event_date', 'max'), max_plan=("monthly_amount", 'max')).reset_index()

    con3_filtered_df = pd.merge(subscription_events[['user_id', 'event_date', 'monthly_amount', 'plan_name']], flt_df, on=['user_id', 'event_date'], how="inner")

    con3_filtered_df["ratio"] = round(con3_filtered_df["monthly_amount"] / con3_filtered_df["max_plan"]* 100, 2)

    con3_filtered_users_df = con3_filtered_df.query("ratio < 50 ")


    res_df = con1_filtered_users_df.merge(con2_filtered_users_df, on='user_id', how="inner")

    final_df = res_df[['user_id']].merge(con3_filtered_users_df[['user_id', 'monthly_amount', 'max_plan', 'plan_name']], on='user_id', how="inner")

    final_res_df = final_df.merge(con4_filtered_users_df[['user_id', 'days_as_subscriber']], on='user_id', how="inner")
    
    final_res_df = final_res_df.rename(columns={'monthly_amount' : "current_monthly_amount", "max_plan" : "max_historical_amount", 'plan_name':"current_plan"})

    return final_res_df[['user_id', 'current_plan', 'current_monthly_amount','max_historical_amount', 'days_as_subscriber']].sort_values(by=['days_as_subscriber', 'user_id'], ascending=[False, True])




if __name__ == '__main__':
    data = [[1, 501, '2024-01-01', 'start', 'premium', 29.99], [2, 501, '2024-02-15', 'downgrade', 'standard', 19.99], [3, 501, '2024-03-20', 'downgrade', 'basic', 9.99], [4, 502, '2024-01-05', 'start', 'standard', 19.99], [5, 502, '2024-02-10', 'upgrade', 'premium', 29.99], [6, 502, '2024-03-15', 'downgrade', 'basic', 9.99], [7, 503, '2024-01-10', 'start', 'basic', 9.99], [8, 503, '2024-02-20', 'upgrade', 'standard', 19.99], [9, 503, '2024-03-25', 'upgrade', 'premium', 29.99], [10, 504, '2024-01-15', 'start', 'premium', 29.99], [11, 504, '2024-03-01', 'downgrade', 'standard', 19.99], [12, 504, '2024-03-30', 'cancel', None, 0.0], [13, 505, '2024-02-01', 'start', 'basic', 9.99], [14, 505, '2024-02-28', 'upgrade', 'standard', 19.99], [15, 506, '2024-01-20', 'start', 'premium', 29.99], [16, 506, '2024-03-10', 'downgrade', 'basic', 9.99]]
    subscription_events = pd.DataFrame(data, columns={
    "event_id": pd.Series(dtype="int"),
    "user_id": pd.Series(dtype="int"),
    "event_date": pd.Series(dtype="datetime64[ns]"),  # corresponds to SQL DATE
    "event_type": pd.Series(dtype="string"),
    "plan_name": pd.Series(dtype="string"),           # can be NULL for cancel events
    "monthly_amount": pd.Series(dtype="float")        # corresponds to DECIMAL(10,2)
}.keys())
    
    churn_risk_customer_df = find_churn_risk_customers(subscription_events)

    print(churn_risk_customer_df)
