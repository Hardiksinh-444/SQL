-- Task 22: 10 analytical queries using CASE WHEN, HAVING and Subqueries (SQL Server, database INTERNSHIP)
-- Load the full data first (internship_task18_sqlserver.sql). Select one query and press F5 to run it.

USE INTERNSHIP;
GO

-- Q1. Label every sales line as Small, Medium or Large by its amount (CASE WHEN)
SELECT TOP 10 sale_id, sales_amount,
       CASE
           WHEN sales_amount < 5000  THEN 'Small'
           WHEN sales_amount < 20000 THEN 'Medium'
           ELSE 'Large'
       END AS sale_size
FROM sales
ORDER BY sale_id;

-- Q2. How many sales lines and how much money in each size group? (CASE WHEN + subquery in FROM)
SELECT sale_size, COUNT(*) AS sales_lines, SUM(sales_amount) AS total_sales
FROM (
    SELECT sales_amount,
           CASE
               WHEN sales_amount < 5000  THEN 'Small'
               WHEN sales_amount < 20000 THEN 'Medium'
               ELSE 'Large'
           END AS sale_size
    FROM sales
) AS t
GROUP BY sale_size
ORDER BY total_sales DESC;

-- Q3. How many sales lines made a profit and how many made a loss, and the total loss? (CASE inside SUM)
SELECT SUM(CASE WHEN profit >= 0 THEN 1 ELSE 0 END)      AS profitable_lines,
       SUM(CASE WHEN profit < 0  THEN 1 ELSE 0 END)      AS loss_lines,
       SUM(CASE WHEN profit < 0  THEN profit ELSE 0 END) AS total_loss
FROM sales;

-- Q4. Group customers into High, Medium and Low value by total spending (CASE WHEN + subquery in FROM)
SELECT customer_group, COUNT(*) AS total_customers
FROM (
    SELECT o.customer_id,
           CASE
               WHEN SUM(s.sales_amount) >= 150000 THEN 'High Value'
               WHEN SUM(s.sales_amount) >= 50000  THEN 'Medium Value'
               ELSE 'Low Value'
           END AS customer_group
    FROM orders o
    JOIN sales s ON o.order_id = s.order_id
    GROUP BY o.customer_id
) AS t
GROUP BY customer_group
ORDER BY total_customers;

-- Q5. Which categories have total sales above 5,00,000? (HAVING)
SELECT p.category, SUM(s.sales_amount) AS total_sales
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
HAVING SUM(s.sales_amount) > 500000
ORDER BY total_sales DESC;

-- Q6. Which customers placed 5 or more orders? (HAVING with COUNT)
SELECT customer_id, COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) >= 5
ORDER BY total_orders DESC, customer_id;

-- Q7. Which products sold more than 50 units in total? (HAVING with SUM)
SELECT p.product_name, SUM(s.quantity) AS units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
HAVING SUM(s.quantity) > 50
ORDER BY units_sold DESC, p.product_name;

-- Q8. Which sales lines are bigger than the average sales line? (subquery in WHERE)
SELECT TOP 10 sale_id, order_id, sales_amount
FROM sales
WHERE sales_amount > (SELECT AVG(sales_amount) FROM sales)
ORDER BY sales_amount DESC, sale_id;

-- Q9. Which customers have bought Electronics? (subquery with IN)
SELECT customer_id, customer_name, city
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
    JOIN sales s    ON o.order_id   = s.order_id
    JOIN products p ON s.product_id = p.product_id
    WHERE p.category = 'Electronics'
)
ORDER BY customer_name;

-- Q10. Which customers spend more than the average customer? (HAVING + subquery)
SELECT TOP 10 o.customer_id, SUM(s.sales_amount) AS total_spending
FROM orders o
JOIN sales s ON o.order_id = s.order_id
GROUP BY o.customer_id
HAVING SUM(s.sales_amount) > (
    SELECT AVG(customer_total)
    FROM (
        SELECT SUM(s2.sales_amount) AS customer_total
        FROM orders o2
        JOIN sales s2 ON o2.order_id = s2.order_id
        GROUP BY o2.customer_id
    ) AS x
)
ORDER BY total_spending DESC, o.customer_id;