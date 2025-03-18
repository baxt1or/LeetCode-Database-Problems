import pandas as pd


def reformat_table(department: pd.DataFrame) -> pd.DataFrame:
    months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]

    month_dict = {}

    for month in months:
        month_dict[month] = month+'_Revenue'

    
    agg_func = {
        month:("revenue", lambda x,month=month: x[department.loc[x.index, "month"] == month].sum() if not x[department.loc[x.index, "month"] == month].empty else pd.NA)
        for month in month_dict.keys()
    }

    result_df = department.groupby("id").agg(**agg_func).reset_index()

    result_df.rename(columns=month_dict, inplace=True)

    return result_df



if __name__ == '__main__':

    """ Example 1" """
    data = [[1, 8000, 'Jan'], [2, 9000, 'Jan'], [3, 10000, 'Feb'], [1, 7000, 'Feb'], [1, 6000, 'Mar']]
    department = pd.DataFrame(data, columns=['id', 'revenue', 'month']).astype({'id':'Int64', 'revenue':'Int64', 'month':'object'})
    reformat_table(department=department)