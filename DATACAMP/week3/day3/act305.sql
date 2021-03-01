use bank;

#act1
#Find out the average number of transactions by account. 
#Get those accounts that have more transactions than the average.
select * from trans;


select account_id, count(trans_id) 
from trans
group by account_id
having count(trans_id) >
(select count(trans_id)/count(distinct account_id) as average from trans)
order by count(trans_id) asc;

#activity2
#Get a list of accounts from Central Bohemia using a subquery.
select * from district;

select * from account
where district_id in
(select A1 from district where A3 = 'central bohemia');

#Rewrite the previous as a join query.
select * 
from district as d
join account as a
on a.district_id = d.A1
where A3 = 'central bohemia';



#Discuss which method will be more efficient.
