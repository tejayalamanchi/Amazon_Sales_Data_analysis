

-- -------------------------------------------------------------------------------------
-- Solving Business Problems 
-- -------------------------------------------------------------------------------------

-- Q.1 Find total sales for each category ?

SELECT 
	category,
	SUM(sale) as total_sales
FROM sales
GROUP BY category
ORDER BY SUM(sale) DESC;


-- Q.2 Find out top 5 customers who made the highest profits?
SELECT 
	customer_name,
	SUM(profit) as total_profit
FROM sales
GROUP BY customer_name,
ORDER BY SUM(profit) DESC 
LIMIT 5;

-- Q.3 Find out average qty ordered per category 
SELECT
	category,
	AVG(quantity) as avg_qty_ordered
FROM sales
GROUP BY category
ORDER BY AVG(quantity) DESC;


-- Q.4 Top 5 products that has generated highest revenue 

SELECT 
    product_name,
    ROUND(SUM(sales)::numeric, 2) as revenue
FROM 
    sales
GROUP BY product_name
ORDER BY ROUND(SUM(sales)::numeric, 2) DESC
LIMIT 5;

--Q.5 Find all customer names, Total orders and their revenue?

SELECT 
	orders.customer_id,
	customers.customer_name,
	COUNT(orders.order_id) as total_orders,
	SUM(orders.sale) as total_revenue
FROM orders
INNER JOIN
customers
ON orders.customer_id = customers.customer_id
GROUP BY orders.customer_id,customers.customer_name;

--Q.6  FIND TOP 5 CUSTOMERS BASED ON TOTAL ORDERS(QUNTITY)  IN 2022
--INNER JOIN
SELECT 
	orders.customer_id,
	count(orders.order_id) as total_orders,
	customers.customer_name
from orders 
INNER JOIN 
customers ON
orders.customer_id=customers.customer_id
WHERE orders.order_date BETWEEN '2022-01-01' AND '2022-12-31'
group by orders.customer_id,customers.customer_name
order by count(orders.order_id) desc 
LIMIT 5

--Q.7 FIND TOTAL ORDERS PLACED BY CUSTOMERS IN 2ND MONTH OF 2022

SELECT 
	orders.customer_id,
	count(orders.order_id) as total_orders,
	customers.customer_name
from orders 
INNER JOIN 
customers ON
orders.customer_id=customers.customer_id
WHERE EXTRACT(MONTH FROM orders.order_date) ='2' AND EXTRACT(YEAR FROM orders.order_date) = '2022'
group by orders.customer_id,customers.customer_name
order by count(orders.order_id) desc 

--Q.8 FIND THE PRODUCT DETAILS WHO HAS DONE THE SALE GREATER THAN THE AVERAGE SALE?

--SUB QUERY

SELECT 
	product_id,
	SUM(sale) as total_sale
From orders
GROUP BY product_id
HAving SUM(sale) > (SELECT AVG(sale) from orders)






