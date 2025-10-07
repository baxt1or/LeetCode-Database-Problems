import pandas as pd

def find_golden_hour_customers(restaurant_orders: pd.DataFrame) -> pd.DataFrame:
    
    restaurant_orders["order_timestamp"] = pd.to_datetime(restaurant_orders["order_timestamp"], errors='coerce')

    eligible_customers = restaurant_orders.groupby("customer_id")['order_id'].nunique().reset_index(name="total_orders").query("total_orders >= 3")
    
    start_time_a = pd.to_datetime('11:00:00').time()
    end_time_a = pd.to_datetime('14:00:00').time()

    start_time_b = pd.to_datetime('18:00:00').time()
    end_time_b = pd.to_datetime('21:00:00').time()
    
    order_times = restaurant_orders["order_timestamp"].dt.time

    filtered = restaurant_orders[
    ((order_times >= start_time_a) & (order_times <= end_time_a)) |
    ((order_times >= start_time_b) & (order_times <= end_time_b))
    ]

    filtered_orders_df = filtered.groupby("customer_id")["order_id"].nunique().reset_index(name="valid_orders")

    res_df = pd.merge(eligible_customers, filtered_orders_df, on="customer_id", how="left")

    res_df["peak_hour_percentage"] = (res_df["valid_orders"] / res_df["total_orders"] * 100).round(0)
    
    res_df = res_df[res_df["peak_hour_percentage"] >= 60][['customer_id', 'total_orders', 'peak_hour_percentage']]

    average_orders_df = restaurant_orders.groupby("customer_id")["order_rating"].mean().round(2).reset_index(name="average_rating").query("average_rating >= 4")

    final_df = pd.merge(res_df, average_orders_df, on="customer_id", how="inner")

    result = (
        restaurant_orders
        .groupby('customer_id')
        .agg(
            ordered_orders=('order_rating', lambda x: np.sum(x.notnull())),
            total_orders=("order_rating", 'size')
        )
        .assign(
            per_rating= lambda x: round(x["ordered_orders"] / x["total_orders"] * 100,2)
        )
        .reset_index()
    ).query("per_rating >= 50")[['customer_id']]

    return pd.merge(final_df, result, on='customer_id', how="inner").sort_values(by=["average_rating", 'customer_id'], ascending=[False, False])
