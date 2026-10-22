USE INTERNSHIP;
GO

-- 1. Create tables (parent tables first)
CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    customer_name VARCHAR(60) NOT NULL,
    email         VARCHAR(80) NOT NULL,
    phone         VARCHAR(15),
    city          VARCHAR(40) NOT NULL,
    region        VARCHAR(20) NOT NULL,
    signup_date   DATE        NOT NULL
);

CREATE TABLE products (
    product_id   INT PRIMARY KEY,
    product_name VARCHAR(60)   NOT NULL,
    category     VARCHAR(30)   NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    unit_cost    DECIMAL(10,2) NOT NULL
);

CREATE TABLE orders (
    order_id       INT PRIMARY KEY,
    customer_id    INT         NOT NULL REFERENCES customers (customer_id),
    order_date     DATE        NOT NULL,
    payment_method VARCHAR(20) NOT NULL,
    order_status   VARCHAR(20) NOT NULL
);

CREATE TABLE sales (
    sale_id      INT PRIMARY KEY,
    order_id     INT           NOT NULL REFERENCES orders (order_id),
    product_id   INT           NOT NULL REFERENCES products (product_id),
    quantity     INT           NOT NULL,
    unit_price   DECIMAL(10,2) NOT NULL,
    discount_pct DECIMAL(5,2)  NOT NULL,
    sales_amount DECIMAL(12,2) NOT NULL,
    profit       DECIMAL(12,2) NOT NULL
);
GO

-- 2. Insert data
INSERT INTO customers (customer_id, customer_name, email, phone, city, region, signup_date) VALUES
(1001, 'Raj Zala', 'raj.zala@example.com', 8948147982, 'Rajkot', 'West', '2024-05-22'),
(1002, 'Hardik Trivedi', 'hardik.trivedi@example.com', 7626879139, 'Vadodara', 'West', '2023-09-23'),
(1003, 'Nidhi Shah', 'nidhi.shah@example.com', 7871727271, 'Patna', 'East', '2023-09-13'),
(1004, 'Neha Mehta', 'neha.mehta@example.com', 8369880217, 'Surat', 'West', '2024-02-14'),
(1005, 'Harsh Jadeja', 'harsh.jadeja@example.com', 8246525594, 'Surat', 'West', '2023-05-10'),
(1006, 'Parth Jadeja', 'parth.jadeja@example.com', 7096229608, 'Nagpur', 'Central', '2024-07-23'),
(1007, 'Meet Mehta', 'meet.mehta@example.com', 7109466798, 'Bhubaneswar', 'East', '2024-04-28'),
(1008, 'Ketan Joshi', 'ketan.joshi@example.com', 9322547015, 'Patna', 'East', '2024-07-07'),
(1009, 'Pooja Jadeja', 'pooja.jadeja@example.com', 7234129324, 'Vadodara', 'West', '2023-04-19'),
(1010, 'Hetal Patel', 'hetal.patel@example.com', 8519452668, 'Hyderabad', 'South', '2024-02-24');

INSERT INTO products (product_id, product_name, category, unit_price, unit_cost) VALUES
(101, 'Laptop', 'Electronics', 52000, 47840),
(102, 'Smartphone', 'Electronics', 24000, 20400),
(103, 'Tablet', 'Electronics', 18000, 14760),
(104, 'Headphones', 'Electronics', 2800, 1624),
(105, 'Smart Watch', 'Electronics', 6500, 4290),
(106, 'Office Chair', 'Furniture', 7500, 5025),
(107, 'Study Table', 'Furniture', 9500, 6460),
(108, 'Sofa Set', 'Furniture', 32000, 21280),
(109, 'Men''s Shirt', 'Clothing', 1200, 540),
(110, 'Women''s Kurti', 'Clothing', 1500, 615),
(111, 'Jeans', 'Clothing', 1800, 882),
(112, 'Saree', 'Clothing', 4200, 1869),
(113, 'Rice Bag 10kg', 'Grocery', 750, 705),
(114, 'Cooking Oil 5L', 'Grocery', 820, 746),
(115, 'Tea Powder 1kg', 'Grocery', 480, 336),
(116, 'Dry Fruits Pack', 'Grocery', 1100, 759),
(117, 'Notebook Pack', 'Stationery', 320, 176),
(118, 'Gel Pen Box', 'Stationery', 180, 90),
(119, 'Backpack', 'Accessories', 1600, 832),
(120, 'Wallet', 'Accessories', 900, 414),
(121, 'Wrist Watch', 'Accessories', 3800, 2128),
(122, 'Sunglasses', 'Accessories', 2200, 968);

