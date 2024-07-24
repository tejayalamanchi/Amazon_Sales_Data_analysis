

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

--
