-- SQL Retail Sales Analysis

CREATE DATABASE sql_project_2;

--Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
					transactions_id	INT PRIMARY KEY,
					sale_date	DATE,
					sale_time	TIME,
					customer_id	INT,
					gender	VARCHAR(15),
					age	INT,
					category	VARCHAR(15),
					quantiy	INT,
					price_per_unit	FLOAT,
					cogs FLOAT,	
					total_sale FLOAT
					);

SELECT * FROM retail_sales
LIMIT 10;

SELECT COUNT (*) FROM retail_sales LIMIT 10;

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

--
DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantiy IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
	
-- How many sales we have
SELECT COUNT(*) AS tota_sale FROM retail_sales

--How many customers we have
SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales

--Data Analysis & Business Key Problems & Answers

-- Q1. Write a SQL Query to retrieve all the columns for sales made on '22-11-05'
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05'; 

--Q2. Retrieve all the transactions where category is 'Clothing' and quanity sold is more than 10 in the month of Nov-2022
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantiy >= 4

--Q3. Write a SQL query to caculate the total sales (total_sales) each category
SELECT 
    category, 
COUNT(*) as num_sale,
SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales

--Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT AVG(age) 
FROM retail_sales
WHERE  category = 'Beauty'

--Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT *
FROM retail_sales
WHERE total_sale>1000

--Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT category, gender,
COUNT(category) as total_transactions
FROM retail_sales
GROUP BY category, gender
ORDER BY gender

--Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
EXTRACT (YEAR FROM sale_date) as year, 
EXTRACT (MONTH FROM sale_date) as month, 
AVG(total_sale) as total_sales
FROM retail_sales
GROUP BY 1,2
ORDER BY 1,3 DESC, 2

--Q8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id,
SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

--Q9. Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT category,
COUNT(DISTINCT customer_id) as unique_cs_id
FROM retail_sales
GROUP BY 1

--Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sale
AS (
SELECT *,
CASE 
	WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'morning' 
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'afternoon' 
	WHEN EXTRACT(HOUR FROM sale_time)>17 THEN 'evening'
	END AS shift
FROM retail_sales)
SELECT shift,
COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift
FROM retail_sales
GROUP BY 1,2,3
ORDER BY 4

--End of Project