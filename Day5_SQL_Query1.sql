--- 1.Create EcommDb and all tables using the provided schema.--

CREATE DATABASE EcommDb;
GO

USE EcommDb;
GO

CREATE TABLE Customers
(
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE Categories
(
    category_id INT PRIMARY KEY IDENTITY(1,1),
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Products
(
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category_id INT,
    
    CONSTRAINT FK_Product_Category
    FOREIGN KEY (category_id)
    REFERENCES Categories(category_id)
);

CREATE TABLE Orders
(
    order_id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT,
    order_date DATE,

    CONSTRAINT FK_Order_Customer
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems
(
    order_item_id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT,
    product_id INT,
    quantity INT,

    CONSTRAINT FK_OrderItems_Order
    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    CONSTRAINT FK_OrderItems_Product
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id)
);

SELECT * FROM Customers;
SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderItems;


--2.Insert at least 5 records in categories, brands, products, customers, and stores.--

-- Insert into Categories
INSERT INTO Categories (category_name) VALUES ('SUV');
INSERT INTO Categories (category_name) VALUES ('Sedan');
INSERT INTO Categories (category_name) VALUES ('Hatchback');
INSERT INTO Categories (category_name) VALUES ('Electric');
INSERT INTO Categories (category_name) VALUES ('Luxury');

-- Insert into Brands
INSERT INTO Brands (brand_name) VALUES ('Toyota');
INSERT INTO Brands (brand_name) VALUES ('Honda');
INSERT INTO Brands (brand_name) VALUES ('Hyundai');
INSERT INTO Brands (brand_name) VALUES ('Tata');
INSERT INTO Brands (brand_name) VALUES ('BMW');

-- Insert into Products
INSERT INTO Products (product_name, brand_id, category_id, model_year, list_price) 
VALUES ('Fortuner',1,1,2023,3500000);

INSERT INTO Products (product_name, brand_id, category_id, model_year, list_price) 
VALUES ('City',2,2,2023,1500000);

INSERT INTO Products (product_name, brand_id, category_id, model_year, list_price) 
VALUES ('i20',3,3,2022,900000);

INSERT INTO Products (product_name, brand_id, category_id, model_year, list_price) 
VALUES ('Nexon EV',4,4,2023,1700000);

INSERT INTO Products (product_name, brand_id, category_id, model_year, list_price) 
VALUES ('X5',5,5,2024,8500000);

-- Insert into Customers
INSERT INTO Customers (first_name,last_name,phone,email,city)
VALUES ('Rahul','Sharma','9876543210','rahul@gmail.com','Hyderabad');

INSERT INTO Customers (first_name,last_name,phone,email,city)
VALUES ('Priya','Reddy','9876501234','priya@gmail.com','Vijayawada');

INSERT INTO Customers (first_name,last_name,phone,email,city)
VALUES ('Arjun','Kumar','9123456780','arjun@gmail.com','Chennai');

INSERT INTO Customers (first_name,last_name,phone,email,city)
VALUES ('Sneha','Patel','9012345678','sneha@gmail.com','Mumbai');

INSERT INTO Customers (first_name,last_name,phone,email,city)
VALUES ('Kiran','Verma','9988776655','kiran@gmail.com','Bangalore');

-- Insert into Stores
INSERT INTO Stores (store_name,phone,city)
VALUES ('AutoWorld','9876541111','Hyderabad');

INSERT INTO Stores (store_name,phone,city)
VALUES ('CarHub','9876542222','Chennai');

INSERT INTO Stores (store_name,phone,city)
VALUES ('DriveZone','9876543333','Mumbai');

INSERT INTO Stores (store_name,phone,city)
VALUES ('MotorPoint','9876544444','Bangalore');

INSERT INTO Stores (store_name,phone,city)
VALUES ('SpeedMotors','9876545555','Pune');

--3.Write SELECT queries to retrieve all products with their brand and category names.--

SELECT 
    p.product_name,
    b.brand_name,
    c.category_name
FROM Products AS p
INNER JOIN Brands AS b 
    ON p.brand_id = b.brand_id
INNER JOIN Categories AS c 
    ON p.category_id = c.category_id;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Products';

--4.Retrieve all customers from a specific city.--

SELECT *
FROM Customers
WHERE city = 'Hyderabad';

--5.Display total number of products available in each category.--

SELECT 
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM Categories c
JOIN Products p 
    ON c.category_id = p.category_id
GROUP BY c.category_name;