-- Write your PostgreSQL query statement below
with cte as (select
a.user_id, 
b.category
from ProductPurchases a
join ProductInfo b on a.product_id = b.product_id
group by 1, 2),

cte2 as (select
    a.category as category1,
    b.category as category2,
    a.user_id
from cte a
join cte b on a.user_id = b.user_id and a.category < b.category)


select
category1, 
category2,
count(distinct user_id) as customer_count
from cte2
group by 1, 2
having count(distinct user_id) >= 3
order by 3 desc, 1 , 2