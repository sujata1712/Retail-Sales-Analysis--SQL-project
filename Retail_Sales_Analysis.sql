-- SQL PROJECT ON RETAIL SALES ANALYSIS

-- create database
CREATE DATABASE retail_sales_analysis;
USE retail_sales_analysis;

-- create table
-- here we use not null constraints to clean the data
CREATE TABLE sales(
	transactions_id int NOT NULL ,
	sale_date date NOT NULL,
	sale_time time NOT NULL,
	customer_id int NOT NULL,
	gender varchar(15) NOT NULL,
	age	int NOT NULL,
    category varchar(50) NOT NULL,
	quantity int NOT NULL,
	price_per_unit float NOT NULL,
	cogs float NOT NULL,
	total_sale float NOT NULL
);
-- import data into table from csv file
-- show the table
SELECT * FROM sales;
-- show first 10 rows from table
SELECT * FROM sales LIMIT 10;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -------------------------------------------------------------DATA EXPLORATION-----------------------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- total data count
SELECT COUNT(*) FROM sales;

-- how many sales we have?
SELECT COUNT(*) AS total_sales FROM sales ;

-- how many unique customers we have?
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM sales ;

-- how many categories we have?
SELECT COUNT(DISTINCT category) AS total_category FROM sales ;
SELECT DISTINCT category AS category_name FROM sales ;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------DATA ANALYSIS & BUSINESS KEY PROBLEMS----------------------------------------------------------------------
-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT * FROM sales WHERE sale_date='2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022.

SELECT * FROM sales WHERE category='Clothing'
						AND quantity>3
                        AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
                        -- EXTRACT(YEAR FROM sale_date) = 2022 AND EXTRACT(MONTH FROM sale_date) = 11;

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT category, SUM(total_sale) AS TotalSale FROM sales GROUP BY category;


-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) AS avg_age FROM sales WHERE category='Beauty';


-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM sales WHERE total_sale>1000;


-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender,COUNT(*) AS total_transaction_id
FROM sales
GROUP BY category,gender;


-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.

SELECT AVG_SALE, years, months
FROM (
    SELECT AVG(total_sale) AS AVG_SALE,
           EXTRACT(YEAR FROM sale_date) AS years,
           EXTRACT(MONTH FROM sale_date) AS months,
           RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS ranks
    FROM sales
    GROUP BY EXTRACT(YEAR FROM sale_date), EXTRACT(MONTH FROM sale_date)
) AS t1
WHERE ranks = 1;


-- 8. Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT customer_id, SUM(total_sale) AS Total_Sale 
FROM sales
GROUP BY customer_id
ORDER BY Total_Sale DESC
LIMIT 5;


-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.
 
 SELECT COUNT(DISTINCT customer_id) AS total_unique_customer,category 
 FROM sales
 GROUP BY category;


-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17).

SELECT 
	CASE 
		WHEN sale_time <'12:00:00' THEN 'Morning'
        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
	END AS shift,
    COUNT(*) AS no_of_orders
FROM sales
GROUP BY shift;
    

-- 11. Write a SQL query to find number of sales made in each time of the day per weekday.alter

SELECT 
	CASE 
		WHEN sale_time <'12:00:00' THEN 'Morning'
        WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'Afternoon'
        ELSE 'Evening'
	END AS time_of_day,
    DAYNAME(sale_date) AS weekday,
    COUNT(*) AS no_of_sales
FROM sales
GROUP BY time_of_day, weekday
ORDER BY FIELD(weekday, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'), time_of_day;

-- 12. Write a SQL query to find month with the largest cogs.

SELECT EXTRACT(YEAR FROM sale_date) AS YEAR,
		EXTRACT(MONTH FROM sale_date) AS MONTH,
        SUM(cogs) AS total_cogs
   FROM sales
   GROUP BY YEAR,month
   ORDER BY total_cogs DESC
   LIMIT 1;