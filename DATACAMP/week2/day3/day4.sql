 ```sql
select * from bank.order
where amount > 1000;

select * from bank.order
where k_symbol = 'SIPO';

select order_id, account_id, bank_to, amount from bank.order
where k_symbol = 'SIPO';

select order_id as 'OrderID', account_id as 'AccountID', bank_to as 'DestinationBank', amount  as 'Amount'
from bank.order
where k_symbol = 'SIPO';

```
```sql
select *, amount-payments as balance
from bank.loan;

select loan_id, account_id, date, duration, status, amount-payments as balance
from bank.loan;

select loan_id, account_id, date, duration, status, (amount-payments)/1000 as 'balance in Thousands'
from bank.loan;

-- this is the modulus operator that gives the remainder. This is a dummy example:
select duration%2
from bank.loan;

select 10%3;
```
> These comparison operators are used with the `WHERE` clause, for filtering data:

```sql
select * from bank.loan
where status = 'B';
-- In this case status B is for those clients where the contract has finished but the loan is not paid yet

select * from bank.loan
where status in ('B','b');

select * from bank.loan
where status in ('B','b') and amount > 100000;
```
```sql
select * from bank.loan
limit 10;

-- to get the bottom rows of a table, there is no predefined function
-- but you can sort the results in descending order and then use the LIMIT function
select * from bank.account
order by account_id desc
limit 10;
-- In this case, we were able to do it because the data was arranged
-- in ascending order of the account_id
```
```sql
select * from bank.loan
limit 10;

-- to get the bottom rows of a table, there is no predefined function
-- but you can sort the results in descending order and then use the LIMIT function
select * from bank.account
order by account_id desc
limit 10;
-- In this case, we were able to do it because the data was arranged
-- in ascending order of the account_id
```


```sql
-- two conditions applied on the table
select *
from bank.loan
where status = 'B' and amount > 100000;

-- we can have as many conditions as we need
select *
from bank.loan
where status = 'B' and amount > 100000 and duration <= 24;
--
select *
from bank.loan
where status = 'B' or status = 'D';
-- Status B and D are the clients that were bad for business for the bank

select *
from bank.loan
where (status = 'B' or status ='D') and amount > 200000;

-- logical NOT operator - it negates the boolean expression that we are evaluating
select *
from bank.order
where not k_symbol = 'SIPO';

select *
from bank.order
where not k_symbol = 'SIPO' and not amount < 1000;
```
```sql
select order_id, round(amount/1000,2)
from bank.order;

-- checking the number of rows in the table, both methods give the same result
-- given that there are no nulls in the column in the second case:
select count(*) from bank.order;

select count(order_id) from bank.order;

select max(amount) from bank.order;
select min(amount) from bank.order;

select floor(avg(amount)) from bank.order;
select ceiling(avg(amount)) from bank.order;
```


 String Functions</summary>

```sql
select length('himanshu');
select *, length(k_symbol) as 'Symbol_length' from bank.order;
select *, concat(order_id, account_id) as 'concat' from bank.order;

-- formats the number to a form with commas,
-- 2 is the number of decimal places, converts numeric to string as well
select *, format(amount, 2) from bank.loan;

select *, lower(A2), upper(A3) from bank.district;
-- It is interesting to note that select lower(A2), upper(A3), * from bank.district; doesn't work

select A2, left(A2,5), A3, ltrim(A3) from bank.district;
-- Similar to ltrim() there is rtrim() and trim(). And similar to left() there is right()
```
In the first table, the column `date` is of type integer. So we will convert the column into date format.
For now, this change will only be temporary as we not altering the structure of the table where the column has been defined.

```sql
select account_id, district_id, frequency, convert(date,date) from bank.account;
```

In the function, `convert()`, the first argument is the name of the column and the second is the type to which you want to convert. Similarly, we can do it for the `loan` table:
`select CONVERT(date,date) from bank.loan;`.

