-- Write your PostgreSQL query statement below
with cte as (
select
*
from course_completions
where user_id in ((
select
user_id
from course_completions
group by 1
having count(distinct course_id) >= 5 and avg(course_rating) >= 4))),

res as (
select
course_name as first_course,
lead(course_name) over(partition by user_id order by completion_date) as second_course
from cte),

final as (select
first_course, 
second_course,
count(*) as transition_count
from res
where second_course is not null
group by 1, 2)


select
*
from final
order by transition_count desc, lower(first_course), lower(second_course)