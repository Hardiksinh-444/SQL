-- Task 21: Join the Customers, Orders and Products tables and solve 10 business questions
-- (SQL Server, database INTERNSHIP). Load the full data first (internship_task18_sqlserver.sql).
--
-- How the tables connect:  customers -> orders -> sales -> products
--   customers.customer_id = orders.customer_id
--   orders.order_id       = sales.order_id
--   sales.product_id      = products.product_id
-- (orders and products connect through the sales table.)
-- Select one query and press F5 to run it.

USE INTERNSHIP;
GO

-- Q1. Show who bought what: customer, order date, product and amount (4-table INNER JOIN)
SELECT TOP 20 c.customer_name, o.order_date, p.product_name, s.quantity, s.sales_amount
FROM customers c
JOIN orders o   ON c.customer_id = o.customer_id
JOIN sales s    ON o.order_id    = s.order_id
JOIN products p ON s.product_id  = p.product_id
ORDER BY o.order_date, o.order_id, s.sale_id;

-- Q2. Who are the top 10 customers by total spending?
SELECT TOP 10 c.customer_name, c.city, SUM(s.sales_amount) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN sales s  ON o.order_id    = s.order_id
GROUP BY c.customer_name, c.city
ORDER BY total_spending DESC, c.customer_name;

-- Q3. Which region earns the most sales and profit?
SELECT c.region,
       SUM(s.sales_amount) AS total_sales,
       SUM(s.profit)       AS total_profit
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN sales s  ON o.order_id    = s.order_id
GROUP BY c.region
ORDER BY total_sales DESC;

-- Q4. How much does each product category sell and earn?
SELECT p.category,
       SUM(s.sales_amount) AS total_sales,
       SUM(s.profit)       AS total_profit
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

-- Q5. Which are the 5 best-selling products by quantity?
SELECT TOP 5 p.product_name, p.category, SUM(s.quantity) AS units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name, p.category
ORDER BY units_sold DESC, p.product_name;

-- Q6. Which customers did NOT place any order in Oct to Dec 2025? (LEFT JOIN, IS NULL)
SELECT c.customer_id, c.customer_name, c.city
FROM customers c
LEFT JOIN orders o
       ON c.customer_id = o.customer_id
      AND o.order_date BETWEEN '2025-10-01' AND '2025-12-31'
WHERE o.order_id IS NULL
ORDER BY c.customer_name;

-- Q7. Which customers bought a Laptop? (JOIN with a filter, DISTINCT)
SELECT DISTINCT c.customer_name, c.city
FROM customers c
JOIN orders o   ON c.customer_id = o.customer_id
JOIN sales s    ON o.order_id    = s.order_id
JOIN products p ON s.product_id  = p.product_id
WHERE p.product_name = 'Laptop'
ORDER BY c.customer_name;

-- Q8. How much is sold with each payment method?
SELECT o.payment_method,
       COUNT(DISTINCT o.order_id) AS total_orders,
       SUM(s.sales_amount)        AS total_sales
FROM orders o
JOIN sales s ON o.order_id = s.order_id
GROUP BY o.payment_method
ORDER BY total_sales DESC;

-- Q9. What is the average order value in each region?
SELECT c.region,
       COUNT(DISTINCT o.order_id) AS total_orders,
       ROUND(SUM(s.sales_amount) / COUNT(DISTINCT o.order_id), 2) AS avg_order_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN sales s  ON o.order_id    = s.order_id
GROUP BY c.region
ORDER BY avg_order_value DESC;

-- Q10. Which category sells best in each region? (sales by region and category)
SELECT c.region, p.category, SUM(s.sales_amount) AS total_sales
FROM customers c
JOIN orders o   ON c.customer_id = o.customer_id
JOIN sales s    ON o.order_id    = s.order_id
JOIN products p ON s.product_id  = p.product_id
GROUP BY c.region, p.category
ORDER BY c.region, total_sales DESC;