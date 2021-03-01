Use sakila;
select * from film_category;
select * from category;
select * from film;
#List number of films per category.
select count(*), name
from film_category as f
left join category as c
on f.category_id = c.category_id
group by name;

#Display the first and last names, as well as the address, of each staff member.
select first_name, last_name, email from staff;

#Display the total amount rung up by each staff member in August of 2005.

select sum(amount), first_name, last_name from payment as p
inner join staff as s
on p.staff_id = s.staff_id
where substr(payment_date, 6, 2) = 8
group by p.staff_id;

#List each film and the number of actors who are listed for that film

select * from film;
select * from film_actor;

select count(actor_id), a.film_id, f.title 
from film_actor as a
inner join film as f
on a.film_id = f.film_id
group by a.film_id;

#Using the tables payment and customer and the JOIN command, 
#list the total paid by each customer. List the customers alphabetically by last name.
select * from payment;
select * from customer;

select sum(amount), p.customer_id, c.last_name from payment as p
inner join customer as c
on p.customer_id = c.customer_id
group by p.customer_id
order by last_name asc;


