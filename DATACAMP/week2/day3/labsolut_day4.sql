LAB 207
```
show variables like 'local_infile';
set global local_infile = 1;
```

```
load data local infile './films_2020.csv' -- provide the complete path of the file
into table films_2020
fields terminated BY ',';
```

 - Please note: If there's an error while using the above sql query, 
 please try and use the import wizard. Select the table and then 
 In the file tab, go to "Import" and follow the steps there. 
 Also make sure that while importing, select the option to ignore the first row 
 in the csv file, as that contains headers of the table.

```
update films_2020
set rental_duration = 3, rental_rate = 2.99, replacement_cost = 8.99
where description = 2020;
```

- You might not see the results right away. You might have to click on 
another table and then click back on the films_2020 to see the changes implemented. 
This is one way to refresh the table. You can also use the refresh button to see the 
changes.

=====================================================================================
 LAB 208 SOLUTIONS
 
```sql
-- 1
select title, length, RANK() over (ORDER BY length) ranks
from sakila.film
where length is not null and length > 0;

-- 2
select title, length, rating, rank() over (partition by rating order by length desc) as ranks
from sakila.film
where length is not null and length > 0;

-- 3
select name as category_name, count(*) as num_films
from sakila.category inner join sakila.film_category using (category_id)
group by name
order by num_films desc;

-- 5
select actor.actor_id, actor.first_name, actor.last_name,
count(actor_id) as film_count
from sakila.actor join sakila.film_actor using (actor_id)
group by actor_id
order by film_count desc
limit 1;

-- 5
select customer.*,
count(rental_id) as rental_count
from sakila.customer join sakila.rental using (customer_id)
group by customer_id
order by rental_count desc
limit 1;

BONUS
select film.title, count(rental_id) as rental_count
from sakila.film inner join sakila.inventory using (film_id)
inner join sakila.rental using (inventory_id)
group by film_id
order by rental_count desc
limit 1;
```

====================================================================================