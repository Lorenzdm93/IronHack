use sakila;

#List each pair of actors that have worked together.
select * from actor;
select * from film_actor;

select distinct a.actor_id, b.actor_id 
from film_actor as a
join film_actor as b
on a.film_id = b.film_id and a.actor_id <> b.actor_id
where a.actor_id > b.actor_id
order by a.actor_id;
 
#For each film, list actor that has acted in more films.
select * from film;
select * from film_actor;

#list of all actors with multiple movies 
select actor_id from (select actor_id, count(*) from film_actor
group by actor_id
having count(film_id)> 1)sub;

#list of all movies containing one actor with multiple movies 
select film_id from film_actor
where actor_id in (select actor_id from (select actor_id, count(*) from film_actor
group by actor_id
having count(film_id)> 1)sub);

select title, fa.actor_id, fa.film_id from film_actor as fa
join film as f
on fa.film_id = f.film_id
where fa.film_id in (select film_id from film_actor
				where actor_id in (select actor_id from (select actor_id, count(*) from film_actor
				group by actor_id
				having count(film_id)> 1)sub));
                
			    #since we feed a list of only the movies 
                #in which one actor has multiple movies we are simulataneously filtering for actors as well.
