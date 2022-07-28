-- SQL LAB 2.7

USE sakila;

-- 1. How many films are there for each of the categories in the category table. Use appropriate join to write this query.
SELECT 
	c.name as category, 
	count(f.film_id) as films
FROM film_category as f
JOIN category as c
ON f.category_id = c.category_id
GROUP BY c.name
ORDER BY c.name ASC;

-- 2. Display the total amount rung up by each staff member in August of 2005.
SELECT CONCAT(s.first_name, ' ', s.last_name) as staff_name, sum(p.amount) as total_amount_august
FROM payment as p
JOIN staff as s
ON p.staff_id = s.staff_id
WHERE date_format(p.payment_date, "%M %Y") LIKE 'August 2005'
GROUP BY staff_name;

-- 3. Which actor has appeared in the most films?
SELECT 
	CONCAT(a.first_name, ' ', a.last_name) as name, 
	COUNT(a.actor_id) as apparitions
FROM film_actor as fa
JOIN actor as a
ON fa.actor_id = a.actor_id
GROUP BY name
ORDER BY COUNT(a.actor_id) DESC LIMIT 1;


-- 4. Most active customer (the customer that has rented the most number of films)
SELECT 
	CONCAT(c.first_name, ' ', c.last_name) as customer_name, 
    COUNT(r.rental_id) as num_movies_rented
FROM rental as r
JOIN customer as c
ON r.customer_id = c.customer_id
GROUP BY customer_name
ORDER BY COUNT(r.rental_id) DESC LIMIT 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
SELECT 
	CONCAT(s.first_name, ' ', s.last_name) as Name,
	CONCAT(a.address, ', ', a.district) as Full_address
FROM staff as s
LEFT JOIN address as a
ON s.address_id = a.address_id;


-- 6. List each film and the number of actors who are listed for that film.
SELECT
	f.title as movie,
	count(fa.actor_id) as number_of_actors
FROM film_actor as fa
LEFT JOIN film as f
ON fa.film_id = f.film_id
GROUP BY f.title
ORDER BY f.title ASC;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
-- List the customers alphabetically by last name.
SELECT
	CONCAT(c.first_name, ' ', c.last_name) as full_name,
	sum(p.amount) as paid_amount
FROM payment as p
LEFT JOIN customer as c
ON p.customer_id = c.customer_id
GROUP BY full_name
ORDER BY c.last_name ASC;