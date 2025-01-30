import pandas as pd
import re

def valid_emails(email):
  
  pattern = re.compile(r'[0-9a-zA-Z_]+@[a-z]+\.com')

  valid_emails = pattern.finditer(email)

  result = " ".join([email.group() for email in valid_emails])

  return result


def find_valid_emails(users: pd.DataFrame) -> pd.DataFrame:
    
    users["email"] = users["email"].apply(lambda x: x if valid_emails(x) else None)

    users = users.dropna()

    users = users.sort_values(by="user_id")

    return users