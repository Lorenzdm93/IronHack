#activity 1

Use bank;

select loan_id, account_id,
case
when status = "A" then "Good - Contract Finished"
when status = "B" then "Defaulter - Contract Finished"
when status = "C" then "Good - Contract Running"
else "In Debt - Contract Running"
end as "Status_Description" # column
from bank.loan;

#activity 2

select min(amount) as min, max(amount) as max, status from bank.loan
group by Status;

#activity 3
Use bank;
select (count(card_id)), type from bank.card
group by type;

SELECT * from district;

select count(distinct(A2)), A3 from district
group by A3;

SELECT avg(amount) as average, type from trans
group by type;

select type, operation, k_symbol, round(avg(balance),2)
from bank.trans
group by type, operation, k_symbol
order by type, operation, k_symbol;

#activity4
select * from client;
select count(*) as numberofclient, district_id from client
group by district_id
having numberofclient > 100
order by numberofclient desc;

SELECT distinct(type), amount from trans;
SELECT avg(amount) as average, type, operation from trans
group by type, operation
having average > 10000;