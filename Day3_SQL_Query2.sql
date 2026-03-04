-- =============================================
-- Create Categories Table
-- =============================================
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(50)
);

-- =============================================
-- Create Brands Table
-- =============================================
CREATE TABLE Brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(50)
);

-- =============================================
-- Create Products Table
-- =============================================
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES Brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Insert Categories
INSERT INTO Categories VALUES
(1, 'Mountain Bikes'),
(2, 'Road Bikes'),
(3, 'Hybrid Bikes');

-- Insert Brands
INSERT INTO Brands VALUES
(1, 'Trek'),
(2, 'Giant'),
(3, 'Hero');

-- Insert Products
INSERT INTO Products VALUES
(101, 'Trek X-Caliber', 1, 1, 2023, 800),
(102, 'Giant Escape 3', 2, 3, 2024, 450),
(103, 'Hero Sprint', 3, 2, 2022, 600),
(104, 'Trek Marlin 7', 1, 1, 2024, 1200);

SELECT 
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM Products p
INNER JOIN Brands b
    ON p.brand_id = b.brand_id
INNER JOIN Categories c
    ON p.category_id = c.category_id
WHERE p.list_price > 500
ORDER BY p.list_price ASC;