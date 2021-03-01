#ACTIVITY 1
Use bank;

select * from district;
select * from client;

#Get the number of clients by district, returning district name.
select count(*), A1, A2 from bank.district d
inner join bank.client c
on d.A1 = c.district_id
group by A2
order by A1;

#Are there districts with no clients? Move all clients from Strakonice 
#to a new district with district_id = 100. Check again. Hint: 
#In case you have some doubts, you can check here how to use the update statement.
select A1 from district
where A2 = 'Strakonice';

SET SQL_SAFE_UPDATES = 0;
SET FOREIGN_KEY_CHECKS=0;

update bank.district
set A1 = '100' 
where district.A1 = '20';

update bank.client
set district_id = '100' 
where district_id = '20';

#check for changes
select count(*), A1, A2 from bank.district d
right join bank.client c
on d.A1 = c.district_id
where A1 is null
group by A2
order by A1;

#How would you spot clients with wrong or missing district_id?
select * from client
where district_id <> ' ' or district_id is null;

#Return clients to Strakonice.
select count(*), client.district_id, A2 
from bank.district d
left join bank.client c
on d.A1 = c.district_id
group by A2
order by client.district_id;

-- a) return account_id, operation, frequency, sum of amount, sum of balance
-- b) where balance is over 1900
-- c) operation is of type VKLAD 
-- d) that have an aggregated amount of over 500000
Use bank; 
-- first step
select * from bank.trans t
left join bank.account a
on t.account_id = a.account_id;
-- second step
select * from bank.trans t
left join bank.account a
on t.account_id = a.account_id
where t.operation= 'VKLAD' and balance > 1000;
-- third step
select sum(amount) as totalamount, sum(balance) as totalbalance, t.account_id, t.operation, a.frequency
 from bank.trans t
left join bank.account a
on t.account_id = a.account_id
where t.operation= 'VKLAD' and balance > 1000
group by 3,4,5
having totalamount > 500000
order by totalamount desc
limit 10;




























