# Most Complex Database Code

## Restaurant Sales and Customer Analysis

This is a small MySQL database project I created to practice database design and SQL analysis.

The database contains customers, products, orders and order items. I used the data to perform different types of analysis such as customer spending, product sales and category-wise sales.

## Database

* MySQL 8.0+
* SQL

## Tables

The database has four main tables:

* `customers` - stores customer details
* `products` - stores product and category details
* `orders` - stores customer orders
* `order_items` - stores the products included in each order

The `order_items` table also stores the `unit_price` at the time of purchase. This means that if the product price changes later, the amount of an old order will not change.

## SQL Concepts Used

In this project I used:

* Primary keys
* Foreign keys
* `NOT NULL` and `CHECK` constraints
* Indexes
* `INNER JOIN`
* `LEFT JOIN`
* `GROUP BY`
* Aggregate functions such as `SUM()` and `AVG()`
* `HAVING`
* Subqueries
* Common Table Expressions (CTEs)
* `RANK()`
* `ROW_NUMBER()`
* `LAG()`
* Window functions
* Running totals
* Views
* `EXPLAIN`

## Analysis Performed

The queries in `database.sql` are used to:

1. Display customers and their orders.
2. Calculate the total amount for each order.
3. Calculate the total spending of each customer.
4. Find the products with the highest sales.
5. Calculate sales for each product category.
6. Find customers whose spending is above the average.
7. Rank customers based on their spending.
8. Calculate a running total of sales by date.
9. Find the top product in each category.
10. Compare customer spending using `LAG()`.
11. Create a view for customer spending.
12. Check a query execution plan using `EXPLAIN`.

## Database Design

I used `LEFT JOIN` in some queries so that customers who do not have any orders can also be included in the results.

I also added indexes to columns that are commonly used for joins and filtering, such as customer IDs, order IDs and product IDs.

## How to Run

1. Open MySQL Workbench.
2. Open `database.sql`.
3. Make sure MySQL 8.0 or above is being used.
4. Run the complete SQL file.
5. The database and tables will be created automatically.
6. The analysis queries will then display their results.

## What I Learned

While working on this database, I got more practice with SQL joins, grouping and aggregate functions. I also learned how CTEs and window functions can be used for more advanced analysis.

I also understood the importance of storing the price paid for an item in the order itself instead of depending only on the current product price.
