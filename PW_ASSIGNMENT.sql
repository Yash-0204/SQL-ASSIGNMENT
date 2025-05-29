##Q>1

CREATE TABLE employees (
    emp_id INT PRIMARY KEY NOT NULL,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email TEXT NOT NULL,
    salary DECIMAL(10, 2) DEFAULT 30000.00,
    UNIQUE KEY (email(255))
);

##Q>2>> 

##Constraints in a database are rules applied to table columns or entire tables to enforce data accuracy, consistency, and validity. 
##They ensure that the data adheres to defined standards and business rules, thereby maintaining the integrity of the database.

## THERE ARE SEVERAL TYPES LIKE PRIMARY KEY, FOREING KEY, NOT NULL, CHECK, DEFAULT, UNIQUE KEY.alter

##Q>3>> 

##Applying the NOT NULL constraint to a column ensures that every record in the table must have a value for that column; 
##it cannot be left empty or undefined. This is crucial for maintaining data integrity, especially for fields that are essential for the application's logic or business rules.
##No, a primary key cannot contain NULL values. The primary key serves as a unique identifier for each record in a table, 
##and allowing NULL would violate this uniqueness and the principle of entity integrity.

##Q>4>> 

##To add or remove constraints on an existing SQL table, you use the ALTER TABLE statement. 
##This allows you to modify the table's structure without recreating it. The exact syntax can vary depending on the database system (e.g., MySQL, PostgreSQL, SQL Server), 
##so it's essential to consult your specific database documentation.

##ADDING A CONSTRAINT

##ALTER TABLE EMPLOYEEE
## ADD CONSTRAIN chk_AGe CHECK(AGE>+18)

##REMOVING A CONSTRAINT

## ALTER TABLE EMPLOYEE
## DROP  CONSTRAINT chk_AGe;

##Q>5>> 

##Consequences of Violating Constraints>>  1: OPERATION FAILURE,  2: ERROR MESSAGES, 3: TRANSACTION ROLLBACK, 4: APPLICATION IMPACT

##EXAMPLE  
##null value in column "email" violates not-null constraint

##Q>6>> 

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));

ALTER TABLE products
ADD PRIMARY KEY (product_id);
ALTER TABLE products
MODIFY price DECIMAL(10, 2) DEFAULT 50.00;

##Q>7>> 

cREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class_id INT
);

INSERT INTO Students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

create table classes (
class_id INT PRIMARY KEY,
class_name VARCHAR(50));

insert into classes(class_id, class_name) values
(101, "Maths"),
(102, "Science"),
(103, "History");

select  Students.student_id, Students.student_name, classes.class_name from Students
inner join classes
on
Students.class_id = classes.class_id; 


##Q>8>> 

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255)
);

