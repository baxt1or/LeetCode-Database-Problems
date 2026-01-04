-- Write your PostgreSQL query statement below

with cte as (select
  user_id, 
  count(prompt) as prompt_count,
  round(sum(tokens) * 1.0 / count(prompt), 2) as avg_tokens
from prompts
group by 1),

final_analysis as (select
user_id
from (
select
*,
avg(tokens) over(partition by user_id) as avg_tokens,
count(prompt) over(partition by user_id) as ttl_prompts
from prompts)
where ttl_prompts >= 3 and tokens > avg_tokens
group by 1)

select
f.user_id,
c.prompt_count,
c.avg_tokens
from final_analysis f
left join cte c on f.user_id = c.user_id
order by c.avg_tokens desc, f.user_id