```sql
select account_id, district_id, frequency, CONVERT(date,datetime) from bank.account;

-- next is a two step process:
select substring_index(issued, ' ', 1) from bank.card;
select convert(SUBSTRING_INDEX(issued, ' ', 1), date) from bank.card;
```

A list of formats can be found [here](https://www.w3schools.com/sql/func_mysql_date_format.asp).

```sql
-- converting the original format to the date format that we need:
select date_format(convert(date,date), '%Y-%M-%D') from bank.loan;

-- if we just want to extract some specific part of the date
select date_format(convert(date,date), '%Y') from bank.loan;
```

**Logical Order Processing of Queries**

1.  FROM
2.  ON
3.  JOIN
4.  WHERE
5.  GROUP BY
6.  WITH CUBE/ROLLUP
7.  HAVING
8.  SELECT
9.  DISTINCT
10. ORDER BY
11. TOP/LIMIT
12. OFFSET/FETCH
```sql
select * from bank.card
where type = 'classic'
order by card_id
limit 10;

select * from bank.order
where k_symbol = 'SIPO' and amount > 5000
order by order_id desc
limit 10;
```



<summary> Click for Code Sample: Null functions </summary>

```sql
select isnull('Hello');
select isnull(card_id) from bank.card;

-- this is used to check all the elements of a column.
-- 0 means not null, 1 means null
select sum(isnull(card_id)) from bank.card;

select * from bank.order
where k_symbol is null;
```

As you might have noticed in this case, even though we see a lot of missing values in the column `k_symbol`, the above query does not filter those rows. It might be because those columns actually have value, for example, empty space. SQL considers that as a character/ value as well. So we will check for that now:

```sql
select * from bank.order
where k_symbol is not null and k_symbol = ' ';
```

</details>

<details>
<summary> Click for Code Sample: Case Statements </summary>

In the `loan` table, there's column status A, B, C, and D. Using the case statement we will try to replace the values there with a brief description.

```sql
select loan_id, account_id,
case
when status = 'A' then 'Good - Contract Finished'
when status = 'B' then 'Defaulter - Contract Finished'
when status = 'C' then 'Good - Contract Running'
else 'In Debt - Contract Running'
end as 'Status_Description'
from bank.loan;

====================================================================================

```sql
select A3 from bank.district;
select distinct A3 from bank.district;
```

```sql
select * from bank.order
where k_symbol in ('leasing', 'pojistine');
```


```sql
select * from bank.account
where district_id in (1,2,3,4,5);
```

```sql
-- We are trying to get the same result using the between operator.
-- Note that 1 and 5 are included in the range of values compared/evaluated

select * from bank.account
where district_id between 1 and 5;

select * from bank.loan
where amount - payments between 1000 and 10000;
```


```sql
select * from bank.district
where A3 like 'north%';

select * from bank.district
where a3 like 'north_M%';
-- This would return all the results for
-- 'north  Moravia', 'northMoravia', northMiami'
```

```sql
select * from bank.district
where a3 regexp 'north';

-- Now we will take a look at another table
-- to see the difference between LIKE and REGEXP
select * from bank.order
where k_symbol regexp 's';

select * from bank.order
where k_symbol regexp '^s';

select * from bank.order
where k_symbol regexp 'o$';

-- We can include multiple conditions at the same time
select distinct k_symbol from bank.order
where k_symbol regexp 'ip|is';
```
```sql
select distinct a2 from bank.district
order by a2;

select distinct a2 from bank.district
order by a2 asc;

select * from bank.district
order by a3;

select * from bank.district
order by a3 desc;
```


```sql
select * from bank.order
order by account_id, bank_to;

select * from bank.order
order by account_id, bank_to, k_symbol;
```


- In the table definition of `account_demo`, the column date was defined as _integer_ type. We will modify the column to _date_ type.

```sql
alter table account_demo
modify date date;
select * from account_demo;
```

> Drop a column

```sql
alter table district_demo
drop column A15;
select * from district_demo;
```

> Rename table name

```sql
alter table account_demo
rename to accountDemo;
```

> Rename column name in a table

```sql
alter table district_demo
rename column A1 to dist_id;
```

> Add a new column

```sql
alter table accountDemo
add column balance int(11) after date;

===================================================================================


```sql
-- deletes the record where the condition is met
delete from account_demo where account_id = 1;

-- deletes all the contents from the table without deleting the table
delete from account_demo;
```


  It is important to note the difference between DELETE and DROP.
  `DELETE` only removes the contents of the table, while the `DROP` command removes the table from the database. (Remember we used the statement `drop table if exists district_demo;` before we created the table in the database to make sure that it doesn't already exist in the database.)



```sql
delete from district_demo;
```


<summary> Click for Code Sample: INSERT </summary>


```sql
show variables like 'local_infile';
set global local_infile = 1;
```

```sql
delete from district_demo;

load data local infile './district.csv' -- this file is at files_for_lesson_and_activities folder
into table district_demo
fields terminated by ',';
```


```sql
delete from account_demo;

load data local infile './account.csv' -- this file is at files_for_lesson_and_activities folders
into table account_demo
fields terminated BY ',';
```
```sql
update district_demo
set A4 = 0, A5 = 0, A6 = 0
where A2 = 'Kladno';
```


<summary> Click for Code Sample: Simple Aggregations </summary>
 
We will keep using the `bank` database and its `loan` table.

```sql
-- what is the total amount loaned by the bank so far
select sum(amount) from bank.loan;

-- what is the total amount that the bank has recovered/received from the customers
select sum(payments) from bank.loan;

-- what is the average loan amount taken by customers in Status A
select avg(amount) from bank.loan
where Status = 'A';
```

</details>

<details> 
  <summary> Click for Code Sample: Simple GROUP BY </summary>

```sql
select avg(amount) from bank.loan
group by Status;
```

```sql
select avg(amount) as Average, status from bank.loan
group by Status
order by Average asc;
```
```sql
-- step1:
select round(avg(amount),2) as "Avg Amount", round(avg(payments),2) as "Avg Payment", status
from bank.loan
group by status
order by status;

-- step 2:
select round(avg(amount),2) - round(avg(payments),2) as "Avg Balance", status
from bank.loan
group by status
order by status;
```

 In this example, we use the `bank.order` table.

```sql
-- Find the average amount of transactions for each different kind of k_symbol

select round(avg(amount),2) as Average, k_symbol from bank.order
group by k_symbol
order by Average asc;
```

As you can see, whichever `k_symbol` was empty, those values were also aggregated. We can remove those values by using a simple filter on it.

```sql
select round(avg(amount),2) as Average, k_symbol from bank.order
where k_symbol<> ' '
group by k_symbol
order by Average asc;
```

```sql
-- the same query with NOT operator

select round(avg(amount),2) as Average, k_symbol from bank.order
where not k_symbol = ' '
group by k_symbol
order by Average asc;
```

<summary> Click for Code Sample: GROUP BY on multiple columns </summary>

```sql
select round(avg(amount),2) - round(avg(payments),2) as "Avg Balance", status, duration
from bank.loan
group by status, duration
order by status, duration;
```



```sql
select round(avg(amount),2) - round(avg(payments),2) as "Avg Balance", status, duration
from bank.loan
group by status, duration
order by duration, status;
```

You can add more layers with the `GROUP BY` clause to further group the data based on multiple columns. For this example, we will take a look at the transaction table in the database. We want to analyze the average balance based on the `type`, `operation` and `k_symbol` fields:

```sql
-- Query without the "order by" clause
select type, operation, k_symbol, round(avg(balance),2)
from bank.trans
group by type, operation, k_symbol;
```

```sql
-- Query with the "order by" clause
select type, operation, k_symbol, round(avg(balance),2)
from bank.trans
group by type, operation, k_symbol
order by type, operation, k_symbol;

======================================================================================


