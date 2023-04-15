-- creating database zomato;
create database Zomato;

-- use zomato
use zomato;

-- Creating Table zomato
CREATE TABLE `zomato` (
  `ID` int NOT NULL,
  `Name` varchar(255) DEFAULT NULL,
  `online_order` varchar(255) DEFAULT NULL,
  `book_table` varchar(255) DEFAULT NULL,
  `rating` float DEFAULT NULL,
  `votes` int DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `rest_type` varchar(255) DEFAULT NULL,
  `dish_liked` varchar(255) DEFAULT NULL,
  `cuisines` varchar(255) DEFAULT NULL,
  `approx_cost` int DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
);

select count(*)
from zomato;

/* Task 1: Write query for a high-level overview of the hotels, provide us the top 5 most voted hotels in the delivery category. */

SELECT name, votes, rating
FROM zomato
WHERE type = 'delivery'
ORDER BY votes DESC
LIMIT 5;

/* Task 2: Write query for The rating of a hotel is a key identifier in determining a restaurant’s performance. Hence for a particular
location called Banashankari find out the top 5 highly rated hotels in the delivery category. */

SELECT name, rating, location, type
FROM zomato
WHERE location = 'Banashankari' and type = 'delivery'
ORDER BY rating DESC
LIMIT 5;

/* Write a query for comparing the ratings of the cheapest and most expensive hotels in Indiranagar. */

with
tempmin as (
SELECT rating as rating1,
CAST(REPLACE(approx_cost, ',', '') AS UNSIGNED) as approx_cost1
FROM zomato 
order by approx_cost 
limit 1
),
tempmax as (
SELECT rating as rating2,
CAST(REPLACE(approx_cost, ',', '') AS UNSIGNED) as approx_cost2
FROM zomato 
order by approx_cost DESC 
limit 1)
select rating1,
rating2 
from tempmin, tempmax;

/* Task 4: Write a query for Online ordering of food has exponentially increased over time. Compare the total votes of restaurants
that provide online ordering services and those who don’t provide online ordering service. */

SELECT online_order, 
SUM(votes) AS total_votes 
FROM zomato 
GROUP BY online_order;

/* Task 5: Number of votes defines how much the customers are involved with the service provided by the restaurants For each Restaurant type,
find out the number of restaurants, total votes, and average rating. Display the data with the highest votes on the top( if the first row of
output is NA display the remaining rows).*/

SELECT type, 
COUNT(*) AS number_of_restaurants, 
SUM(votes) AS total_votes, 
AVG(rating) AS avg_rating
FROM zomato
WHERE type != 'NA'
GROUP BY type
ORDER BY CASE WHEN type = 'NA' THEN 1 ELSE 0 END, 
total_votes DESC;

/* Task 6: What is the most liked dish of the most-voted restaurant on Zomato(as the restaurant has a tie-up with Zomato, the restaurant
compulsorily provides online ordering and delivery facilities. */

select name,dish_liked,max(rating) as max_rating,max(votes) as max_votes
from zomato
group by name, dish_liked
order by max_rating desc, max_votes desc
limit 1;

/* Task 7: To increase the maximum profit, Zomato is in need to expand its business. For doing so Zomato wants the list of the top 15 restaurants
which have min 150 votes, have a rating greater than 3, and is currently not providing online ordering. Display the restaurants with highest votes
on the top. */

SELECT name, rating, votes, online_order
FROM zomato
WHERE votes >= 150 and rating > 3 and online_order = 'No'
ORDER BY votes DESC
LIMIT 15;

-- ********************************************************************************************************************************** --