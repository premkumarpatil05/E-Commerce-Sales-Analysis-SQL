CREATE DATABASE ecommerce_db;

USE ecommerce_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1,'Rahul Sharma','Mumbai'),
(2,'Priya Patel','Pune'),
(3,'Amit Verma','Delhi'),
(4,'Sneha Joshi','Nagpur'),
(5,'Rohit Kumar','Bangalore');

INSERT INTO products VALUES
(101,'Laptop','Electronics',50000),
(102,'Mobile','Electronics',20000),
(103,'Headphones','Accessories',2000),
(104,'Keyboard','Accessories',1500),
(105,'Mouse','Accessories',800);

INSERT INTO orders VALUES
(1001,1,'2026-05-01'),
(1002,2,'2026-05-02'),
(1003,3,'2026-05-03'),
(1004,1,'2026-05-04'),
(1005,4,'2026-05-05');

INSERT INTO order_details VALUES
(1,1001,101,1),
(2,1001,103,2),
(3,1002,102,1),
(4,1003,104,3),
(5,1004,101,1),
(6,1004,105,2),
(7,1005,103,4);

SELECT SUM(p.price * od.quantity) AS Total_Revenue
FROM order_details od
JOIN products p
ON od.product_id = p.product_id;

SELECT
    p.product_name,
    SUM(od.quantity) AS Total_Quantity_Sold
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Total_Quantity_Sold DESC;

SELECT
    c.customer_name,
    COUNT(o.order_id) AS Total_Orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY Total_Orders DESC;

SELECT
    p.product_name,
    SUM(p.price * od.quantity) AS Revenue
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY Revenue DESC;

