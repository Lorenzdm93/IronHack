Use sakila;

#Write a query to display for each store its store ID, city, and country.
select * from country; #(to city with country_id)
select * from city; #(to addres via city_id)
select * from store; #(to address via address_id)
select * from address;

select store.store_id, city, country
from address as a
inner join store
on store.address_id= a.address_id
inner join city
on city.city_id = a.city_id
inner join country
on country.country_id = city.country_id;

#Write a query to display how much business, in dollars, each 

select * from payment;
select * from staff;

select sum(amount), store_id
from payment as p
inner join staff as s
on p.staff_id = s.staff_id
group by store_id;

#What is the average running time of films by category?
select * from category;
select * from film_category;
select * from film;

select avg(length) as avglength, c.category_id, c.name
from film_category as fc
inner join category as c
on fc.category_id = c.category_id
inner join film as f
on f.film_id = fc.film_id
group by c.name
order by avglength desc; 

#Which film categories are longest?
select avg(length) as avglength, c.category_id, c.name
from film_category as fc
inner join category as c
on fc.category_id = c.category_id
inner join film as f
on f.film_id = fc.film_id
group by c.name
order by avglength desc
limit 3;

#Display the most frequently rented movies in descending order.
select * from rental;
select * from film;
select * from inventory;

select count(*), f.film_id, title
from rental as r
inner join inventory as i
on r.inventory_id = i.inventory_id
inner join film as f
on f.film_id = i.film_id
group by f.film_id
order by count(*) desc;

#List the top five genres in gross revenue in descending order.
select * from payment;
select * from rental;
select * from inventory;
select * from film;
select * from film_category;
select * from category;

select sum(amount), c.name 
from payment as p
inner join rental as r
on p.rental_id = r.rental_id
inner join inventory as i
on i.inventory_id = r.inventory_id
inner join film as f
on f.film_id = i.film_id
inner join film_category as fc
on f.film_id = fc.film_id
inner join category as c
on c.category_id = fc.category_id
group by c.name
order by sum(amount) desc;

#Is "Academy Dinosaur" available for rent from Store 1?
select * from rental;
select * from inventory;
select * from film;

select f.title, r.return_date, i.store_id, i.inventory_id
from rental as r
inner join inventory as i
on r.inventory_id = i.inventory_id
inner join film as f
on f.film_id = i.film_id
where f.title = 'Academy Dinosaur'
order by title asc;