Use sakila;

#Get all pairs of actors that worked together.
select f1.actor_id, f2.actor_id, f1.film_id
from film_actor as f1
join film_actor as f2
on f1.film_id =f2.film_id
where f1.actor_id <> f2.actor_id and f1.actor_id > f2.actor_id
order by film_id, f1.actor_id, f2.actor_id;

#Get all pairs of customers that have rented the same film more than 3 times.

select * from rental;
select * from inventory;

select *
from
(select  in2.film_id, a1.customer_id as First_pair, a2.customer_id as Second_pair , count(*) as number_films, rank() over(partition by a1.customer_id order by a2.customer_id) as Ranks
from sakila.customer a1
inner join rental re1 on re1.customer_id = a1.customer_id
inner join inventory in1 on (re1.inventory_id = in1.inventory_id)
inner join film fa1 on in1.film_id=fa1.film_id
inner join inventory in2 on (fa1.film_id = in2.film_id)
inner join rental re2 on re2.inventory_id=in2.inventory_id
inner join customer a2 on re2.customer_id=a2.customer_id
where a1.customer_id <> a2.customer_id
group by a1.customer_id, a2.customer_id
having count(*)>3
order by number_films desc)tab
where Ranks=1;

#Get all possible pairs of actors and films.

select *
from sakila.actor
cross join
sakila.film
limit 100;
