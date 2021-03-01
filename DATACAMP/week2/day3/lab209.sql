Use sakila;


select * from rental;

select * from rental WHERE rental_date LIKE '%2005-05%';


drop table if exists rentals_may;
CREATE TABLE rentals_may (
  rental_id int(11) UNIQUE NOT NULL,
  rental_date date DEFAULT NULL,
  inventory_id int(20) DEFAULT NULL,
  customer_id int(11) DEFAULT NULL,
  return_date date DEFAULT NULL,
  staff_id int(11) DEFAULT NULL,
  last_update date DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (rental_id)  -- constraint keyword is optional but its a good practice
);

insert into rentals_may 
select * from rental WHERE rental_date LIKE '%2005-05%';

select * from rentals_may;

drop table if exists rentals_june;
CREATE TABLE rentals_june (
  rental_id int(11) UNIQUE NOT NULL,
  rental_date date DEFAULT NULL,
  inventory_id int(20) DEFAULT NULL,
  customer_id int(11) DEFAULT NULL,
  return_date date DEFAULT NULL,
  staff_id int(11) DEFAULT NULL,
  last_update date DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (rental_id)  -- constraint keyword is optional but its a good practice
);

insert into rentals_june 
select * from rental WHERE rental_date LIKE '%2005-06%';

select * from rentals_june;

#Check the number of rentals for each customer for May.
SELECT customer_id, count(customer_id) from rentals_may
group by customer_id
order by customer_id, rental_id;

#Check the number of rentals for each customer for June.
SELECT customer_id, count(customer_id) from rentals_june
group by customer_id
order by customer_id, rental_id;
