import pandas as pd 

def get_serial_number(arr):

    for word in arr:
        if word.startswith("SN"):
            return word
    return " "

def check_digits(words):
    
    count = 0

    for word in words:
        if word.isdigit():
            count+=1
    return count

def find_valid_serial_products(products: pd.DataFrame) -> pd.DataFrame:
    
    products["new"] = products["description"].apply(lambda x: x.split(" "))

    products["sn"] = products["new"].apply(get_serial_number)

    products = products[products["sn"] != " "]

    products["part"] = products["sn"].apply(lambda x: x.split("-")[0])
    products["part2"] = products["sn"].apply(lambda x: x.split("-")[1])

    products["cnt"] = products["part"].apply(check_digits)
    products["cnt2"] = products["part2"].apply(check_digits)

    products["result"] = products["cnt"] + products["cnt2"]

    products = products[products["result"] == 8]

    return products[["product_id", "product_name", "description"]].sort_values(by="product_id")


if __name__ == '__main__':

    """ Example 1: """

    data = [[1, 'Widget A', 'This is a sample product with SN1234-5678'], [2, 'Widget B', 'A product with serial SN9876-1234 in the description'], [3, 'Widget C', 'Product SN1234-56789 is available now'], [4, 'Widget D', 'No serial number here'], [5, 'Widget E', 'Check out SN4321-8765 in this description']]
    products = pd.DataFrame(data, columns=['product_id', 'product_name', 'description']).astype({'product_id': 'int32', 'product_name': 'string', 'description': 'string'})


    find_valid_serial_products(products=products)

 