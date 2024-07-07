--Create database called Cutomer Orders
CREATE DATABASE DQL_Checkpoint;
GO

--Switch to the newly created database
USE DQL_Checkpoint;
GO

--Create a table called Customers
CREATE TABLE Customers (
customer_id INT NOT NULL PRIMARY KEY,
customer_name VARCHAR (50) NOT NULL,
customer_address VARCHAR (50) NOT NULL,
);
GO

--Create a table called Products
CREATE TABLE Products (
product_id INT NOT NULL PRIMARY KEY,
product_name VARCHAR (50) NOT NULL,
price DECIMAL  CHECK (price>0) NOT NULL,
);
GO

--Create a table called Orders
CREATE TABLE Orders (
order_id INT NOT NULL PRIMARY KEY,
customer_id INT, FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
product_id INT, FOREIGN KEY (product_id) REFERENCES products(product_id),
quantity INT NOT NULL,
order_date DATE NOT NULL,
);
GO

-- Insert data into customers table
INSERT INTO Customers VALUES
(1, 'Alice', '123 Main St.'),
(2, 'Bob', '456 Market St.'),
(3, 'Charlie', '789 Elm St.');

--Insert data into products table
INSERT INTO Products VALUES
(1, 'Widget', '10.00'),
(2, 'Gadget', '20.00'),
(3, 'Doohickey', '15.00');

--Insert data into orders table
INSERT INTO Orders VALUES
(1, '1', '1', '10', '2021-01-01'),
(2, '1', '2', '5', '2021-01-02'),
(3, '2', '1', '3', '2021-01-03'),
(4, '2', '2', '7', '2021-01-04'),
(5, '3', '1', '2', '2021-01-05'),
(6, '3', '3', '3', '2021-01-06');


--Write a SQL query to retrieve the names of the customers who have placed an order for at least one widget and at least one gadget, along with the total cost of the widgets and gadgets ordered by each customer. The cost of each item should be calculated by multiplying the quantity by the price of the product.
SELECT Customers.customer_name, Products.product_name, (orders.quantity * products.price) AS TotalCost 
FROM Customers
JOIN Orders ON customers.customer_id=orders.customer_id
JOIN Products ON Orders.product_id=products.product_id
WHERE product_name = 'Widget' OR product_name = 'Gadget' AND Orders.quantity >=1
ORDER BY product_name


--Write a query to retrieve the names of the customers who have placed an order for at least one widget, along with the total cost of the widgets ordered by each customer.
SELECT Customers.customer_name, Products.product_name, (orders.quantity * products.price) AS TotalCost 
FROM Customers
JOIN Orders ON customers.customer_id=orders.customer_id
JOIN Products ON Orders.product_id=products.product_id
WHERE product_name = 'Widget' AND Orders.quantity >=1
ORDER BY customer_name

--Write a query to retrieve the names of the customers who have placed an order for at least one gadget, along with the total cost of the gadgets ordered by each customer.
SELECT Customers.customer_name, Products.product_name, (orders.quantity * products.price) AS TotalCost 
FROM Customers
JOIN Orders ON customers.customer_id=orders.customer_id
JOIN Products ON Orders.product_id=products.product_id
WHERE product_name = 'Gadget' AND Orders.quantity >=1
ORDER BY customer_name

--Write a query to retrieve the names of the customers who have placed an order for at least one doohickey, along with the total cost of the doohickeys ordered by each customer.
SELECT Customers.customer_name, Products.product_name, (orders.quantity * products.price) AS TotalCost 
FROM Customers
JOIN Orders ON customers.customer_id=orders.customer_id
JOIN Products ON Orders.product_id=products.product_id
WHERE product_name = 'Doohickey' AND Orders.quantity >=1
ORDER BY customer_name

--Write a query to retrieve the total number of widgets and gadgets ordered by each customer, along with the total cost of the orders.
SELECT Customers.customer_name, COUNT(Orders.quantity) AS TotalOrders, (products.price * orders.quantity) AS TotalCost 
FROM Customers
JOIN Orders ON customers.customer_id=orders.customer_id
JOIN Products ON Orders.product_id=products.product_id
WHERE product_name = 'Widget' OR product_name = 'Gadget' 
GROUP BY customer_name


--Write a query to retrieve the names of the products that have been ordered by at least one customer, along with the total quantity of each product ordered.
SELECT Products.product_name, SUM(quantity) AS Total_Qty_Ordered
FROM Products
JOIN Orders ON products.product_id=orders.product_id
WHERE orders.quantity >0
GROUP BY product_name 


--Write a query to retrieve the names of the customers who have placed the most orders, along with the total number of orders placed by each customer.
SELECT Customers.customer_name, COUNT (*) AS Total_orders
FROM Orders
JOIN Customers ON Orders.customer_id=customers.customer_id
GROUP BY customer_name


--Write a query to retrieve the names of the products that have been ordered the most, along with the total quantity of each product ordered.
SELECT Products.product_name, COUNT (*) AS Total_Order, SUM(quantity) AS TotalQty 
FROM Products
JOIN Orders ON products.product_id=orders.product_id
GROUP BY product_name 
ORDER BY Total_Order DESC;

--Write a query to retrieve the names of the customers who have placed an order on every day of the week, along with the total number of orders placed by each customer.
SELECT Customers.customer_name, COUNT(DISTINCT DATEPART(WEEKDAY, Orders.order_date)) AS days_with_orders, COUNT (*) AS Total_Order
FROM CUSTOMERS
JOIN ORDERS ON Customers.customer_id=Orders.customer_id
GROUP BY  Customers.customer_name;
   