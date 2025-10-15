-- Write your PostgreSQL query statement below
with con1_users as (select
user_id
from (select
*,
max(event_date) over(partition by user_id) as last_event_date
from subscription_events) as sub
where event_date = last_event_date and event_type != 'cancel'),

con2_users as (select
user_id
from subscription_events
where event_type = 'downgrade'
group by 1
having count(distinct event_id) >= 1),

con3_users as (select
*
from (select
s.user_id, 
s.plan_name as current_plan, 
s.monthly_amount as current_monthly_amount, 
sub.max_historical_amount,
round(s.monthly_amount * 1.0 / sub.max_historical_amount * 100, 2) as ratio
from subscription_events s
inner join (select
user_id, 
max(event_date) as event_date, 
max(monthly_amount) as max_historical_amount
from subscription_events
group by 1) as sub on s.user_id = sub.user_id and s.event_date = sub.event_date) as sub
where ratio < 50 and current_plan is not null),

con4_users as (select
user_id,
max(event_date) - min(event_date) as days_as_subscriber
from subscription_events
group by 1
having max(event_date) - min(event_date) >= 60)

select
a.user_id, 
c.current_plan, 
c.current_monthly_amount, 
c.max_historical_amount,
d.days_as_subscriber
from con1_users a
inner join con2_users b on a.user_id = b.user_id
inner join con3_users c on a.user_id = c.user_id
inner join con4_users d on a.user_id = d.user_id
order by d.days_as_subscriber desc, a.user_id
