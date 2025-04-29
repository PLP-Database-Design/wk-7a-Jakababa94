CREATE DATABASE IF NOT EXISTS purchase;
USE purchase;
-- Question 1: Normalize the ProductDetail table to 1NF

-- Create the original ProductDetail table
CREATE TABLE IF NOT EXISTS ProductDetail (
    Order_ID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(255)
);

-- Insert sample data
INSERT INTO ProductDetail (Order_ID, CustomerName, Products) VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(102, 'Jane Smith', 'Tablet, Keyboard, Mouse'),
(103, 'Emily Clark', 'Phone');

-- Create the normalized table
CREATE TABLE ProductDetail_1NF (
    Order_ID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert normalized data using MySQL string functions
INSERT INTO ProductDetail_1NF (Order_ID, CustomerName, Product)
SELECT 
    Order_ID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(CONCAT(Products, ','), ',', numbers.n), ',', -1)) AS Product
FROM 
    ProductDetail
JOIN
    (
        SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL 
        SELECT 4 UNION ALL SELECT 5  -- Add more numbers if needed for more products
    ) numbers
ON 
    CHAR_LENGTH(Products) - CHAR_LENGTH(REPLACE(Products, ',', '')) >= numbers.n - 1
HAVING Product != '';

-- View the normalized results
SELECT * FROM ProductDetail_1NF ORDER BY Order_ID;

-- Question 2: Normalize the OrderDetails table to 2NF
-- Create the original OrderDetails table (1NF)
CREATE TABLE IF NOT EXISTS OrderDetails_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT
);

-- Insert sample data
INSERT INTO OrderDetails_1NF (OrderID, CustomerName, Product, Quantity) VALUES
(101, 'John Doe', 'Laptop', 2),
(101, 'John Doe', 'Mouse', 1),
(102, 'Jane Smith', 'Tablet', 3),
(102, 'Jane Smith', 'Keyboard', 1),
(102, 'Jane Smith', 'Mouse', 2),
(103, 'Emily Clark', 'Phone', 1);

-- Create Orders table (contains OrderID and CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderDetails table (contains OrderID, Product, and Quantity)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into Orders table (removing duplicates)
INSERT INTO Orders (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails_1NF;

-- Insert data into OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails_1NF;

-- View the normalized results
SELECT * FROM Orders ORDER BY OrderID;
SELECT * FROM OrderDetails_2NF ORDER BY OrderID, Product;