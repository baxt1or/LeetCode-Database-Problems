with cte as (
select
user_id, 
count(reaction) as ttl_reactions,
count(distinct content_id) as ttl_content
from reactions
group by 1
having count(distinct content_id) >= 5),


cte3 as (
select
user_id, 
reaction ,
count(*) as ttl
from reactions
group by 1, 2)


select
a.user_id, 
a.reaction as dominant_reaction, 
round(a.ttl * 1.0 / b.ttl_reactions, 2) as reaction_ratio 
from cte3 a
left join cte b on a.user_id = b.user_id
where a.ttl * 1.0 / b.ttl_reactions >= 0.6
order by reaction_ratio desc, a.user_id 