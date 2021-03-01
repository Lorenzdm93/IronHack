use sakila;

#Get number of monthly active customers.
select * from customer;	
select * from rental;

create or replace view user_activity as
select customer_id, convert(rental_date, date) as Activity_date,
date_format(rental_date, '%m') as Activity_Month,
date_format(convert(rental_date,date), '%Y') as Activity_year
from rental;

create or replace view Monthly_active_users as
select count(distinct customer_id) as Active_users, Activity_year, Activity_Month
from user_activity
group by Activity_year, Activity_Month
order by Activity_year, Activity_Month;

select * from monthly_active_users; #shows number of active users per month historically

#Active users in the previous month.
  
select Active_users, lag(Active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_month
 from monthly_active_users;

#Percentage change in the number of active customers.
with cte_activity as (
  select Active_users, lag(Active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_month
  from Monthly_active_users
)
select *,  ((Active_users-last_month)/last_month)*100 as percentage_var from cte_activity
where last_month is not null;
#alternatively as below (without temp table)
select *,  ((Active_users-last_month)/last_month)*100 as percentage_var from (select Active_users, lag(Active_users,1) over (partition by Activity_year) as last_month, Activity_year, Activity_month
  from Monthly_active_users)sub
where last_month is not null;

#Retained customers every month.

with distinct_users as (
  select distinct customer_id , Activity_month, Activity_year, Activity_month +1
  from user_activity
)
select count(distinct d1.customer_id) as Retained_customers, d1.Activity_month, d1.Activity_year
from distinct_users d1
join distinct_users d2
on d1.customer_id = d2.customer_id and d1.activity_month = d2.activity_month + 1
group by d1.Activity_month, d1.Activity_year
order by d1.Activity_year, d1.Activity_month;

#if we want to check customer loss we can do total
#from previous month - retained from current month
