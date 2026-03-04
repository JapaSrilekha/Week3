-- =============================================
-- STEP 1: Create Database
-- =============================================
CREATE DATABASE StoreDB;
GO

USE StoreDB;
GO

-- =============================================
-- STEP 2: Create Customers Table
-- =============================================
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);
GO

-- =============================================
-- STEP 3: Create Orders Table
-- =============================================
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_status INT,  -- 1 = Pending, 4 = Completed
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
GO

-- =============================================
-- STEP 4: Insert Sample Data into Customers
-- =============================================
INSERT INTO Customers (customer_id, first_name, last_name)
VALUES
(1, 'Sri', 'Lekha'),
(2, 'Snehith', 'Raj'),
(3, 'Suresh', 'Kumar');
GO

-- =============================================
-- STEP 5: Insert Orders Data
-- 3 Completed (4)
-- 1 Pending (1)
-- =============================================
INSERT INTO Orders (order_id, order_date, order_status, customer_id)
VALUES
(201, '2024-02-01', 4, 1),  -- Completed
(202, '2024-02-05', 4, 2),  -- Completed
(203, '2024-02-10', 4, 3),  -- Completed
(204, '2024-02-15', 1, 1);  -- Pending
GO

-- =============================================
-- STEP 6: Final Required Query
-- =============================================
SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 1 
   OR o.order_status = 4
ORDER BY o.order_date DESC;
GO