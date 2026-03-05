CREATE DATABASE AutoDb;
GO

USE AutoDb;
GO
CREATE TABLE categories
(
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);
CREATE TABLE products
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    model_year INT,
    list_price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);
INSERT INTO categories VALUES
(1,'Mountain Bikes'),
(2,'Road Bikes'),
(3,'Electric Bikes');
INSERT INTO products VALUES
(101,'Trail Bike',2017,900,1),
(102,'Mountain Pro',2018,1200,1),
(103,'Roadster',2017,800,2),
(104,'Speed Road',2018,1500,2),
(105,'E-Bike Lite',2019,2000,3),
(106,'E-Bike Pro',2019,2500,3);

SELECT * FROM categories;
SELECT * FROM products;
--1. Retrieve product details (product_name, model_year, list_price) --

SELECT product_name, model_year, list_price
FROM products;
--2. Compare each product’s price with the average price of products in the same category using a nested query. --
SELECT 
    product_name,
    model_year,
    list_price,
    (
        SELECT AVG(list_price)
        FROM products p2
        WHERE p2.category_id = p1.category_id
    ) AS Category_Avg_Price
FROM products p1;

--3. Display only those products whose price is greater than the category average.--

SELECT 
    product_name,
    model_year,
    list_price
FROM products p1
WHERE list_price > (
        SELECT AVG(list_price)
        FROM products p2
        WHERE p2.category_id = p1.category_id
);

--4. Show calculated difference between product price and category average.--

SELECT 
    product_name,
    model_year,
    list_price,
    list_price - (
        SELECT AVG(list_price)
        FROM products p2
        WHERE p2.category_id = p1.category_id
    ) AS Price_Difference
FROM products p1;

--5. Concatenate product name and model year as a single column (e.g., 'ProductName (2017)').--
SELECT 
    product_name + ' (' + CAST(model_year AS VARCHAR(10)) + ')' AS Product_Details
FROM products;