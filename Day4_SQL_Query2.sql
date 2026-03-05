CREATE DATABASE CustomerDb;
GO

USE CustomerDb;
GO
CREATE TABLE customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);
CREATE TABLE orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_value DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO customers VALUES
(1,'Ravi'),
(2,'Sri'),
(3,'Lekha'),
(4,'Rahul'),
(5,'Sneha');
INSERT INTO orders VALUES
(101,1,5000),
(102,1,3000),
(103,2,2000),
(104,3,8000);
SELECT * FROM customers;
SELECT * FROM orders;

--1. Use nested query to calculate total order value per customer.--

SELECT 
    c.customer_id,
    c.customer_name,
    (
        SELECT SUM(o.order_value)
        FROM Orders o
        WHERE o.customer_id = c.customer_id
    ) AS total_order_value
FROM Customers c;

--2. Classify customers using conditional logic --

SELECT 
    c.customer_id,
    (
        SELECT SUM(o.order_value)
        FROM Orders o
        WHERE o.customer_id = c.customer_id
    ) AS total_order_value,
    
    CASE
        WHEN (
            SELECT SUM(o.order_value)
            FROM Orders o
            WHERE o.customer_id = c.customer_id
        ) > 10000 THEN 'Premium'
        
        WHEN (
            SELECT SUM(o.order_value)
            FROM Orders o
            WHERE o.customer_id = c.customer_id
        ) BETWEEN 5000 AND 10000 THEN 'Regular'
        
        ELSE 'Basic'
    END AS customer_type
FROM Customers c;
   
-- 3. Use UNION to display customers with orders and customers without orders.--

-- Customers who have placed orders
SELECT 
    c.customer_id,
    c.customer_name,
    'Has Orders' AS order_status
FROM Customers c
JOIN Orders o 
ON c.customer_id = o.customer_id

UNION

-- Customers who have not placed orders
SELECT 
    c.customer_id,
    c.customer_name,
    'No Orders' AS order_status
FROM Customers c
WHERE c.customer_id NOT IN (
    SELECT customer_id FROM Orders
);

--4. Display full name using string concatenation.--

SELECT 
    customer_id,
    customer_name + ' (' + CAST(customer_id AS VARCHAR) + ')' AS full_name
FROM Customers;

--5. Handle NULL cases appropriately.--
SELECT 
    c.customer_id,
    c.customer_name,
    ISNULL(
        (
            SELECT SUM(o.order_value)
            FROM Orders o
            WHERE o.customer_id = c.customer_id
        ), 0
    ) AS total_order_value
FROM Customers c;