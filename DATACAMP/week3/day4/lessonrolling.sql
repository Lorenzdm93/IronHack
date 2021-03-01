-- find the month on month monthly active users (MAU)
use bank;

create or replace view user_activity as
select account_id, convert(date, date) as Activity_date,
date_format(date, '%m') as Activity_Month,
date_format(convert(date,date), '%Y') as Activity_year
from bank.trans;

select activity_year, activity_month, count(distinct account_id)
FROM user_activity
group by 1, 2
order by 1, 2;
create or replace view Monthly_active_users as
select count(distinct account_id) as Active_users, Activity_year, Activity_Month
from user_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;
with cte_activity as (
  select Active_users, lag(Active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_month
  from Monthly_active_users
)
select * from cte_activity
where last_month is not null;
-- Use self joins to perform rolling calculations - some examples
-- Number of retained users per month
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