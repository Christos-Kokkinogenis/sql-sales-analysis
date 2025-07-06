DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    signup_date DATE
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price NUMERIC(10,2)
);


CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    order_date DATE
);

INSERT INTO customers (name, email, signup_date) VALUES
('Alice Johnson', 'alice@example.com', '2022-01-15'),
('Bob Smith', 'bob@example.com', '2022-03-22'),
('Carol Lee', 'carol@example.com', '2022-05-05'),
('David Kim', 'david@example.com', '2022-07-19'),
('Eva Brown', 'eva@example.com', '2022-09-12');

INSERT INTO products (product_name, category, price) VALUES
('Wireless Mouse', 'Electronics', 25.99),
('Bluetooth Speaker', 'Electronics', 45.50),
('Coffee Maker', 'Home Appliances', 89.00),
('Yoga Mat', 'Fitness', 20.00),
('Standing Desk', 'Furniture', 199.99);

INSERT INTO orders (customer_id, product_id, quantity, order_date) VALUES
(1, 1, 2, '2022-02-01'),
(1, 3, 1, '2022-02-15'),
(2, 2, 1, '2022-04-10'),
(3, 5, 1, '2022-05-20'),
(4, 4, 2, '2022-08-01'),
(5, 3, 1, '2022-09-25'),
(2, 1, 1, '2022-04-18'),
(3, 2, 1, '2022-06-15');

SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

SELECT product_id, SUM(quantity) AS total_quantity
FROM orders
GROUP BY product_id;

SELECT orders.order_id, customers.name, products.product_name, orders.quantity, orders.order_date
FROM orders
JOIN customers ON orders.customer_id = customers.customer_id
JOIN products ON orders.product_id = products.product_id;

SELECT c.name, SUM(p.price * o.quantity) AS total_spent
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON o.product_id = p.product_id
GROUP BY c.name;

SELECT p.category, COUNT(*) AS orders_count
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category;

SELECT DISTINCT c.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.quantity > 1;

SELECT name, signup_date FROM customers ORDER BY signup_date;

SELECT product_name, price FROM products ORDER BY price DESC;

SELECT c.name, o.order_date, o.quantity
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date;

SELECT p.category, AVG(p.price) AS avg_price
FROM products p
GROUP BY p.category;


