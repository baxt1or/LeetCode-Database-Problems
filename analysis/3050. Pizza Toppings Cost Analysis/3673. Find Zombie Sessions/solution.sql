-- Write your PostgreSQL query statement below
with app_analysis as (select
user_id,
session_id,
count(case when event_type = 'purchase' then 1 end) as purchase_count,
count(case when event_type = 'scroll' then 1 end) as scroll_count,
count(case when event_type = 'click' then 1 end) * 1.0 / count(case when event_type = 'scroll' then 1 end) as click_scroll_ratio,
extract(epoch from (max(case when event_type = 'app_close' then event_timestamp end) - max(case when event_type = 'app_open' then event_timestamp end))) / 60 as session_duration_minutes
from app_events
group by 1, 2)


select
session_id, user_id,session_duration_minutes, scroll_count
from app_analysis
where session_duration_minutes > 30 and click_scroll_ratio < 0.20 and purchase_count  <= 0 and scroll_count >= 5
order by scroll_count desc, session_id;