INSERT INTO orders (order_id, customer_id, order_date, payment_method, order_status) VALUES
(5001, 1001, '2025-05-30', 'Debit Card', 'Delivered'),
(5002, 1002, '2025-02-26', 'Credit Card', 'Delivered'),
(5003, 1003, '2025-01-11', 'Debit Card', 'Delivered'),
(5004, 1004, '2025-12-20', 'Net Banking', 'Delivered'),
(5005, 1005, '2025-08-25', 'Credit Card', 'Shipped'),
(5006, 1006, '2025-10-17', 'Debit Card', 'Delivered'),
(5007, 1007, '2025-06-17', 'Credit Card', 'Delivered'),
(5008, 1008, '2025-06-06', 'Cash', 'Delivered'),
(5009, 1009, '2025-02-11', 'Net Banking', 'Delivered'),
(5010, 1010, '2025-07-23', 'Debit Card', 'Delivered'),
(5064, 1001, '2025-07-06', 'Credit Card', 'Delivered'),
(5066, 1003, '2025-12-01', 'Cash', 'Delivered'),
(5069, 1004, '2025-05-28', 'Credit Card', 'Delivered'),
(5078, 1007, '2025-09-18', 'Debit Card', 'Delivered'),
(5081, 1008, '2025-07-27', 'UPI', 'Delivered');

INSERT INTO sales (sale_id, order_id, product_id, quantity, unit_price, discount_pct, sales_amount, profit) VALUES
(9001, 5001, 106, 2, 7500.0, 15, 12750.0, 2700.0),
(9002, 5001, 110, 1, 1500.0, 0, 1500.0, 885.0),
(9003, 5002, 101, 1, 52000.0, 15, 44200.0, -3640.0),
(9004, 5002, 114, 7, 820.0, 5, 5453.0, 231.0),
(9005, 5003, 115, 2, 480.0, 10, 864.0, 192.0),
(9006, 5003, 104, 2, 2800.0, 5, 5320.0, 2072.0),
(9007, 5004, 107, 1, 9500.0, 15, 8075.0, 1615.0),
(9008, 5005, 110, 6, 1500.0, 0, 9000.0, 5310.0),
(9009, 5005, 120, 5, 900.0, 0, 4500.0, 2430.0),
(9010, 5006, 106, 2, 7500.0, 0, 15000.0, 4950.0),
(9011, 5007, 112, 3, 4200.0, 10, 11340.0, 5733.0),
(9012, 5007, 121, 2, 3800.0, 10, 6840.0, 2584.0),
(9013, 5008, 110, 6, 1500.0, 0, 9000.0, 5310.0),
(9014, 5009, 115, 7, 480.0, 0, 3360.0, 1008.0),
(9015, 5009, 106, 3, 7500.0, 5, 21375.0, 6300.0),
(9016, 5010, 104, 4, 2800.0, 0, 11200.0, 4704.0),
(9017, 5010, 113, 1, 750.0, 0, 750.0, 45.0),
(9100, 5064, 115, 4, 480.0, 0, 1920.0, 576.0),
(9102, 5066, 110, 6, 1500.0, 15, 7650.0, 3960.0),
(9103, 5066, 109, 5, 1200.0, 0, 6000.0, 3300.0),
(9104, 5066, 115, 5, 480.0, 0, 2400.0, 720.0),
(9107, 5069, 116, 2, 1100.0, 15, 1870.0, 352.0),
(9108, 5069, 102, 2, 24000.0, 15, 40800.0, 0.0),
(9122, 5078, 110, 5, 1500.0, 0, 7500.0, 4425.0),
(9123, 5078, 113, 1, 750.0, 15, 637.5, -67.5),
(9128, 5081, 113, 7, 750.0, 0, 5250.0, 315.0),
(9129, 5081, 102, 2, 24000.0, 0, 48000.0, 7200.0);

GO

-- 3. Check
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM sales;
