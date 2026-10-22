-- Task 19: 15 queries using SELECT, WHERE, DISTINCT, ORDER BY and TOP (SQL Server, database INTERNSHIP)
-- Run Task 18 script first. Select one query and press F5 to run it.

USE INTERNSHIP;
GO

-- Q1. View the first 5 customers (SELECT, TOP)
SELECT TOP 5 * FROM customers;

-- Q2. List all products from the most to the least expensive (SELECT columns, ORDER BY)
SELECT product_name, category, unit_price
FROM products
ORDER BY unit_price DESC;

-- Q3. Find all customers in the West region (WHERE)
SELECT customer_id, customer_name, city
FROM customers
WHERE region = 'West'
ORDER BY customer_name;

-- Q4. List each city where customers live, without repeats (DISTINCT)
SELECT DISTINCT city
FROM customers
ORDER BY city;

-- Q5. List the product categories we sell (DISTINCT)
SELECT DISTINCT category
FROM products
ORDER BY category;

-- Q6. Find expensive electronics: price above 5,000 (WHERE with AND)
SELECT product_name, unit_price
FROM products
WHERE category = 'Electronics' AND unit_price > 5000
ORDER BY unit_price DESC;

-- Q7. Show all orders placed in the festive quarter, Oct to Dec 2025 (WHERE BETWEEN)
SELECT order_id, customer_id, order_date, payment_method
FROM orders
WHERE order_date BETWEEN '2025-10-01' AND '2025-12-31'
ORDER BY order_date;

-- Q8. Find orders paid by UPI or Credit Card (WHERE IN, TOP)
SELECT TOP 20 order_id, order_date, payment_method
FROM orders
WHERE payment_method IN ('UPI', 'Credit Card')
ORDER BY order_date, order_id;

-- Q9. Find customers whose last name is Patel (WHERE LIKE)
SELECT customer_id, customer_name, city
FROM customers
WHERE customer_name LIKE '% Patel'
ORDER BY customer_name;

-- Q10. Top 10 biggest sales lines by sales amount (ORDER BY DESC, TOP)
SELECT TOP 10 sale_id, order_id, product_id, quantity, sales_amount
FROM sales
ORDER BY sales_amount DESC, sale_id;

-- Q11. The 5 worst loss-making sales lines (WHERE, ORDER BY, TOP)
SELECT TOP 5 sale_id, product_id, quantity, discount_pct, sales_amount, profit
FROM sales
WHERE profit < 0
ORDER BY profit ASC, sale_id;

-- Q12. Which payment methods do customers use? (DISTINCT)
SELECT DISTINCT payment_method
FROM orders
ORDER BY payment_method;

-- Q13. Large discounted purchases: discount of 10% or more and quantity of 3 or more (WHERE with AND)
SELECT TOP 10 sale_id, product_id, quantity, discount_pct, sales_amount
FROM sales
WHERE discount_pct >= 10 AND quantity >= 3
ORDER BY sales_amount DESC, sale_id;

-- Q14. Top 5 products by profit margin % (calculated column, ORDER BY, TOP)
SELECT TOP 5 product_name, category,
       ROUND((unit_price - unit_cost) / unit_price * 100, 1) AS margin_pct
FROM products
ORDER BY margin_pct DESC;

-- Q15. The 5 most recent orders that are still shipped, not delivered (WHERE, ORDER BY, TOP)
SELECT TOP 5 order_id, customer_id, order_date, order_status
FROM orders
WHERE order_status = 'Shipped'
ORDER BY order_date DESC, order_id DESC;