import pandas as pd
import numpy as np


def find_loyal_customers(customer_transactions: pd.DataFrame) -> pd.DataFrame:

    customer_transactions['transaction_date'] = pd.to_datetime(customer_transactions['transaction_date'], errors='coerce')
    
    result_df = (
        customer_transactions 
        .groupby('customer_id')
        .agg(
            first_date=('transaction_date','min'), 
            last_date=('transaction_date', 'max'),
            ttl_transactions=('transaction_id', 'nunique'),
            refund_transactions=('transaction_type', lambda x: np.sum(x == 'refund'))
        )
        .assign(
            active_period= lambda x: (x['last_date'] - x['first_date']).dt.days,
            refund_rate=lambda x: round(x['refund_transactions'] / x["ttl_transactions"]*100, 2)
        )
        .reset_index()
    )

    return result_df[ 
        (result_df['ttl_transactions'] >= 3) &
        (result_df["active_period"] >= 30) &
        (result_df["refund_rate"] < 20)
    ][['customer_id']]




if __name__ == '__main__':
    data = [[1, 101, '2024-01-05', 150.0, 'purchase'], [2, 101, '2024-01-15', 200.0, 'purchase'], [3, 101, '2024-02-10', 180.0, 'purchase'], [4, 101, '2024-02-20', 250.0, 'purchase'], [5, 102, '2024-01-10', 100.0, 'purchase'], [6, 102, '2024-01-12', 120.0, 'purchase'], [7, 102, '2024-01-15', 80.0, 'refund'], [8, 102, '2024-01-18', 90.0, 'refund'], [9, 102, '2024-02-15', 130.0, 'purchase'], [10, 103, '2024-01-01', 500.0, 'purchase'], [11, 103, '2024-01-02', 450.0, 'purchase'], [12, 103, '2024-01-03', 400.0, 'purchase'], [13, 104, '2024-01-01', 200.0, 'purchase'], [14, 104, '2024-02-01', 250.0, 'purchase'], [15, 104, '2024-02-15', 300.0, 'purchase'], [16, 104, '2024-03-01', 350.0, 'purchase'], [17, 104, '2024-03-10', 280.0, 'purchase'], [18, 104, '2024-03-15', 100.0, 'refund']]
    customer_transactions = pd.DataFrame(data, columns={
    "transaction_id": pd.Series(dtype="int"),
    "customer_id": pd.Series(dtype="int"),
    "transaction_date": pd.Series(dtype="datetime64[ns]"),
    "amount": pd.Series(dtype="float"),
    "transaction_type": pd.Series(dtype="string")})

    res = find_loyal_customers(customer_transactions=customer_transactions.copy())

    print(res)