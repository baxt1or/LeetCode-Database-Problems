import pandas as pd 

def find_inventory_imbalance(stores: pd.DataFrame, inventory: pd.DataFrame) -> pd.DataFrame:

    threshehold_stores = (
        inventory
        .groupby('store_id')['product_name']
        .count()
        .reset_index(name='ttl_products')
    )

    merged_df =pd.merge(stores, threshehold_stores[threshehold_stores["ttl_products"] >= 3], on='store_id', how='inner')[['store_id','store_name', 'location']]


    most_exp_product = inventory[['store_id', 'price','quantity', 'product_name']].merge(inventory.groupby('store_id')['price'].max().reset_index(name='price'), on=['store_id', 'price'], how='inner')
    
    most_exp_product = most_exp_product.rename(columns={'product_name' : 'most_exp_product'})


    cheapest_product =  inventory[['store_id', 'price','quantity', 'product_name']].merge(inventory.groupby('store_id')['price'].min().reset_index(name='price'), on=['store_id', 'price'], how='inner')
    
    cheapest_product = cheapest_product.rename(columns={"product_name" : "cheapest_product"})

    filtered = pd.merge(most_exp_product, cheapest_product, on='store_id', how='inner')[['store_id', 'most_exp_product', 'cheapest_product', 'quantity_x', 'quantity_y']]

    filtered_df = pd.merge(merged_df, filtered[filtered["quantity_x"] < filtered['quantity_y']], on='store_id', how='inner')
    
    filtered_df["imbalance_ratio"] = round(filtered_df["quantity_y"] / filtered_df["quantity_x"], 2)

    filtered_df.sort_values(by=['imbalance_ratio', 'store_name'], ascending=[False, True], inplace=True)

    cols = filtered_df.columns.to_list()[:-3] + [filtered_df.columns.to_list()[-1]]

    return filtered_df[cols]



data = [[1, 'Downtown Tech', 'New York'], [2, 'Suburb Mall', 'Chicago'], [3, 'City Center', 'Los Angeles'], [4, 'Corner Shop', 'Miami'], [5, 'Plaza Store', 'Seattle']]
stores = pd.DataFrame(data, columns=['store_id', 'store_name', 'location']).astype({'store_id': 'int64', 'store_name': 'string', 'location': 'string'})

data = [[1, 1, 'Laptop', 5, 999.99], [2, 1, 'Mouse', 50, 19.99], [3, 1, 'Keyboard', 25, 79.99], [4, 1, 'Monitor', 15, 299.99], [5, 2, 'Phone', 3, 699.99], [6, 2, 'Charger', 100, 25.99], [7, 2, 'Case', 75, 15.99], [8, 2, 'Headphones', 20, 149.99], [9, 3, 'Tablet', 2, 499.99], [10, 3, 'Stylus', 80, 29.99], [11, 3, 'Cover', 60, 39.99], [12, 4, 'Watch', 10, 299.99], [13, 4, 'Band', 25, 49.99], [14, 5, 'Camera', 8, 599.99], [15, 5, 'Lens', 12, 199.99]]
inventory = pd.DataFrame(data, columns=['inventory_id', 'store_id', 'product_name', 'quantity', 'price']).astype({'inventory_id': 'int64', 'store_id': 'int64', 'product_name': 'string', 'quantity': 'int64', 'price': 'float64'})


print(find_inventory_imbalance(stores, inventory))