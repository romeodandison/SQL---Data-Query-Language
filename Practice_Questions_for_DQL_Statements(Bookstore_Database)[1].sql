-- ### Practice Questions for Data Query Language (DQL) Statements ###

-- 1. Retrieve all authors.
SELECT * FROM Authors

-- 2. Retrieve the names and email addresses of all customers.
SELECT name, email FROM customers

-- 3. List all books along with their authors' names.
SELECT books.title, authors.author_name
FROM books
FULL OUTER JOIN authors ON books.author_id=authors.author_id
ORDER BY books.title;

-- 4. Find all books published before the year 2000.
SELECT * FROM books
WHERE Publication_year <2000
ORDER BY Publication_year;

-- 5. Get the total number of books written by British authors.
SELECT COUNT(*) AS numberofbooks, authors.nationality
FROM books
JOIN authors ON books.author_id=authors.author_id
WHERE nationality= 'British'
GROUP BY nationality;


-- 6. Retrieve the titles of all books reviewed by 'John Doe'.
SELECT books.title
FROM books
FULL OUTER JOIN Reviews ON books.book_id=reviews.book_id
FULL OUTER JOIN Customers ON customers.Customer_id=reviews.customer_id
WHERE name = 'John Doe'
ORDER BY title


-- 7. Find the average rating for each book.
SELECT book_ID, AVG(rating) AS AVG_Rating
FROM Reviews
GROUP BY book_id

-- 8. List all orders made in the year 2023.
SELECT * FROM orders
WHERE order_date LIKE '2023%'
ORDER BY order_date

-- 9. Retrieve the most recent review for each book.
SELECT books.title, reviews.review_text, Orders.order_date
FROM Books
JOIN Reviews ON books.book_id=Reviews.book_id
JOIN Orders ON Reviews.book_id=Orders.book_id
WHERE Orders.order_date IN (
SELECT MAX (O2.order_date) FROM Orders O2
GROUP BY O2.book_id
)


--Another solution to Question 9
WITH LatestOrders AS (
	SELECT book_id, MAX(Order_date) most_recent_order_date
	FROM Orders
	GROUP BY book_id
	)
	SELECT Books.title, Reviews.review_text, most_recent_order_date
	FROM Books
	JOIN Reviews ON Books.book_id=Reviews.book_id
	JOIN LatestOrders ON Reviews.book_id=LatestOrders.book_id
	ORDER BY LatestOrders.most_recent_order_date DESC

-- 10. Find all customers who have never placed an order.
SELECT * FROM customers
FULL OUTER JOIN Orders ON customers.Customer_id=orders.customer_id
WHERE Order_id = 0

-- 11. List the top 5 highest-rated books based on average ratings.
SELECT TOP 5 AVG(rating) AS AVG_rating, Books.title
FROM Reviews
JOIN Books ON Reviews.book_id=books.book_id
WHERE AVG(rating) >= 4

-- 12. Retrieve the details of all American authors.
SELECT * FROM Authors
WHERE nationality = 'American'

-- 13. Find the total number of orders placed by each customer.
SELECT COUNT(*) AS Total_order, customer_id FROM Orders
GROUP BY customer_id

-- 14. List the titles of all books and their corresponding review texts.
SELECT books.title, Reviews.review_text
FROM Books
FULL OUTER JOIN Reviews ON books.book_id=reviews.book_id
ORDER BY books.title

-- 15. Retrieve the names of all authors who have written more than one book. 
SELECT authors.author_name
FROM authors
JOIN Books ON Books.author_id=Authors.author_id
GROUP BY authors.author_name
HAVING COUNT(books.book_id) > 1


-- 16. Retrieve all books with the word 'the' in the title (case-insensitive).
SELECT * FROM books
WHERE title like  '%the%'
ORDER BY title;

-- 17. Find all customers whose email addresses end with 'example.com'.
SELECT * FROM customers
WHERE email LIKE '%example.com'
ORDER BY email

-- 18. Retrieve the names and birthdates of customers born in the 1980s.
SELECT name, birthdate FROM customers
WHERE  birthdate BETWEEN '1980-01-01' AND '1989-12-31'
ORDER BY birthdate

-- 19. List all authors from either the 'British' or 'American' nationality using a set operator.
SELECT author_name, nationality FROM Authors
WHERE nationality LIKE 'British' OR nationality LIKE 'American'
ORDER BY nationality

-- 20. Retrieve the titles and publication years of books published after 2000 but not in 2023 using a set operator.
SELECT title, publication_year FROM books
WHERE Publication_year >= 2000 AND Publication_year < 2023
ORDER BY Publication_year ASC

-- 21. Find all books whose titles start with 'The'.
SELECT  title FROM books
WHERE title like  'The%'
ORDER BY title;

-- 22. Retrieve the titles of books and their genres where the genre contains 'Fiction'.
SELECT title, genre FROM books
WHERE genre = 'Fiction'

-- 23. List the names of customers who have either 'John' or 'Jane' in their name.
SELECT name FROM customers
WHERE name LIKE 'John%' OR  name LIKE 'Jane%'

-- 24. Find all authors whose names end with 'ing'.
SELECT author_name FROM authors
WHERE author_name LIKE '%ing';

-- 25. Retrieve the names and nationalities of authors where the name contains exactly five letters.
SELECT author_name, nationality FROM authors
WHERE author_name LIKE '_____'
ORDER BY author_name;
