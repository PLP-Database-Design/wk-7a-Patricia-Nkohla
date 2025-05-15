Question 1: Achieving 1NF (First Normal Form)

SQL Query:
SELECT OrderID, CustomerName, TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.n), ',', -1)) AS Product
FROM ProductDetail
JOIN (SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) n
ON CHAR_LENGTH(Products) -CHAR_LENGTH(REPLACE(Products, ',', '')) >= n.n - 1
ORDER BY OrderID, n.n;

Transformed Table:
OrderID | CustomerName   | Product
--------|----------------|---------
101     | John Doe       | Laptop
101     | John Doe       | Mouse
102     | Jane Smith     | Tablet
102     | Jane Smith     | Keyboard
102     | Jane Smith     | Mouse
103     | Emily Clark    | Phone

Question 2: Achieving 2NF (Second Normal Form)

SQL Query:
-- Create the Customer table
CREATE TABLE Customer (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Insert data into Customer table
INSERT INTO Customer (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create the OrderDetail table
CREATE TABLE OrderDetail (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Customer(OrderID)
);

-- Insert data into OrderDetail table
INSERT INTO OrderDetail (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;

New Tables:
Customer Table:
OrderID | CustomerName
--------|----------------
101     | John Doe
102     | Jane Smith
103     | Emily Clark

OrderDetail Table:
OrderID | Product  | Quantity
--------|----------|---------
101     | Laptop   | 2
101     | Mouse    | 1
102     | Tablet   | 3
102     | Keyboard | 1
102     | Mouse    | 2
103     | Phone    | 1

