#activity1
#Use a CTE to display the first account opened by a district.
Use bank;
select * from district;

select * from account
order by date asc
limit 1;

with cte as (select * from account order by date asc limit 1)
select * from cte;

#In order to spot possible fraud, we want to create a view last_week_withdrawals with total withdrawals by client in the last week.
select * from disp;
select * from trans;

create or replace view last_week_withdrawals as
select client_id, amount, t.date from trans as t
left join disp as d
on t.account_id = d.account_id
where t.type = 'VYDAJ' and date > (select (max(date)-7) as last_week from trans)
group by client_id
order by t.account_id;

#The table client has a field birth_number that encapsulates client birthday and sex. The number is in the form YYMMDD for men, and in the form YYMM+50DD for women, 
#where YYMMDD is the date of birth. Create a view client_demographics with client_id, birth_date and sex fields. 
#Use that view and a CTE to find the number of loans by status and sex.

select * from client;

create or replace view client_demographics as
select client_id,
case
when sex = 'F' then (birth_number -5000)
else birth_number
end as date_of_birth, sex from
(select *,
case
when substr(birth_number,3,2) > 12 then 'F'
else 'M'
end as 'sex'
from client)sub;




