-- =============================================
-- STEP 1: Create Database
-- =============================================
CREATE DATABASE SalesDB;
GO

USE SalesDB;
GO

-- =============================================
-- STEP 2: Create Stores Table
-- =============================================
CREATE TABLE Stores (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100)
);

-- =============================================
-- STEP 3: Create Orders Table
-- =============================================
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_status INT,   -- 4 = Completed
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- =============================================
-- STEP 4: Create Order_Items Table
-- =============================================
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(4,2),  -- Example: 0.10 = 10%
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- =============================================
-- STEP 5: Insert Sample Data
-- =============================================

-- Insert Stores
INSERT INTO Stores VALUES
(1, 'Hyderabad'),
(2, 'Bangalore'),
(3, 'Chennai');

-- Insert Orders (only some completed)
INSERT INTO Orders VALUES
(101, 4, 1),  -- Completed
(102, 4, 2),  -- Completed
(103, 1, 3),  -- Pending
(104, 4, 1);  -- Completed

-- Insert Order Items
INSERT INTO Order_Items VALUES
(1, 101, 2, 1000, 0.10),  -- 2 * 1000 * 0.9 = 1800
(2, 102, 1, 2000, 0.05),  -- 1 * 2000 * 0.95 = 1900
(3, 103, 3, 1500, 0.10),  -- Pending (ignored)
(4, 104, 1, 3000, 0.00);  -- 1 * 3000 = 3000

-- =============================================
-- STEP 6: Final Required Query
-- =============================================
SELECT 
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM Stores s
INNER JOIN Orders o
    ON s.store_id = o.store_id
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 4
GROUP BY s.store_name
ORDER BY total_sales DESC;