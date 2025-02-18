import pandas as pd

def check_valid(st):
    
    s = st.split(".") 

    if len(s) != 4:
        return 1
    
    for x in s:
        if len(str(int(x))) != len(x):
            return 1
    
    for x in s:
        if int(x) > 255:
            return 1 
    return 0


def find_invalid_ips(logs: pd.DataFrame) -> pd.DataFrame:

    logs["status"] = logs["ip"].apply(check_valid)

    result = logs.groupby("ip")["status"].sum().reset_index(name="invalid_count").sort_values(by=["invalid_count", "ip"], ascending=[False, False])
    
    return result[result["invalid_count"] > 0]


logs = pd.DataFrame(data = {
    "log_id": [1, 2, 3, 4, 5, 6, 7, 8],
    "ip": [
        "95.118.75.115", "66.36.109.557", "64.7.141.75", 
        "230.223.71.131", "249.219.186.220", "60.177.134.229", 
        "225.227.90", "91.182.129.190"
    ],
    "status_code": [502, 200, 200, 500, 502, 403, 500, 301]
})


print(find_invalid_ips(logs))