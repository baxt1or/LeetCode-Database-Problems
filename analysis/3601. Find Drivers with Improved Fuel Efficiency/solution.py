import pandas as pd

def find_improved_efficiency_drivers(drivers: pd.DataFrame, trips: pd.DataFrame) -> pd.DataFrame:

    import pandas as pd
    
    trips["trip_date"] = pd.to_datetime(trips["trip_date"],errors='coerce')

    trips["fuel_efficiency"] = trips["distance_km"] / trips["fuel_consumed"]
    
    trips["period_interval"] = trips["trip_date"].apply(
        lambda x: 'first_half_avg' if x.month >= 1 and x.month <= 6 
        else 'second_half_avg' if x.month >= 7 and x.month <= 12 else 'Unknown'
    )
    

    result_df = (
        trips 
        .groupby(['driver_id', 'period_interval'])["fuel_efficiency"]
        .mean()
        .reset_index(name="ttl_covered")
    )

    result_df["ttl_seasons"] = result_df.groupby("driver_id")["period_interval"].transform('nunique')

    filtered_df = result_df[result_df["ttl_seasons"] >= 2]

    final_df = filtered_df.pivot(index='driver_id', columns='period_interval', values="ttl_covered").reset_index()
   
    final_df["efficiency_improvement"] = (final_df["second_half_avg"] - final_df["first_half_avg"])

    final_df = final_df[final_df["efficiency_improvement"] > 0]

    final_df = final_df.merge(drivers, on='driver_id', how="inner")[[
        'driver_id', 'driver_name', 'first_half_avg', 'second_half_avg', 'efficiency_improvement'
    ]]

    final_df = final_df.sort_values(by=["efficiency_improvement", 'driver_name'], ascending=[False, True])

    cols = ['first_half_avg', 'second_half_avg', 'efficiency_improvement']

    final_df[cols] = final_df[cols].astype(float).round(2)

    return final_df