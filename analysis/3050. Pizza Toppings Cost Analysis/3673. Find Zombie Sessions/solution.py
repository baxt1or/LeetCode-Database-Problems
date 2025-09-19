import pandas as pd
import numpy as np



def find_zombie_sessions(app_events: pd.DataFrame) -> pd.DataFrame:
    app_events["event_timestamp"] = pd.to_datetime(app_events['event_timestamp'], errors='coerce')

    app_analysis_df =  (
        app_events
        .groupby(['user_id', 'session_id'])
        .agg(
            scroll_count=("event_type", lambda x: np.sum(x == 'scroll')),
            click_count=('event_type', lambda x: np.sum(x=='click')),
            purchase_count=('event_type', lambda x: np.sum(x == 'purchase')),
            app_open_date = ( "event_timestamp", lambda ts: ts[app_events.loc[ts.index, "event_type"] == "app_open"].max()),
            app_close_date=("event_timestamp", lambda ts: ts[app_events.loc[ts.index, 'event_type'] == 'app_close'].max())
        )
        .assign(
            click_scroll_ratio= lambda x: x["click_count"] / x["scroll_count"],
            session_duration_minutes= lambda x: (x["app_close_date"] - x["app_open_date"]).dt.total_seconds() / 60
        )
        .reset_index()
    )

    fileted_df =  app_analysis_df[ 
        (app_analysis_df["session_duration_minutes"] > 30) &
        (app_analysis_df["scroll_count"] >= 5) & 
        (app_analysis_df["click_scroll_ratio"] < 0.20) &
        (app_analysis_df["purchase_count"] == 0)
    ].sort_values(by=['scroll_count', 'session_id'], ascending=[False, True])

    return fileted_df[['session_id', 'user_id','session_duration_minutes', 'scroll_count']]


if __name__ == '__main__':

    data = [[1, 201, '2024-03-01 10:00:00', 'app_open', 'S001', None], [2, 201, '2024-03-01 10:05:00', 'scroll', 'S001', 500], [3, 201, '2024-03-01 10:10:00', 'scroll', 'S001', 750], [4, 201, '2024-03-01 10:15:00', 'scroll', 'S001', 600], [5, 201, '2024-03-01 10:20:00', 'scroll', 'S001', 800], [6, 201, '2024-03-01 10:25:00', 'scroll', 'S001', 550], [7, 201, '2024-03-01 10:30:00', 'scroll', 'S001', 900], [8, 201, '2024-03-01 10:35:00', 'app_close', 'S001', None], [9, 202, '2024-03-01 11:00:00', 'app_open', 'S002', None], [10, 202, '2024-03-01 11:02:00', 'click', 'S002', None], [11, 202, '2024-03-01 11:05:00', 'scroll', 'S002', 400], [12, 202, '2024-03-01 11:08:00', 'click', 'S002', None], [13, 202, '2024-03-01 11:10:00', 'scroll', 'S002', 350], [14, 202, '2024-03-01 11:15:00', 'purchase', 'S002', 50], [15, 202, '2024-03-01 11:20:00', 'app_close', 'S002', None], [16, 203, '2024-03-01 12:00:00', 'app_open', 'S003', None], [17, 203, '2024-03-01 12:10:00', 'scroll', 'S003', 1000], [18, 203, '2024-03-01 12:20:00', 'scroll', 'S003', 1200], [19, 203, '2024-03-01 12:25:00', 'click', 'S003', None], [20, 203, '2024-03-01 12:30:00', 'scroll', 'S003', 800], [21, 203, '2024-03-01 12:40:00', 'scroll', 'S003', 900], [22, 203, '2024-03-01 12:50:00', 'scroll', 'S003', 1100], [23, 203, '2024-03-01 13:00:00', 'app_close', 'S003', None], [24, 204, '2024-03-01 14:00:00', 'app_open', 'S004', None], [25, 204, '2024-03-01 14:05:00', 'scroll', 'S004', 600], [26, 204, '2024-03-01 14:08:00', 'scroll', 'S004', 700], [27, 204, '2024-03-01 14:10:00', 'click', 'S004', None], [28, 204, '2024-03-01 14:12:00', 'app_close', 'S004', None]]
    app_events = pd.DataFrame(data=data, columns={
    "event_id": pd.Series(dtype="int"),
    "user_id": pd.Series(dtype="int"),
    "event_timestamp": pd.Series(dtype="datetime64[ns]"),
    "event_type": pd.Series(dtype="string"),  
    "session_id": pd.Series(dtype="string"),  
    "event_value": pd.Series(dtype="int")}.keys())

    zombie_session_analysis = find_zombie_sessions(app_events=app_events)

    print(zombie_session_analysis)