CREATE DATABASE RetailStoreDb;
GO

USE RetailStoreDb;
GO
CREATE TABLE Stores
(
    store_id INT PRIMARY KEY,
    store_name VARCHAR(50),
    city VARCHAR(50)
);
CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    store_id INT,
    order_date DATE,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);
CREATE TABLE Order_Items
(
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
CREATE TABLE Stocks
(
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);
INSERT INTO Stores VALUES
(1,'City Auto','Hyderabad'),
(2,'Metro Motors','Mumbai'),
(3,'Speed Wheels','Delhi');
INSERT INTO Orders VALUES
(101,1,'2024-01-10'),
(102,2,'2024-01-12'),
(103,1,'2024-01-15'),
(104,3,'2024-01-18');
INSERT INTO Order_Items VALUES
(1,101,201,2,5000),
(2,101,202,1,8000),
(3,102,203,3,3000),
(4,103,201,1,5000),
(5,104,204,2,7000);
INSERT INTO Stocks VALUES
(1,201,0),
(1,202,5),
(2,203,0),
(3,204,10);

--1. Identify products sold in each store using nested queries.--

SELECT 
    s.store_id,
    s.store_name,
    t.product_id
FROM Stores s
JOIN
(
    SELECT 
        o.store_id,
        oi.product_id
    FROM Orders o
    JOIN Order_Items oi
    ON o.order_id = oi.order_id
) t
ON s.store_id = t.store_id;

--2. Compare sold products with current stock using INTERSECT and EXCEPT operators.--

SELECT product_id
FROM Order_Items

INTERSECT

SELECT product_id
FROM Stocks;

--3. Display store_name, product_name, total quantity sold.--

SELECT 
    s.store_name,
    oi.product_id,
    SUM(oi.quantity) AS total_quantity_sold
FROM Stores s
JOIN Orders o 
    ON s.store_id = o.store_id
JOIN Order_Items oi 
    ON o.order_id = oi.order_id
GROUP BY 
    s.store_name,
    oi.product_id;

--4. Calculate total revenue per product (quantity × list_price – discount).--

SELECT 
    product_id,
    SUM(quantity * list_price) AS total_revenue
FROM Order_Items
GROUP BY product_id;

--5. Update stock quantity to 0 for discontinued products (simulation).--

UPDATE Stocks
SET quantity = 0
WHERE product_id = 202;

SELECT * FROM Stocks;