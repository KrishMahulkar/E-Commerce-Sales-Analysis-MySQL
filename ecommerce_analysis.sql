-- Ecommerce Sales Analysis 

CREATE DATABASE ecommerce_project;
USE ecommerce_project;
CREATE TABLE ecommerce_sales (
    transaction_id INT,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(100),
    quantity INT,
    price_per_unit DECIMAL(10,2),
    cogs DECIMAL(10,2),
    total_sales DECIMAL(12,2)
);

SELECT COUNT(*) FROM ecommerce_sales;
SELECT * FROM ecommerce_sales LIMIT 5;

-- Total rows
SELECT COUNT(*) FROM ecommerce_sales;

-- Check sample data
SELECT * FROM ecommerce_sales LIMIT 5;

-- Data Cleaning
SELECT * FROM ecommerce_sales
WHERE transaction_id IS NULL

SELECT * FROM ecommerce_sales
WHERE sale_date IS NULL

SELECT * FROM ecommerce_sales
WHERE sale_time IS NULL

SELECT * FROM ecommerce_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sales IS NULL;
    
-- 
DELETE FROM ecommerce_sales
WHERE 
    transaction_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantity IS NULL
    OR
    cogs IS NULL
    OR
    total_sales IS NULL;

-- DATA EXPLORATION

-- How many sales we have?

SELECT COUNT(*) as total_sales FROM ecommerce_sales;

-- Answering business questions 
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM ecommerce_sales WHERE sale_date = '2022-11-05';


-- Q.2 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM ecommerce_sales where total_sales > 1000;


-- Q.3 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT avg(age) as avg_customer_age FROM ecommerce_sales WHERE category = 'Beauty';


-- Q.4 Write a SQL query to find Total Revenue, Cost & Profit.
SELECT sum(total_sales)	as total_revenue,
	   sum(cogs) as total_cost,
       sum(total_sales - cogs) as total_profit
       FROM ecommerce_sales;
       

-- Q.5 Write a SQL query to find Revenue by Product Category.
SELECT category, sum(total_sales) as category_revenue
FROM ecommerce_sales 
group by category
order by category_revenue desc;


-- Q.6 Write a SQL query to find top 10 customers by spending.
SELECT customer_id , sum(total_sales) as total_spent
FROM ecommerce_sales 
group by customer_id
order by total_spent desc 
limit 10;


-- Q.7 Write a SQL query to find Repeated Customers (Customer Loyalty).
select customer_id , count(transaction_id) as Total_orders
from ecommerce_sales
group by customer_id having Total_orders > 1
order by Total_orders desc;


-- Q.8 Write a SQL query for Customer Segmentation by Age Group.
select 
case when age < 25 then 'under 25'
     when age between 25 and 34 then '25-34'
     when age between 35 and 44 then '35-44'  
     when age between 45 and 54 then '45-54'
    else '55+'
    end as age_group, sum(total_sales) as revenue
    group by age_group
    order by revenue desc;
    
-- Q.9 Write a SQL query to find Gender-wise Revenue Contribution.
select gender , sum(total_sales) as revenue
from ecommerce_sales
group by gender
order by revenue desc;
 

-- Q.10 Write a SQL query to find Peak Sales Hours.
select hour(sale_time) as hour,
 sum(total_sales) as revenue
 from ecommerce_sales 
 group by hour
 order by revenue desc;







  