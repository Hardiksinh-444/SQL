-- Task 20: 15 analytical queries using GROUP BY, SUM, COUNT, AVG, MIN and MAX (SQL Server, database INTERNSHIP)
-- Tip: load the full data (internship_task18_sqlserver.sql) for richer results.
-- Select one query and press F5 to run it.

USE INTERNSHIP;
GO

-- Q1. Overall business totals: total sales, total profit and number of sales lines (SUM, COUNT)
SELECT SUM(sales_amount) AS total_sales,
       SUM(profit)       AS total_profit,
       COUNT(*)          AS sales_lines
FROM sales;

-- Q2. Average, smallest and largest sales amount of a sales line (AVG, MIN, MAX)
SELECT ROUND(AVG(sales_amount), 2) AS avg_sale,
       MIN(sales_amount)           AS min_sale,
       MAX(sales_amount)           AS max_sale
FROM sales;

-- Q3. Number of customers in each region (GROUP BY, COUNT)
SELECT region, COUNT(*) AS total_customers
FROM customers
GROUP BY region
ORDER BY total_customers DESC;

-- Q4. Number of customers in each city, biggest city first (GROUP BY, COUNT)
SELECT city, COUNT(*) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC, city;

-- Q5. Products per category with average, lowest and highest price (GROUP BY, COUNT, AVG, MIN, MAX)
SELECT category,
       COUNT(*)                    AS total_products,
       ROUND(AVG(unit_price), 2)   AS avg_price,
       MIN(unit_price)             AS lowest_price,
       MAX(unit_price)             AS highest_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

-- Q6. Number of orders for each payment method (GROUP BY, COUNT)
SELECT payment_method, COUNT(*) AS total_orders
FROM orders
GROUP BY payment_method
ORDER BY total_orders DESC;

-- Q7. Number of orders for each order status (GROUP BY, COUNT)
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status;

-- Q8. Number of orders in each month (GROUP BY, COUNT)
SELECT MONTH(order_date) AS month_no, COUNT(*) AS total_orders
FROM orders
GROUP BY MONTH(order_date)
ORDER BY month_no;

-- Q9. Top 10 products by total sales, with quantity sold (GROUP BY, SUM, with a simple JOIN)
SELECT TOP 10 p.product_name,
       SUM(s.quantity)     AS total_quantity,
       SUM(s.sales_amount) AS total_sales
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sales DESC, p.product_name;

-- Q10. Total sales and profit for each discount level (GROUP BY, SUM, COUNT)
SELECT discount_pct,
       COUNT(*)            AS sales_lines,
       SUM(sales_amount)   AS total_sales,
       SUM(profit)         AS total_profit
FROM sales
GROUP BY discount_pct
ORDER BY discount_pct;

-- Q11. Top 10 orders by total order value (GROUP BY, SUM)
SELECT TOP 10 order_id, SUM(sales_amount) AS order_value
FROM sales
GROUP BY order_id
ORDER BY order_value DESC, order_id;

-- Q12. Average, smallest and largest quantity per sales line for the first 10 products (GROUP BY, AVG, MIN, MAX)
SELECT TOP 10 product_id,
       ROUND(AVG(CAST(quantity AS DECIMAL(10,2))), 2) AS avg_quantity,
       MIN(quantity) AS min_quantity,
       MAX(quantity) AS max_quantity
FROM sales
GROUP BY product_id
ORDER BY product_id;

-- Q13. Sales, profit and profit margin % for each category (GROUP BY, SUM, with a simple JOIN)
SELECT p.category,
       SUM(s.sales_amount) AS total_sales,
       SUM(s.profit)       AS total_profit,
       ROUND(SUM(s.profit) * 100.0 / SUM(s.sales_amount), 1) AS margin_pct
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit DESC;

-- Q14. Top 10 customers by number of orders (GROUP BY, COUNT)
SELECT TOP 10 customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC, customer_id;

-- Q15. Date of the first and last order, and the total number of orders (MIN, MAX, COUNT)
SELECT MIN(order_date) AS first_order,
       MAX(order_date) AS last_order,
       COUNT(*)        AS total_orders
FROM orders;