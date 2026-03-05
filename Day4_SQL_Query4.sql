CREATE DATABASE OrderMaintenanceDb;
GO

USE OrderMaintenanceDb;
GO
CREATE TABLE Customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);
CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
CREATE TABLE Orders_Archive
(
    order_id INT,
    customer_id INT,
    order_date DATE,
    order_status VARCHAR(20)
);
INSERT INTO Customers VALUES
(1,'Ravi'),
(2,'Anita'),
(3,'Kiran');
INSERT INTO Orders VALUES
(101,1,'2023-01-10','Completed'),
(102,2,'2022-05-12','Rejected'),
(103,3,'2021-08-20','Completed'),
(104,1,'2024-02-15','Pending');
INSERT INTO Orders_Archive
SELECT *
FROM Orders
WHERE order_date < DATEADD(YEAR,-2,GETDATE());
DELETE FROM Orders
WHERE order_id IN
(
    SELECT order_id
    FROM Orders
    WHERE order_status = 'Rejected'
);
SELECT 
    order_id,
    order_date,
    CASE
        WHEN DATEDIFF(YEAR,order_date,GETDATE()) > 2 THEN 'Old Order'
        ELSE 'Recent Order'
    END AS order_category
FROM Orders;

--1. Insert archived records into a new table (archived_orders) using INSERT INTO SELECT.--
INSERT INTO archived_orders (order_id, customer_id, order_date, order_status)
SELECT order_id, customer_id, order_date, order_status
FROM Orders
WHERE order_date < DATEADD(YEAR, -1, GETDATE());
SELECT * FROM archived_orders;
SELECT * FROM Orders;

--2. Delete orders where order_status = 3 (Rejected) and older than 1 year.--

DELETE FROM Orders
WHERE order_id IN
(
    SELECT order_id
    FROM Orders
    WHERE order_status = 'Rejected'
    AND order_date < DATEADD(YEAR, -1, GETDATE())
);

SELECT *
FROM Orders
WHERE order_status = 'Rejected'
AND order_date < DATEADD(YEAR, -1, GETDATE());

--3. Use nested query to identify customers whose all orders are completed.--

SELECT customer_id
FROM Customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM Orders
    WHERE order_status <> 'Completed'
);

--4. Display order processing delay (DATEDIFF between shipped_date and order_date).--

SELECT 
    order_id,
    order_date,
    shipped_date,
    DATEDIFF(DAY, order_date, shipped_date) AS processing_delay_days
FROM Orders;
GO

--5. Mark orders as 'Delayed' or 'On Time' using CASE expression based on required_date.--

ALTER TABLE Orders
ADD required_date DATE;

UPDATE Orders
SET required_date = DATEADD(DAY, 5, order_date)
WHERE required_date IS NULL;

SELECT 
    order_id,
    order_date,
    required_date,
    shipped_date,
    
    CASE
        WHEN shipped_date > required_date THEN 'Delayed'
        ELSE 'On Time'
    END AS order_status

FROM Orders;