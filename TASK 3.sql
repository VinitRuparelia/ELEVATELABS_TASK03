CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


INSERT INTO customers VALUES
(1, 'Alice Smith', 'New York', 'USA'),
(2, 'Bob Johnson', 'Los Angeles', 'USA'),
(3, 'Priya Mehra', 'Delhi', 'India'),
(4, 'John Doe', 'London', 'UK'),
(5, 'Mei Wong', 'Beijing', 'China');

INSERT INTO orders VALUES
(101, 1, '2023-01-15', 250.00),
(102, 2, '2023-02-10', 480.00),
(103, 3, '2023-03-05', 120.00),
(104, 1, '2023-04-01', 300.00),
(105, 4, '2023-04-12', 150.00),
(106, 5, '2023-05-20', 500.00),
(107, 3, '2023-06-18', 200.00);

SELECT * FROM customers;
SELECT * FROM orders;

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

INSERT INTO order_items VALUES
(1, 101, 'Laptop', 1, 800.00),
(2, 101, 'Mouse', 2, 25.00),
(3, 102, 'Keyboard', 1, 45.00),
(4, 103, 'Monitor', 1, 150.00),
(5, 104, 'Headphones', 2, 60.00),
(6, 105, 'Webcam', 1, 70.00),
(7, 106, 'Printer', 1, 120.00),
(8, 107, 'Desk Chair', 1, 200.00);

SELECT * FROM order_items;

SELECT * FROM orders
WHERE total_amount > 250;

SELECT * FROM orders
ORDER BY order_id DESC;

SELECT customer_id, COUNT(*) AS order_count, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

INSERT INTO customers VALUES
(6, 'Ravi Sharma', 'Mumbai', 'India');

SELECT c.customer_name, o.order_id, o.total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;

SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO orders VALUES
(108, 999, '2023-07-01', 600.00);
SET FOREIGN_KEY_CHECKS = 1;


SELECT c.customer_name,o.order_id,o.total_amount
FROM customers c
RIGHT JOIN orders o ON c.customer_id = o.customer_id;

SELECT * FROM orders
WHERE total_amount >
	( SELECT AVG(total_amount) from orders);
    
SELECT customer_name,
(SELECT SUM(total_amount) 
     FROM orders 
     WHERE orders.customer_id = customers.customer_id) AS total_spent
from customers;

SELECT customer_id,avg_spent
FROM (SELECT customer_id , AVG(total_amount) AS avg_spent, COUNT(*) AS order_count
FROM orders
GROUP BY customer_id) AS sub
WHERE order_count >=2;

CREATE VIEW customer_spendig AS
SELECT c.customer_name, SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

SELECT * FROM customer_spendig;

CREATE INDEX indx_orders_customer_id
ON orders (customer_id);

SELECT * from orders WHERE customer_id = 1;


























