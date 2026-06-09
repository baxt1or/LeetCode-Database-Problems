import pandas as pd


data = [[1, 101, 2], [1, 102, 1], [1, 201, 3], [1, 301, 1], [2, 101, 1], [2, 102, 2], [2, 103, 1], [2, 201, 5], [3, 101, 2], [3, 103, 1], [3, 301, 4], [3, 401, 2], [4, 101, 1], [4, 201, 3], [4, 301, 1], [4, 401, 2], [5, 102, 2], [5, 103, 1], [5, 201, 2], [5, 202, 3]]
product_purchases = pd.DataFrame(data, columns={
    "user_id": pd.Series(dtype='int64'),
    "product_id": pd.Series(dtype='int64'),
    "quantity": pd.Series(dtype='int64')
}.keys())
data = [[101, 'Electronics', 100], [102, 'Books', 20], [103, 'Books', 35], [201, 'Clothing', 45], [202, 'Clothing', 60], [301, 'Sports', 75], [401, 'Kitchen', 50]]
product_info= pd.DataFrame(data, columns={
    "product_id": pd.Series(dtype='int64'),
    "category": pd.Series(dtype='string'),
    "price": pd.Series(dtype='float64')  # Reflects NUMBER(10, 2)
}.keys())



def find_category_recommendation_pairs(product_purchases: pd.DataFrame, product_info: pd.DataFrame) -> pd.DataFrame:
    
    merged_df = product_purchases[['user_id', 'product_id']].merge(product_info[['product_id', 'category']], on='product_id', how="inner")[['user_id', 'category']].drop_duplicates()

    res_df = merged_df.merge(merged_df, on='user_id', how='inner').rename(columns={
        'category_x': 'category1',
        'category_y' : 'category2'
    })[['category1', 'category2', 'user_id']].drop_duplicates()


    final_df = res_df.query('category1 < category2').groupby(['category1', 'category2'])['user_id'].nunique().reset_index(name='customer_count').query('customer_count >= 3')

    return final_df.sort_values(by=['customer_count', 'category1', 'category2'], ascending=[False, True,True])



if __name__ == '__main__':
    """ Example:  """

    print(find_category_recommendation_pairs(product_purchases, product_info))