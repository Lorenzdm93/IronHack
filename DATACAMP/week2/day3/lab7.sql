#PART1

Use sakila;
drop table if exists films_2020;
CREATE TABLE films_2020 (
  film_id smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  description text,
  release_year year(4) DEFAULT NULL,
  language_id tinyint(3) unsigned NOT NULL,
  original_language_id tinyint(3) unsigned DEFAULT NULL,
  rental_duration int(6),
  rental_rate decimal(4,2),
  length smallint(5) unsigned DEFAULT NULL,
  replacement_cost decimal(5,2) DEFAULT NULL,
  rating enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (film_id),
  CONSTRAINT FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

load data local infile 'C:\Users\Lorenzo\IronHack\DATACAMP\week2\day4\dataV3_Lesson_2.7_lab\files_for_part1\films_2020.csv'
into table films_2020
fields terminated by ',' 
IGNORE 1 ROWS;

show variables like 'local_infile';
set global local_infile = 1;
 


#PART 2
#showing only not repeated names
SELECT last_name, first_name 
FROM actor
group by last_name
having last_name < 2; 

#show names that appear more than once
SELECT last_name, first_name 
FROM actor
group by last_name
having count(last_name) > 1;

#show how many rentals were processed by each employee
SELECT * from rental;
SELECT count(*), staff_id from rental
group by staff_id;

#show how many film released each year
SELECT * from film;
SELECT count(*), film_id, release_year from film
group by release_year;

#show how many film for each rating
SELECT count(*), film_id, rating from film
group by rating;

#average length, group by rating, round to 2 decimals
SELECT round(avg(length), 2) as average, rating, film_id from film
group by rating;

#average group with highest average above 2hrs
SELECT round(avg(length), 2) as average, rating, film_id from film
group by rating
having round(avg(length), 2) > 120;

#LAB part 2 completed