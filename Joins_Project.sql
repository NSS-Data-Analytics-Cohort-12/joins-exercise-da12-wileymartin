Select *
From distributors;

Select * 
From rating;

Select * 
From revenue;

Select * 
From specs;

--- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

Select * 
From distributors As d
	Inner Join specs as s
	On d.distributor_id = s.domestic_distributor_id
	Inner Join revenue AS r
	ON s.movie_id = r.movie_id
Order by worldwide_gross ASC;

--- The movie's name is "Oh, God !", the release year is 1977, and the worldwide gross was $41,687,243.

	
--- 2. What year has the highest average imdb rating?

Select release_year, AVG(imdb_rating)
From specs AS s 
	RIGHT JOIN rating as r
	USING(movie_id)
Group BY release_year
Order BY AVG(imdb_rating) DESC;

--- 1991
	

--- 3. What is the highest grossing G-rated movie? Which company distributed it?

Select mpaa_rating,company_name,film_title,worldwide_gross
From specs AS s
	Left JOIN  distributors as d
	ON d.distributor_id = s.domestic_distributor_id
	Inner Join revenue as r
	Using (movie_id)
WHERE mpaa_rating = 'G'
Order BY worldwide_gross DESC;

--- Highest grossing G rate movie is Toy Story 4 by Walt Disney


--- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies

table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

Select distributor_id,company_name, COUNT(movie_id)
From specs AS s
	LEFT JOIN distributors as d
	ON d.distributor_id = s.domestic_distributor_id
Group BY d.distributor_id,d.company_name
ORDER BY count DESC;
	

--- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT distributor_id, AVG(film_budget)
FROM revenue as r
	LEFT JOIN specs AS s
	USING (movie_id)
	LEFT JOIN distributors as d
	ON s.domestic_distributor_id = d.distributor_id
GROUP BY distributor_id
ORDER BY AVG(film_budget) DESC
LIMIT 5;



--- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

Select imdb_rating, COUNT(movie_id),headquarters
FROM rating AS r
	LEFT JOIN specs as s
	USING (movie_id)
	LEFT JOIN distributors as d
	ON d.distributor_id = s.domestic_distributor_id
Where headquarters NOT LIKE '%CA%'
GROUP BY imdb_rating, headquarters
ORDER BY imdb_rating DESC;

--- Chicago, IL had the hoighest rating of companies not headquarter in CA 

--- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT AVG(imdb_rating), length_in_min
FROM rating as r
	LEFT JOIN specs AS s 
	USING (movie_id)
Where length_in_min BETWEEN 0 AND 400 
GROUP BY length_in_min
ORDER BY avg(imdb_rating) DESC;

--- It appears that movies that are more than two hours long have a higher rating. 
