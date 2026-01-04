import pandas as pd

data = [[1, 'Write a blog outline', 120], [1, 'Generate SQL query', 80], [1, 'Summarize an article', 200], [2, 'Create resume bullet', 60], [2, 'Improve LinkedIn bio', 70], [3, 'Explain neural networks', 300], [3, 'Generate interview Q&A', 250], [3, 'Write cover letter', 180], [3, 'Optimize Python code', 220]]
prompts = pd.DataFrame(data, columns={
    "user_id": pd.Series(dtype="int"),
    "prompt": pd.Series(dtype="string"),
    "tokens": pd.Series(dtype="int")
}.keys())




def find_users_with_high_tokens(prompts: pd.DataFrame) -> pd.DataFrame:
    
    res = (
        prompts
        .groupby("user_id")
        .agg(
            prompt_count=("prompt", "count"),
            avg_tokens=('tokens', 'mean')
        )
        .reset_index()
    )
    
    prompts["avg_token"] = prompts.groupby("user_id")["tokens"].transform('mean')
    prompts["ttl_pr"] = prompts.groupby("user_id")["prompt"].transform('count')

    idxs = prompts.query("tokens > avg_token and ttl_pr >= 3")["user_id"].unique()

    res = res[res["user_id"].isin(idxs)].sort_values(by=["avg_tokens", 'user_id'], ascending=[False, True])

    res["avg_tokens"] = res["avg_tokens"].round(2)

    return res


res = find_users_with_high_tokens(prompts)

print(res)