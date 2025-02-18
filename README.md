# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database**: `Project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. 

## Objectives

1. **Set up a Retail Sales Table**: Create and populate a retail sales table in the database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Table Setup

- **Table Creation**: A table named `Retail_Sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE Retail_Sales
(
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

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) 
FROM Retail_Sales;

SELECT COUNT(DISTINCT customer_id) as total_sale;
FROM Retail_Sales

SELECT DISTINCT category
FROM Retail_Sales;

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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT * 
FROM Retail_Sales
WHERE sale_date='2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022**:
```sql
SELECT * 
FROM Retail_Sales
WHERE category='Clothing' AND TO_CHAR(sale_date,'YYYY-MM')='2022-11' AND quantity >3;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category,
	   SUM(total_sale)
FROM Retail_Sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT AVG(age)
FROM Retail_Sales
WHERE category= 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM Retail_Sales
WHERE total_sale>1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category,
	   gender,
	   COUNT(transactions_id)
FROM Retail_Sales
GROUP BY gender, 
		 category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id,
	   SUM(total_sale) 
FROM Retail_Sales
GROUP BY customer_id
ORDER BY SUM(total_sale) DESC
LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT category,
	   COUNT(DISTINCT customer_id )
FROM Retail_Sales
GROUP BY category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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

```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing, Electronics and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A comprehensive summary of total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales patterns across different time periods and shifts.
- **Customer Insights**: Reports highlighting top customers and unique customer counts by category.
## Conclusion

This project provides a solid foundation in SQL for data analysts, focusing on database setup, data cleaning, exploratory data analysis, and crafting business-centric SQL queries. The insights gained from this project support data-driven decision-making by uncovering sales trends, customer insights, and product performance metrics.



