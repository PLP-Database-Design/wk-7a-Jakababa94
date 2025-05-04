CREATE DATABASE IF NOT EXISTS OrdersDB;
USE OrdersDB;
-- Question 1: Normalize the ProductDetail table to 1NF

-- Create the ProductDetail table
CREATE TABLE IF NOT EXISTS ProductDetail (
    Order_ID INT,
    CustomerName VARCHAR(100),
    Products VARCHAR(100)
);

-- Insert sample data
INSERT INTO ProductDetail (Order_ID, CustomerName, Products) 
VALUES
(101, 'John Doe', 'Laptop, Mouse'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');


-- Question 2: Normalize the OrderDetails table to 2NF

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Insert sample data
INSERT INTO Orders (OrderID, CustomerName) 
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');


-- Create Orders table (contains OrderID and CustomerName)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create Products table (contains OrderID, Product, and Quantity)
CREATE TABLE Products (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Products (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);