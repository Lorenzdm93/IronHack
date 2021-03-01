use bank;

#1. What's the gender split among clients?

select * from client_demographics;

select sex, count(*) from client_demographics 
group by sex;

#Are there any accounts that have more than 
#2 linked clients? If yes, how many?
select * from disp;

select count(*) from (select distinct account_id from disp
group by account_id
having count(account_id) > 1)sub;

#What is the average transaction amount for each region?
select * from trans;
select * from account;
select * from district;

select d.A3, avg(t.amount) from trans as t
join account as a
on t.account_id = a.account_id
join district as d
on d.A1 = a.district_id
group by d.A3;

#Based on the entire transaction volume (total amount), 
#what's the percentage that was sent to another bank? #PREVOD NA UCET

select * from trans;

select sum(amount) from trans;

select ((select sum(amount) from trans
where operation = 'PREVOD NA UCET')/(select sum(amount) from trans))* 100;


#From which region do most of the clients that are account owners come from, 
#that either have finished loan contracts that haven't been paid (B), or have r
#unning contracts but are in debt(D)? Show the top 10 regions including the number 
#of clients that are owners.
select * from disp;
select * from loan;
select * from client;
select * from district;
select * from account;

select a.type, count(*), d.A3 from disp as a
left join loan as b
on a.account_id = b.account_id
left join client as c
on a.client_id = c.client_id
left join district as d
on c.district_id = d.A1
where b.status in ('B','D') and a.type = 'OWNER'
group by d.A3
order by count(*) desc
limit 10;


#marcus solution
select a.A3, count(*) as no_of_clients_owner
from district as a
join client as b
on a.A1 = b.district_id
where client_id in (select client_id from disp
					where type = 'OWNER'
					and account_id in (select account_id from loan
					where status in ('D','B')))
                    group by a.A3
order by count(*) desc;



