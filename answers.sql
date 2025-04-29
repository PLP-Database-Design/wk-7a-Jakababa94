-- -- Questin one

-- Create a new table to store the normalized data
CREATE TABLE ProductDetail_1NF (
    Order_ID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

-- Insert normalized data into the new table
INSERT INTO ProductDetail_1NF (Order_ID, CustomerName, Product)
SELECT 
    Order_ID,
    CustomerName,
    TRIM(value) AS Product
FROM 
    ProductDetail
CROSS APPLY STRING_SPLIT(Products, ',');

-- Query the normalized table to verify the result
SELECT * FROM ProductDetail_1NF;

-- Question two

-- Create a table for orders (OrderID and CustomerName)
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create a table for order details (OrderID, Product, and Quantity)
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (Order_ID, Product),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);

-- Insert data into the Orders table
INSERT INTO Orders (Order_ID, CustomerName)
VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

-- Insert data into the OrderDetails_2NF table
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);

-- Query the normalized tables to verify the result
SELECT * FROM Orders;
SELECT * FROM OrderDetails_2NF;