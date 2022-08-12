-- Question 1
-- create a stored procedure that will insert a new film into the film table with the following arguments:
-- title, description, release_year, language_id, rental_duration, rental_rate, length, replace_cost, rating

CREATE OR REPLACE PROCEDURE add_film(
	title VARCHAR(255), 
	description VARCHAR, 
	release_year INTEGER, 
	language_id INTEGER, 
	rental_duration INTEGER, 
	rental_rate NUMERIC(4,2), 
	length INTEGER, 
	replacement_cost NUMERIC(5,2),
	rating mpaa_rating
)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating)
	VALUES (title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating);
END;
$$

SELECT *
FROM film
ORDER BY title DESC;

CALL add_film('Adaptation', 'A Movie About Orchids and Writing That Will Probably Make You Feel Weird', 2000, 1, 5, 4.99, 100, 19.99, 'R');

CALL add_film('Zoo Animals', 'A Movie About Zoo Animals', 1995, 1, 4, 5.99, 130, 14.99, 'G');



-- Question 2

-- create a stored function that will take in a category_id and return the number of films in that category

CREATE OR REPLACE FUNCTION get_num_films_in_category(num INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE num_films INTEGER;
BEGIN
	SELECT count(*) INTO num_films
	FROM category 
	JOIN film_category 
	ON category.category_id = film_category.category_id
	WHERE category.category_id = num
	GROUP BY category.category_id;
	RETURN num_films;
END;
$$

SELECT *
FROM get_num_films_in_category(4);

SELECT *
FROM get_num_films_in_category(12);



