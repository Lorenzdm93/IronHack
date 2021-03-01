Use sakila;

#How many copies of the film Hunchback Impossible exist in the inventory system?
select a.film_id, a.title, count(*) 
from film as a
join inventory as b
on a.film_id = b.film_id
where a.title = 'Hunchback Impossible';

#List all films whose length is longer than the average of all the films.
select title, length
from film
where length > (select avg(length) from film)
order by length;

#Use subqueries to display all actors who appear in the film Alone Trip.
select * from film;
select * from film_actor;
select * from actor;

select a.first_name, a.last_name, f.title from film as f
join film_actor as fa
on f.film_id = fa.film_id
join actor as a
on fa.actor_id = a.actor_id
where f.title = 'Alone Trip';

select * from actor where actor_id in ((select actor_id from film_actor where film_id = (select film_id from film where title = 'Alone trip')));

#Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select * from film_category;
select * from category;
select * from film;

select f.title, c.name from film as f
join film_category as fc
on f.film_id = fc.film_id
join category as c
on fc.category_id = c.category_id
where c.name = 'family';

#Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, 
#you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
select * from customer;
select * from store;
select * from address;
select * from city;
select * from country;

-- solution with join
select c.first_name, c.last_name, co.country 
from customer as c
-- join store as s
-- on c.store_id = s.store_id
join address as a
on s.address_id = s.address_id
join city as ci
on a.city_id = ci.city_id
join country as co
on ci.country_id = co.country_id
where co.country = 'canada';

-- solution with subqueries
select first_name, email from customer where address_id in #(store_id)
-- (select store_id from store where address_id in
(select address_id from address where city_id in
(select city_id from city where country_id in
(select country_id from country where country = 'canada')));

#Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
select * from actor;
select * from film_actor;
select * from actor;
select * from film;

select title from film
where film_id in
(
select film_id from film_actor
where actor_id = 
(select actor_id from 
(select a.actor_id, a.first_name, a.last_name, count(a.actor_id) as count 
from actor as a
join film_actor as fa
on a.actor_id = fa.actor_id
join film as f
on f.film_id = fa.film_id
group by a.actor_id
order by count desc
limit 1
)sub1
)
);

#Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
select * from film;
select * from inventory;
select * from rental;
select * from customer;
select * from payment;

select title from film where film_id in
(select film_id from inventory where inventory_id in
(select inventory_id from rental 
where customer_id =
(select c.customer_id from customer as c
join payment as p
on c.customer_id = p.customer_id
group by customer_id
order by sum(p.amount) desc
limit 1)));

#Customers who spent more than the average payments.
select * from customer;
select * from payment;
select * from rental;

select first_name, last_name from customer where customer_id in
(select customer_id from payment
group by customer_id
having sum(amount) > (select sum(amount)/count(distinct customer_id) as avg from payment)
order by sum(amount) desc);






