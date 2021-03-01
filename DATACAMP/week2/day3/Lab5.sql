
Use sakila;

select * from sakila.actor
where first_name = ‘SCARLETT’;

select count(*) from sakila.film;
select count(*) from sakila.rental;

select max(rental_duration) as max_duration, min(rental_duration) as min_duration
from sakila.film;

select floor(avg(length) / 60) as hours, round(avg(length) % 60) as minutes
from sakila.film;

select count(distinct last_name)
from actor;

select datediff(max(rental_date), min(rental_date)) as active_days
from rental;

select *, date_format(rental_date, ‘%M’) as month , date_format(rental_date, ‘%W’) as weekday
from rental
limit 20;

select *, case when date_format(rental_date, ‘%W’) in (‘Saturday’, ‘Sunday’)
          then ‘weekend’
          else ‘workday’ end as day_type
from rental;

select date(max(rental_date))
from rental;
select *, date_format(`rental_date`, “%M”) as Month_,
date_format(`rental_date`, “%Y”) as Year_
from rental
having Month_ = ‘October’ and Year_ = 2020;