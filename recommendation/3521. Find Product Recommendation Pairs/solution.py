import pandas as pd 


def find_product_recommendation_pairs(product_purchases: pd.DataFrame, product_info: pd.DataFrame) -> pd.DataFrame:
    

    recommendation_df = pd.merge(product_purchases, product_purchases, on="user_id", how="inner")

    recommendation_df = recommendation_df[recommendation_df["product_id_x"] < recommendation_df["product_id_y"]]

    recommendation_df = recommendation_df.groupby(["product_id_x", "product_id_y"])["user_id"].nunique().reset_index(name="customer_count")

    recommendation_df = recommendation_df[recommendation_df["customer_count"]>=3].rename(columns={"product_id_x":"product1_id", "product_id_y":"product2_id"})
    
    df1 = pd.merge(recommendation_df, product_info, left_on="product1_id", right_on="product_id", how="inner").rename(columns={"category":"product1_category"})

    result_df = pd.merge(df1, product_info, left_on="product2_id", right_on="product_id", how="inner").rename(columns={"category":"product2_category"})


    result_df = result_df[["product1_id", "product2_id", "product1_category", "product2_category", "customer_count"]]


    return result_df.sort_values(["customer_count", "product1_id", "product2_id"], ascending=[False, True, True])


if __name__ == '__main__':
    data = [[1, 101, 2], [1, 102, 1], [1, 103, 3], [2, 101, 1], [2, 102, 5], [2, 104, 1], [3, 101, 2], [3, 103, 1], [3, 105, 4], [4, 101, 1], [4, 102, 1], [4, 103, 2], [4, 104, 3], [5, 102, 2], [5, 104, 1]]
    product_purchases = pd.DataFrame(data, columns=["user_id", "product_id", "quantity"])


    data = [[101, 'Electronics', 100], [102, 'Books', 20], [103, 'Clothing', 35], [104, 'Kitchen', 50], [105, 'Sports', 75]]
    product_info = pd.DataFrame(data, columns=["product_id", "category", "price"])


    recommendation_df = find_product_recommendation_pairs(product_purchases, product_info)

    print(recommendation_df)