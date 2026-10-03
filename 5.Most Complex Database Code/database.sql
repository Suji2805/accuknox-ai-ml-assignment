CREATE DATABASE IF NOT EXISTS restaurant_analysis;

USE restaurant_analysis;

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    CONSTRAINT fk_orders_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    CONSTRAINT fk_items_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    CONSTRAINT fk_items_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE INDEX idx_orders_customer
ON orders(customer_id);

CREATE INDEX idx_orders_date
ON orders(order_date);

CREATE INDEX idx_order_items_order
ON order_items(order_id);

CREATE INDEX idx_order_items_product
ON order_items(product_id);

INSERT INTO customers
    (customer_id, customer_name, city)
VALUES
    (1, 'Arun', 'Chennai'),
    (2, 'Priya', 'Coimbatore'),
    (3, 'Karthik', 'Chennai'),
    (4, 'Divya', 'Madurai'),
    (5, 'Meena', 'Salem'),
    (6, 'Rahul', 'Chennai');

INSERT INTO products
    (product_id, product_name, category, price)
VALUES
    (101, 'Chicken Rice', 'Main Course', 180.00),
    (102, 'Veg Fried Rice', 'Main Course', 140.00),
    (103, 'Paneer Pizza', 'Pizza', 250.00),
    (104, 'Fresh Lime Juice', 'Drinks', 80.00),
    (105, 'Ice Cream', 'Dessert', 100.00),
    (106, 'Veg Burger', 'Fast Food', 160.00);

INSERT INTO orders
    (order_id, customer_id, order_date)
VALUES
    (1001, 1, '2026-09-01'),
    (1002, 2, '2026-09-02'),
    (1003, 1, '2026-09-03'),
    (1004, 3, '2026-09-04'),
    (1005, 4, '2026-09-05'),
    (1006, 2, '2026-09-10'),
    (1007, 3, '2026-09-15');

INSERT INTO order_items
    (order_item_id, order_id, product_id, quantity, unit_price)
VALUES
    (1, 1001, 101, 2, 180.00),
    (2, 1001, 104, 2, 80.00),
    (3, 1002, 103, 1, 250.00),
    (4, 1002, 105, 2, 100.00),
    (5, 1003, 102, 2, 140.00),
    (6, 1003, 104, 1, 80.00),
    (7, 1004, 101, 1, 180.00),
    (8, 1004, 103, 1, 250.00),
    (9, 1005, 105, 3, 100.00),
    (10, 1005, 104, 2, 80.00),
    (11, 1006, 106, 2, 160.00),
    (12, 1006, 104, 1, 80.00),
    (13, 1007, 101, 1, 180.00),
    (14, 1007, 105, 1, 100.00);

SELECT
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id;

SELECT
    o.order_id,
    o.order_date,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id, o.order_date
ORDER BY o.order_id;

SELECT
    c.customer_id,
    c.customer_name,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS category_sales
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY category_sales DESC;

WITH customer_spending AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent
FROM customer_spending
WHERE total_spent >
(
    SELECT AVG(total_spent)
    FROM customer_spending
)
ORDER BY total_spent DESC;

WITH customer_spending AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spent
FROM customer_spending
ORDER BY total_spent DESC;

WITH customer_spending AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_spending;

WITH daily_sales AS
(
    SELECT
        o.order_date,
        SUM(oi.quantity * oi.unit_price) AS daily_total
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY o.order_date
)
SELECT
    order_date,
    daily_total,
    SUM(daily_total) OVER (
        ORDER BY order_date
    ) AS running_total
FROM daily_sales
ORDER BY order_date;

WITH product_sales AS
(
    SELECT
        p.category,
        p.product_name,
        SUM(oi.quantity * oi.unit_price) AS total_sales
    FROM products p
    JOIN order_items oi
        ON p.product_id = oi.product_id
    GROUP BY p.category, p.product_id, p.product_name
),
ranked_products AS
(
    SELECT
        category,
        product_name,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    category,
    product_name,
    total_sales
FROM ranked_products
WHERE product_rank = 1
ORDER BY category;

WITH customer_spending AS
(
    SELECT
        c.customer_id,
        c.customer_name,
        COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spent
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent,
    LAG(total_spent) OVER (
        ORDER BY total_spent DESC
    ) AS previous_customer_spending
FROM customer_spending
ORDER BY total_spent DESC;

CREATE OR REPLACE VIEW customer_spending_view AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS total_spent
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LEFT JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;

SELECT *
FROM customer_spending_view
ORDER BY total_spent DESC;

EXPLAIN
SELECT
    o.order_id,
    SUM(oi.quantity * oi.unit_price) AS order_total
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id;