CREATE TABLE Orders1 (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Productss (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

INSERT INTO Products (product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);

SELECT
    O.order_id,
    C.customer_name,
    P.product_name
FROM
    Orders AS O
INNER JOIN
    Customers AS C
ON
    O.customer_id = C.customer_id
LEFT JOIN
    Products AS P
ON
    O.order_id = P.order_id;
    
 #Q>9>>>
 
 CREATE TABLE SALES (
 sale_id int Primary key,
 product_id int,
 amount int);
 
 CREATE TABLE PRODUCTS (
 product_id int,
 product_name VARCHAR(10));
 
 INSERT INTO SALES VALUES
 (1, 101, 500),
 (2, 102, 300),
 (3, 101, 700);
 
 INSERT INTO PRODUCTS VALUES
 (101, "LAPTOP", null),
 (102, "PHONE", NULL);
 
 SELECT 
  SALES.sale_id, 
  SUM(SALES.amount) AS SA, 
  PRODUCTS.product_name 
FROM 
  SALES
INNER JOIN 
  PRODUCTS ON SALES.product_id = PRODUCTS.product_id
GROUP BY 
  SALES.sale_id, PRODUCTS.product_name;

 ##Q>10>> 
 
 create table orders10( 
 order_id int ,
 order_date date,
 customer_id int);
 
create table customers10( 
customer_id INT,
customer_name varchar(20));

CREATE TABLE order_details10(
order_id INT ,
product_id INT,
quantity INT);

INSERT INTO orders10 values
(1, 2024-01-02, 1),
(2, 2024-01-05, 2);

INSERT INTO customers9 values
(1, "ALICE"),
(2, "BOB");

INSERT INTO order_details10 values
(1,101,2),
(1,102,1),
(2,101,3);


select orders10.order_id, customers10.customer_name, order_details10.quantity from orders10

inner join customers10
on 
orders10.customer_id = customers10.customer_id

inner join order_details10
on
orders10.order_id = order_details10.order_id;

##SQL COMMANDS

##  1>>>Identify the primary keys and foreign keys in maven movies db. Discuss the difference

use mavenmovies;
SELECT 
    tc.table_name,
    kcu.column_name,
    tc.constraint_name
FROM 
    information_schema.table_constraints AS tc
JOIN 
    information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
WHERE 
    constraint_type = 'PRIMARY KEY';
    
sELECT 
tc.table_name,
kcu.column_name,
ccu.table_name AS foreign_table_name,
ccu.column_name AS foreign_column_name,
tc.constraint_name
FROM 
information_schema.table_constraints AS tc
JOIN 
information_schema.key_column_usage AS kcu
ON tc.constraint_name = kcu.constraint_name
JOIN 
information_schema.constraint_column_usage AS ccu
ON ccu.constraint_name = tc.constraint_name
WHERE 
tc.constraint_type = 'FOREIGN KEY';


##  2>>  List all details of actors

use mavenmovies;
select * from actor;

## 3>> List all customer information from DB.

select * from customer;

## 4>>  List different countries.

select * from country;

## 5>> Display all active customers.

select * from customer_list;

## 6>> List of all rental IDs for customer with ID 1.

select * from rental;
Select rental_id, customer_id from rental
order by rental_id;


## 7>>> Display all the films whose rental duration is greater than 5 .

select * from film
where rental_duration > 5;

## 8>> List the total number of films whose replacement cost is greater than $15 and less than $20.

Select * from film
where replacement_cost between 15 and 20
order by replacement_cost;

## 9>> - Display the count of unique first names of actors.

select * from actor;
select count(distinct first_name) as UNIQUE_FIRST_NAME
from actor;

## 10>>  Display the first 10 records from the customer table .

Select * from customer
limit 10;

## 11>> Display the first 3 records from the customer table whose first name starts with ‘b’.

select * from customer
where first_name LIKE "b%"
limit 3;

##  12>> Display the names of the first 5 movies which are rated as ‘G’.

select * from film
where rating like "G"
limit 5;

## 13>> Find all customers whose first name starts with "a".

select * from customer
where first_name like "a%";

## 14>> Find all customers whose first name ends with "a".

select * from customer
where first_name like "a%";

## 15>> Display the list of first 4 cities which start and end with ‘a’ 

select * from city
where city like "a%a"
limit 4;

## 16>>  Find all customers whose first name have "NI" in any position.

select * from customer
where first_name like "%NI%";

## 17>> Find all customers whose first name have "r" in the second position .

select * from customer
where first_name like "_r%";

## 18>>> Find all customers whose first name starts with "a" and are at least 5 characters in length.

select * from customer
where first_name like "a%" and length(first_name>=5);

## 19>>>  Find all customers whose first name starts with "a" and ends with "o".

select * from customer
where first_name like "a%" and first_name like "%o";

## 20>> Get the films with pg and pg-13 rating using IN operator.

select * from film
where rating in ("PG", "PG-13");

##  21>>>>   Get the films with length between 50 to 100 using between operator.

select * from film
where length between 50 and 100;

## 22>>  Get the top 50 actors using limit operator.

select * from actor
limit 50;

## 23>> Get the distinct film ids from inventory table.

select * from inventory;
select distinct film_id  from inventory;



###FUNCTION

## BASIC AGGREGATE FUNCTIONS

## Q>1>>> Retrieve the total number of rentals made in the Sakila database

use sakila;
select COUNT(*) as TOTAL_RENTAL
from rental;

## Q>2>> Find the average rental duration (in days) of movies rented from the Sakila database

select * from rental;
SELECT AVG(rental_duration) AS average_rental_duration
FROM film;

## Q> 3>> Display the first name and last name of customers in uppercase.

SELECT 
    UPPER(first_name) AS first_name_upper,
    UPPER(last_name) AS last_name_upper
FROM 
    customer;

## Q.4>> Extract the month from the rental date and display it alongside the rental ID.

select * from rental;
select rental_id, month(rental_date) from rental;

#### GROUP BY

##Q> 5>> Retrieve the count of rentals for each customer (display customer ID and the count of rentals).

select * from rental;
select customer_id, count(rental_id) as NO_OF_RENTALS 
from rental
group by customer_id;

## Q>6>> Find the total revenue generated by each store.

SELECT 
    s.store_id,
    SUM(p.amount) AS total_revenue
FROM 
    payment p
JOIN 
    staff s ON p.staff_id = s.staff_id
GROUP BY 
    s.store_id;
    
# Q>7>>Determine the total number of rentals for each category of movies.     

select * from film_category;
select * from film;
select * from rental;

SELECT 
    c.name AS category_name,
    COUNT(r.rental_id) AS total_rentals
FROM 
    rental r
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
JOIN 
    film_category fc ON f.film_id = fc.film_id
JOIN 
    category c ON fc.category_id = c.category_id
GROUP BY 
    c.name
ORDER BY 
    total_rentals DESC;
    
## Q>8>> Find the average rental rate of movies in each language.

select * from film;
select * from language;

SELECT 
    l.name AS language_name,
    AVG(f.rental_rate) AS average_rental_rate
FROM 
    film f
JOIN 
    language l ON f.language_id = l.language_id
GROUP BY 
    l.name
ORDER BY 
    average_rental_rate DESC;

### JOINS

## Q>9>>> Display the title of the movie, customer s first name, and last name who rented it.

Select * from film;
select * from inventory;
select * from rental;
select * from customer;

select film.title as FL, customer.first_name as CFN, customer.last_name as CLN from film
inner join inventory
on
film.film_id = inventory.film_id
inner join rental
on
inventory.inventory_id = rental.inventory_id
inner join customer
on 
rental.customer_id = customer.customer_id;

## Q>10>> Retrieve the names of all actors who have appeared in the film "Gone with the Wind."

Select * from film_actor;
select * from actor;
select * from film;

Select actor.first_name as ACTOR_FIRST_NAME, actor.last_name as ACTOR_LAST_NAME, 
film.title as FILM_TITLE from film
inner join film_actor
on 
film.film_id = film_actor.film_id
inner join actor
on
film_actor.actor_id = actor.actor_id
where film.title = 'Gone with the Wind';

## Q>>11  Retrieve the customer names along with the total amount they've spent on rentals.

use sakila;
select * from customer as c;
select * from payment as p;
select * from rental as r;

SELECT 
    c.first_name AS FIRST_NAME,
    c.last_name AS LAST_NAME,
    SUM(p.amount) AS TOTAL_SPENT
FROM 
    customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    TOTAL_SPENT DESC;
    
## Q>12>> List the titles of movies rented by each customer in a particular city (e.g., 'London'). 

SELECT 
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    ci.city AS city,
    f.title AS movie_title
FROM 
    customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE 
    ci.city = 'London'
ORDER BY 
    c.last_name, c.first_name, f.title;
    
    
### ADVANCE JOINS AND GROUP BY 

###Q>>13> Display the top 5 rented movies along with the number of times they've been rented.

use sakila;
select * from film;
select * from inventory;
select * from rental;

select film.title, count(rental_id) from film
inner join inventory
on
film.film_id = inventory.film_id
inner join rental
on
inventory.inventory_id = rental.inventory_id
group by title
limit 5;

## Q>14>>  Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).

select * from rental as r;
select * from inventory as i;
select * from customer as c;

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r 
ON 
c.customer_id = r.customer_id
JOIN inventory i 
ON 
r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;

##   WINDOWS FUNCTION

## Q > 1>>  Rank the customers based on the total amount they've spent on rentals.

select * from customer;
select * from payment;

SELECT
    customer.customer_id,
    customer.first_name,
    customer.last_name,
    SUM(payment.amount) AS TOTAL_SPENT,
    RANK() OVER (ORDER BY SUM(payment.amount) DESC) AS CUSTOMER_RANK
FROM customer
INNER JOIN payment 
ON 
customer.customer_id = payment.customer_id
GROUP BY customer.customer_id, customer.first_name, customer.last_name
ORDER BY TOTAL_SPENT DESC;

### Q> 2>>> Calculate the cumulative revenue generated by each film over time.

select * from film;
select * from inventory;
select * from payment;
select * from rental;

SELECT
    f.title AS film_title,
    r.rental_date,
    SUM(p.amount) OVER (
        PARTITION BY f.film_id
        ORDER BY r.rental_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.title, r.rental_date;


## Q> 3>> Determine the average rental duration for each film, considering films with similar lengths.

SELECT
    f.length AS film_length,
    ROUND(AVG(DATEDIFF(r.return_date, r.rental_date)), 2) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.return_date IS NOT NULL
GROUP BY f.length
ORDER BY f.length;


## Q> 4>> . Identify the top 3 films in each category based on their rental counts.

SELECT
    category_name,
    film_title,
    rental_count
FROM (
    SELECT
        c.name AS category_name,
        f.title AS film_title,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (
            PARTITION BY c.category_id
            ORDER BY COUNT(r.rental_id) DESC
        ) AS rank1
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY c.category_id, c.name, f.film_id, f.title
) AS ranked_films
WHERE rank1 <= 3
ORDER BY category_name, rank1;

## Q>5>>  Calculate the difference in rental counts between each customer's total rentals and the average rentals
##across all customers.

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals,
    ROUND(AVG(COUNT(r.rental_id)) OVER (), 2) AS average_rentals,
    COUNT(r.rental_id) - ROUND(AVG(COUNT(r.rental_id)) OVER (), 2) AS difference
FROM
    customer c
JOIN
    rental r ON c.customer_id = r.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    difference DESC;

## Q>6>> Find the monthly revenue trend for the entire rental store over time

SELECT
    DATE_FORMAT(rental.rental_date, '%Y-%m') AS month,
    ROUND(SUM(payment.amount), 2) AS total_revenue
FROM
    rental
JOIN
    payment ON rental.rental_id = payment.rental_id
GROUP BY
    DATE_FORMAT(rental.rental_date, '%Y-%m')
ORDER BY
    month ASC;

## Q>7>>  Identify the customers whose total spending on rentals falls within the top 20% of all customers.

SELECT
    customer_id,
    first_name,
    last_name,
    total_spent
FROM (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spent,
        NTILE(5) OVER (ORDER BY SUM(p.amount) DESC) AS spending_quintile
    FROM
        customer c
    JOIN
        payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
) AS customer_spending
WHERE
    spending_quintile = 1
ORDER BY
    total_spent DESC;


##Q>8>> Calculate the running total of rentals per category, ordered by rental count.

SELECT
    category_name,
    rental_count,
    SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM (
    SELECT
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        category c
    JOIN
        film_category fc ON c.category_id = fc.category_id
    JOIN
        inventory i ON fc.film_id = i.film_id
    JOIN
        rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name
) AS category_rentals
ORDER BY
    rental_count DESC;
    
##Q>> 9>>    Find the films that have been rented less than the average rental count for their respective categor 


SELECT
    f.title,
    c.name AS category,
    film_rentals.rental_count,
    category_avg.avg_rentals
FROM
    (
        SELECT
            fc.film_id,
            fc.category_id,
            COUNT(r.rental_id) AS rental_count
        FROM
            film_category fc
        JOIN
            inventory i ON fc.film_id = i.film_id
        LEFT JOIN
            rental r ON i.inventory_id = r.inventory_id
        GROUP BY
            fc.film_id,
            fc.category_id
    ) AS film_rentals
JOIN
    (
        SELECT
            fc.category_id,
            AVG(film_count.rental_count) AS avg_rentals
        FROM
            film_category fc
        JOIN
            (
                SELECT
                    fc.film_id,
                    fc.category_id,
                    COUNT(r.rental_id) AS rental_count
                FROM
                    film_category fc
                JOIN
                    inventory i ON fc.film_id = i.film_id
                LEFT JOIN
                    rental r ON i.inventory_id = r.inventory_id
                GROUP BY
                    fc.film_id,
                    fc.category_id
            ) AS film_count ON fc.film_id = film_count.film_id AND fc.category_id = film_count.category_id
        GROUP BY
            fc.category_id
    ) AS category_avg ON film_rentals.category_id = category_avg.category_id
JOIN
    film f ON film_rentals.film_id = f.film_id
JOIN
    category c ON film_rentals.category_id = c.category_id
WHERE
    film_rentals.rental_count < category_avg.avg_rentals
ORDER BY
    c.name,
    film_rentals.rental_count ASC;


## Q>> 10>> Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT
    DATE_FORMAT(p.payment_date, '%Y-%m') AS month,
    ROUND(SUM(p.amount), 2) AS total_revenue
FROM
    payment p
GROUP BY
    DATE_FORMAT(p.payment_date, '%Y-%m')
ORDER BY
    total_revenue DESC
LIMIT 5;


##### NORMALISATION AND CTE

##Q>>>1 

##In the Sakila database, all tables are designed to comply with the First Normal Form (1NF),
## ensuring that each field contains atomic values and there are no repeating groups.

##Q>2> 

##While the Sakila database is well-normalized, understanding how to identify and resolve 2NF violations is crucial in database design. By decomposing tables to eliminate partial dependencies,
##we ensure that each non-prime attribute is fully functionally dependent on the entire primary key, thereby achieving 2NF

## Q>3> 

##While the Sakila database is well-normalized, understanding how to identify and resolve 3NF violations is crucial in database design. By decomposing tables to eliminate transitive dependencies, 
##we ensure that each non-prime attribute is directly dependent on the primary key, thereby achieving 3NF.

##Q>4>> 

#Step 1: Unnormalized Form (UNF)
#In the UNF, data is stored with repeating groups and multiple values in a single field.
#Here, the purchased_items field contains multiple values, which violates the first normal form (1NF).

#Step 2: First Normal Form (1NF)
##To achieve 1NF, we ensure that each field contains only atomic (indivisible) values and eliminate repeating groups.

#Step 3: Second Normal Form (2NF)
#To achieve 2NF, the table must first be in 1NF, and then we remove partial dependencies. 
#A partial dependency occurs when a non-prime attribute is functionally dependent on a part of a composite primary key.

#Step 4: Third Normal Form (3NF)
#To achieve 3NF, the table must first be in 2NF, and then we remove transitive dependencies. 
#A transitive dependency occurs when a non-prime attribute depends on another non-prime attribute.
#Analysis:
#In the Customers table, name depends on customer_id.
#There are no transitive dependencies in this structure.

#Conclusion:
#The tables are already in 3NF, as there are no transitive dependencies.

##Q>5>> 
WITH ActorFilmCount AS (
    SELECT
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor a
    LEFT JOIN
        film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id
)
SELECT
    actor_name,
    film_count
FROM
    ActorFilmCount
ORDER BY
    film_count DESC;

##Q>6>> 

WITH FilmLanguage AS (
    SELECT
        f.title AS film_title,
        l.name AS language_name
    FROM
        film f
    JOIN
        language l ON f.language_id = l.language_id
)
SELECT
    film_title,
    language_name
FROM
    FilmLanguage
ORDER BY
    film_title;


##Q>7>> 

WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer c
    JOIN
        payment p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id
)
SELECT
    customer_name,
    total_revenue
FROM
    CustomerRevenue
ORDER BY
    total_revenue DESC;

##Q>8>> 

WITH FilmRentalRank AS (
    SELECT
        f.film_id,
        f.title,
        f.rental_duration,
        RANK() OVER (ORDER BY f.rental_duration DESC) AS rental_rank
    FROM
        film f
)
SELECT
    film_id,
    title,
    rental_duration,
    rental_rank
FROM
    FilmRentalRank
ORDER BY
    rental_rank;

##Q>9>> 

WITH RentalCounts AS (
    SELECT
        r.customer_id,
        COUNT(r.rental_id) AS rental_count
    FROM
        rental r
    GROUP BY
        r.customer_id
    HAVING
        COUNT(r.rental_id) > 2
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    rc.rental_count
FROM
    customer c
JOIN
    RentalCounts rc ON c.customer_id = rc.customer_id
ORDER BY
    rc.rental_count DESC;


##Q> 10>> 

WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(r.rental_date, '%Y-%m') AS month,
        COUNT(r.rental_id) AS rental_count
    FROM
        rental r
    GROUP BY
        month
)
SELECT
    month,
    rental_count
FROM
    MonthlyRentals
ORDER BY
    month;


##Q> 11>> 

WITH ActorPairs AS (
    SELECT
        fa1.film_id,
        fa1.actor_id AS actor_id_1,
        fa2.actor_id AS actor_id_2
    FROM
        film_actor fa1
    JOIN
        film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE
        fa1.actor_id < fa2.actor_id
)
SELECT
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor_1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor_2,
    COUNT(ap.film_id) AS films_together
FROM
    ActorPairs ap
JOIN
    actor a1 ON ap.actor_id_1 = a1.actor_id
JOIN
    actor a2 ON ap.actor_id_2 = a2.actor_id
GROUP BY
    ap.actor_id_1, ap.actor_id_2
ORDER BY
    films_together DESC;


##Q> 12>> 

WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the manager (root of the hierarchy)
    SELECT employee_id, first_name, last_name, manager_id
    FROM staff
    WHERE manager_id = ManagerID  -- Replace <ManagerID> with the specific manager's ID

    UNION ALL

    -- Recursive member: Select employees who report to the employees in the previous level
    SELECT s.employee_id, s.first_name, s.last_name, s.manager_id
    FROM staff s
    INNER JOIN EmployeeHierarchy eh ON s.manager_id = eh.employee_id
)
SELECT * FROM EmployeeHierarchy;




