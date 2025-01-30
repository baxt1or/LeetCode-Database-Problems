import pandas as pd
import re 

def valid_email(email):
  pattern = re.compile(r'^[a-zA-Z][0-9a-zA-Z_.-]*@leetcode\.com$')

  valid_emails = pattern.match(email)

  return valid_emails


def valid_emails(users: pd.DataFrame) -> pd.DataFrame:
    users["valid"] = users["mail"].apply(lambda x: 1 if valid_email(x) else 0)

    users = users[users["valid"] == 1]

    return users[["user_id", "name", "mail"]]

