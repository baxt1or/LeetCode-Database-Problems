import pandas  as pd

data = [[1, 'ABC123XYZ'], [2, 'A12B34C'], [3, 'Product56789'], [4, 'NoDigitsHere'], [5, '789Product'], [6, 'Item003Description'], [7, 'Product12X34']]
products = pd.DataFrame(data, columns=['product_id', 'name'])

def has_three_digits(s:str):
    digits_count = sum(1 for c in s if c.isdigit())
    return digits_count == 3

def find_products(products: pd.DataFrame) -> pd.DataFrame:
    
    products["status"] = products["name"].apply(lambda x: True if has_three_digits(x) else False)

    valid_products = products[products["status"] == True]

    return valid_products[["product_id", "name"]]

find_products(products)