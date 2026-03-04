-- =============================================
-- STEP 1: Create Database
-- =============================================
CREATE DATABASE ProductDB;
GO

USE ProductDB;
GO

-- =============================================
-- STEP 2: Create Tables
-- =============================================

CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);

CREATE TABLE Stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    product_id INT,
    store_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- =============================================
-- STEP 3: Insert Sample Data
-- =============================================

INSERT INTO Stores VALUES
(1, 'Hyderabad'),
(2, 'Bangalore');

INSERT INTO Products VALUES
(101, 'Laptop'),
(102, 'Mobile'),
(103, 'Tablet');

INSERT INTO Stocks VALUES
(1, 101, 50),
(1, 102, 30),
(2, 101, 20),
(2, 103, 40);

INSERT INTO Order_Items VALUES
(1, 101, 1, 10),
(2, 101, 2, 5),
(3, 102, 1, 8);

-- =============================================
-- STEP 4: Final Query
-- =============================================

SELECT 
    p.product_name,
    s.store_name,
    st.quantity AS available_stock,
    ISNULL(SUM(oi.quantity), 0) AS total_quantity_sold
FROM Stocks st
INNER JOIN Products p
    ON st.product_id = p.product_id
INNER JOIN Stores s
    ON st.store_id = s.store_id
LEFT JOIN Order_Items oi
    ON st.product_id = oi.product_id
    AND st.store_id = oi.store_id
GROUP BY 
    p.product_name,
    s.store_name,
    st.quantity
ORDER BY 
    p.product_name ASC;