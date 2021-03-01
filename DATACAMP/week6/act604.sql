use bank;

select count(*) from bank.account;

select * from bank.loan;

select count(*) from loan
where status = 'B';

with cte_1 as (
    /* PREVIOUS STEP START */
    select * from (
      /* find customers with status B */
      select
       a.account_id,
       a.district_id,
       a.frequency,
       d.A2 as District,
       d.A3 as Region,
       l.loan_id,
       l.amount,
       l.payments,
       l.status
      from bank.account a
      join bank.district d
      on a.district_id = d.A1
      join bank.loan l
      on a.account_id = l.account_id
      where l.status = "B"
      order by a.account_id ) sub1
    where sub1.amount > (
     /* sub query to find the average amount borrowed
     by all the customers who defaulted*/
     select
      round(avg(amount),2)
     from bank.loan
     where status = "B")
     order by amount desc)
   /* PREVIOUS STEP ENDS */
select
 cte_1.account_id,
 cte_1.amount,
 max(date(t.date)) as Last_transaction
from cte_1
/* to find out last transaction, we need to bring in bank.trans again! */
join bank.trans t
on cte_1.account_id = t.account_id
group by
 cte_1.account_id,
 cte_1.amount
order by cte_1.amount desc;


select * from bank.loan;


/* we're interested in finding information about customers who made 
a payment higher than the average payment of all customers WITH THE SAME
loan duration (to make it comparable) who have status "A" */
 select *
from bank.loan l1
where l1.payments > (
	/* nested (correlated), inner subquery
    which is executed for every loan.
    */
	select
		avg(payments)
	from bank.loan l2
    where l1.duration = l2.duration
    and l1.status = 'A'
	)
 order by account_id;
 
 
/* Find the account_id, amount and date of the 
first transaction of the defaulted people if its amount 
is at least twice the average of non-default people transactions. */
'''option1'''
with cte_1 as (
    /* PREVIOUS STEP START*/
    select * from (
      /* find customers with status B */
      select
       a.account_id,
       a.district_id,
       a.frequency,
       d.A2 as District,
       d.A3 as Region,
       l.loan_id,
       l.amount,
       l.payments,
       l.status
      from bank.account a
      join bank.district d
      on a.district_id = d.A1
      join bank.loan l
      on a.account_id = l.account_id
      where l.status = "B"
      order by a.account_id ) sub1
	where sub1.amount > (
    select 
		round(avg(amount),2)*2
	from bank.loan 
    where status = "A")
    order by amount desc)
select 
	cte_1.account_id,
    cte_1.amount,
    min(date(t.date)) as First_transaction
from cte_1
join bank.trans t
on cte_1.account_id = t.account_id
group by cte_1.account_id, cte_1.amount
order by cte_1.amount desc;

'''option2'''
select l1.account_id, l1.amount, l1.date
from bank.loan l1
where l1.payments >  ( 2* (
	/* nested (correlated), inner subquery
    which is executed for every loan.
    */
	select
		avg(payments)
	from bank.loan l2
    where l1.duration = l2.duration
    and l1.status = 'A'
	))
 order by account_id;
 
 
 
 
 select   /* 3rd execution step */
	account_id,
	min(case when Month = 'January' Then Amount end) as January,
    min(case when Month = 'February' Then Amount end) as February,
    max(case when Month = 'March' Then Amount end) as March
 from ( /* 1.st execution step */
	/* our first table that we want to pivot */
	select
		account_id,
		round(sum(amount), 2) as Amount,
		date_format(date, "%M") as Month
	from trans
	where date_format(date, "%Y") = 1993 and date_format(date, "%m") <= 3
	group by
		account_id,
		Month
	) sub1
  group by account_id   /* 2nd execution step */
  order by account_id;
  
  
  /* Create a pivot table showing the average amount of 
  transactions using frequency for each district. */
  
select * from account;
select * from trans;
-- select * from district;

select distinct(frequency) from account;

select 
	district_id, 
	(case when frequency = 'POPLATEK MESICNE' Then Avg end) as 'POPLATEK MESICNE',
	(case when frequency = 'POPLATEK TYDNE' Then Avg end) as 'POPLATEK TYDNE',
	(case when frequency = 'POPLATEK PO OBRATU' Then Avg end) as 'POPLATEK PO OBRATU' 
from 
(
	select a.frequency, district_id, round(avg(t.amount),2) as Avg 
	from account as a
	join trans as t
	on a.account_id = t.account_id
	group by district_id
)sub1
group by district_id
order by district_id;

  