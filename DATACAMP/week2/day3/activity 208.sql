Use bank;

SELECT * from district;

#rank district by different variables
select  A4, A9, A10, A11, A12, row_number() over (partition by A9) as 'R_number'
from district;

#Do the same but group by region
select  A3, A4, A9, A10, A11, A12, rank() over (partition by A3) as 'Rank'
from district;

#Use the transactions table in the bank
#database to find the Top 20 account_ids based on the balances.
select account_id, balance from trans
order by balance desc
limit 20;

#Illustrate the difference between Rank() and Dense_Rank()
select  A3, A4, A9, A10, A11, A12, rank() over (order by A3) as 'Rank'
from district; 

select  A3, A4, A9, A10, A11, A12, dense_rank() over (order by A3) as 'Rank'
from district;

#'''rank ranks with the same ranking 
#all the ones with the same category in order(or partition) and the next one is ranked 
#with the respective number of row / while dense_rank ranks the next item with the next ranking'''

#activity 3
Use bank;
SELECT * from district;
SELECT * from client;

#select *, rank() over (partition by district_id order by client_id) as 'Rank' 
#from client;

select district_id, count(client_id) as numberofcustomer, rank() over (order by count(client_id) desc) as 'Rank' 
from client 
group by district_id;

select A3, COUNT(*) as numberofcustomer, rank() over (order by count(A1) desc) as 'Rank' 
from district 
group by A3;

SELECT * from loan;
SELECT * from disp;
SELECT * from account;

SELECT sum(amount), avg(amount), acc.district_id from account as acc
inner join loan as lo
on acc.account_id = lo.account_id
group by acc.district_id
order by acc.district_id;

SELECT * from account;

SELECT district_id, count(*) as numofacc from account
group by district_id
order by district_id;

select *, date_format(convert(date,date), "%Y") as year from account;
