use bank;
#activity1
#Modify the previous query to obtain the percentage of variation 
#in the number of users compared with previous month.
select * from monthly_active_users;

with cte_activity as (
  select Active_users, lag(Active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_month
  from Monthly_active_users
)
select *,  ((Active_users-last_month)/last_month)*100 as percentage_var from cte_activity
where last_month is not null;

#activity2
#Modify the previous queries to list the customers lost last month.
#retention code Hima below

select * from user_activity;


with distinct_users as (
  select distinct account_id , Activity_month, Activity_year, Activity_month +1
  from user_activity
)
select count(distinct d1.account_id) as Retained_customers, d1.Activity_month, d1.Activity_year
from distinct_users d1
join distinct_users d2
on d1.account_id = d2.account_id and d1.activity_month = d2.activity_month + 1
group by d1.Activity_month, d1.Activity_year
order by d1.Activity_year, d1.Activity_month;

with distinct_users as (
  select distinct account_id , Activity_month, Activity_year, Activity_month +1
  from user_activity
)
select count(distinct d1.account_id) as Retained_customers, d1.Activity_month, d1.Activity_year
from distinct_users d1
join distinct_users d2
on d1.activity_month = d2.activity_month +1
group by d1.Activity_month, d1.Activity_year
order by d1.Activity_year, d1.Activity_month;