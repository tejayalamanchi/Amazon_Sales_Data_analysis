-- Amazon Sales Analysis Projects 

-- Create the table so we can import the data

CREATE TABLE sales(
					id int PRIMARY KEY,
					order_date date,
					customer_name VARCHAR(25),
					state VARCHAR(25),
					category VARCHAR(25),
					sub_category VARCHAR(25),
					product_name VARCHAR(255),
					sales FLOAT,
					quantity INT,
					profit FLOAT
					);

-- Importing the data into the table 

-- -------------------------------------------------------------------------------------
-- Exploratory Data Analysis and Pre Processing
-- -------------------------------------------------------------------------------------


--  Checking total rows count

SELECT * FROM sales;

SELECT COUNT(*)
FROM sales;

-- Checking if there any missing values

SELECT COUNT(*)
FROM sales
WHERE id IS NULL 
   OR order_date IS NULL 
   OR customer_name IS NULL 
   OR state IS NULL 
   OR category IS NULL 
   OR sub_category IS NULL 
   OR product_name IS NULL 
   OR sales IS NULL 
   OR quantity IS NULL 
   OR profit IS NULL;

--  Checking for duplicate entry


SELECT * FROM 
	(SELECT
	*,
	ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) as rn
FROM sales ) x
WHERE rn > 1;


-- -------------------------------------------------------------------------------------
-- Feature Engineering 
-- -------------------------------------------------------------------------------------


--  creating a year column
ALTER TABLE sales
ADD COLUMN YEAR VARCHAR(4);
-- adding year value into the year column
UPDATE sales
SET year = EXTRACT(YEAR FROM order_date);

-- creating a new column for the month 
ALTER TABLE sales
ADD COLUMN MONTH VARCHAR(15);

-- adding abbreviated month name  
UPDATE sales
SET month = TO_CHAR(order_date, 'mon');

-- adding new column as day_name
ALTER TABLE sales
ADD COLUMN day_name VARCHAR(15);

-- updating day name into the day column
UPDATE sales 
SET day_name = TO_CHAR(order_date, 'day');

SELECT TO_CHAR(order_date, 'day')
FROM sales;



-- -------------------------------------------------------------------------------------
-- Solving Business Problems 
-- -------------------------------------------------------------------------------------

-- Q.1 Find total sales for each category ?

SELECT 
	category,
	SUM(sales) as total_sales
FROM sales
GROUP BY 1
ORDER BY 2 DESC;


-- Q.2 Find out top 5 customers who made the highest profits?
SELECT 
	customer_name,
	SUM(profit) as total_profit
FROM sales
GROUP BY 1
ORDER BY 2 DESC 
LIMIT 5;

-- Q.3 Find out average qty ordered per category 
SELECT
	category,
	AVG(quantity) as avg_qty_ordered
FROM sales
GROUP BY 1
ORDER BY 2 DESC;


-- Q.4 Top 5 products that has generated highest revenue 

SELECT 
    product_name,
    ROUND(SUM(sales)::numeric, 2) as revenue
FROM 
    sales
GROUP BY 
    1
ORDER BY 
    2 DESC
LIMIT 5;
