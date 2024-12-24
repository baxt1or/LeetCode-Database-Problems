import pandas as pd

def dynamic_pivoting_table(products: pd.DataFrame) -> pd.DataFrame:
    df = pd.pivot(data=products, index="product_id", columns="store", values="price").reset_index()

    return df 