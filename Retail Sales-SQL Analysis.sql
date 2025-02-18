-- CREATING TABLE

CREATE TABLE Retail_Sales(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),	
	quantity INT,
	price_per_unit	FLOAT,
	cogs	FLOAT,
	total_sale FLOAT
);

-- DATA EXPLORATION

SELECT * 
FROM Retail_Sales;

SELECT COUNT(*) 
FROM Retail_Sales;

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM Retail_Sales

-- How many categories we have?

SELECT DISTINCT category FROM Retail_Sales

-- Is there any null values?

SELECT * FROM Retail_Sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date	IS NULL
	OR
	sale_time	IS NULL
	OR
	customer_id	IS NULL
	OR
	gender	IS NULL
	OR
	age	IS NULL
	OR
	category	IS NULL
	OR
	quantity	IS NULL
	OR
	price_per_unit	IS NULL
	OR
	cogs	IS NULL
	OR
	total_sale IS NULL
;

--DATA CLEANING

DELETE FROM Retail_Sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date	IS NULL
	OR
	sale_time	IS NULL
	OR
	customer_id	IS NULL
	OR
	gender	IS NULL
	OR
	age	IS NULL
	OR
	category	IS NULL
	OR
	quantity	IS NULL
	OR
	price_per_unit	IS NULL
	OR
	cogs	IS NULL
	OR
	total_sale IS NULL
;

-- DATA ANALYSIS

-- Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT * 
FROM Retail_Sales
WHERE sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022

SELECT * 
FROM Retail_Sales
WHERE category='Clothing' AND TO_CHAR(sale_date,'YYYY-MM')='2022-11' AND quantity >3;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category,
	   SUM(total_sale)
FROM Retail_Sales
GROUP BY category;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age)
FROM Retail_Sales
WHERE category= 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM Retail_Sales
WHERE total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,
	   gender,
	   COUNT(transactions_id)
FROM Retail_Sales
GROUP BY gender, 
		 category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT year,
	   month , 
       average_sale
FROM
(SELECT EXTRACT(YEAR FROM sale_date) AS year,
	   EXTRACT(MONTH FROM sale_date) AS month,
	   AVG(total_sale) AS average_sale,
	   RANK()OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM Retail_Sales
GROUP BY year, month
) AS t1
WHERE rank= 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT customer_id,
	   SUM(total_sale) 
FROM Retail_Sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category,
	   COUNT(DISTINCT customer_id )
FROM Retail_Sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sales AS
(SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time)<12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM Retail_Sales) 

SELECT shift,
	   COUNT(*)
FROM hourly_sales
GROUP BY shift;

