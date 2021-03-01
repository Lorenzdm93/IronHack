#inner join fromk table A on B
select * from bank.loan l
join bank.account a
on l.account_id = a.account_id;

select l.loan_id, a.account_id, l.amount, l.payments, a.district_id, a.frequency, a.date
 from bank.loan l
join bank.account a
on l.account_id = a.account_id;

#inner join fromk table B on A (same results bc innner)
select * from bank.account a
join bank.loan l
on a.account_id = l.account_id;

#left join/ loan table on account
select * from bank.loan l
left join bank.account a
on l.account_id = a.account_id;

#left join/ account table on loan
select * from bank.account a
left join bank.loan l
on a.account_id = l.account_id;

#right join/ loan table on account
select * from bank.loan l
right join bank.account a
on l.account_id = a.account_id;

#right join/ account table on loan
select * from bank.account a
right join bank.loan l
on a.account_id = l.account_id;