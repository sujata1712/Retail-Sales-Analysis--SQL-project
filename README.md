# Retail-Sales-Analysis--SQL-project

## Description
This project analyses the Retail Sales data using SQL to extract valuable business insights. The dataset contains transaction details, including product sales, revenue, and customer demographics. The projects focus on identifying sales trends, top-performing products, and revenue growth over time.

## Dataset
- **Source:** [Kaggle Sales Data](https://www.kaggle.com/kyanyoga/sample-sales-data)
- **Schema Overview:**
  - `orders` - Contains order details such as order ID, date, customer ID, and total amount.
  - `customers` - Includes customer information like customer ID, name, and location.
  - `products` - Holds product details including product ID, name, category, and price.
  - `order_details` - Links orders to products with quantity and price per unit.

## SQL Queries Performed
- Total Sales and Revenue Calculation
- Top Selling Products Analysis
- Monthly and Yearly Sales Trends
- Customer Purchase Behavior Insights
- Profitability Analysis

## Usage
1. **Load the dataset** into a database (MySQL/PostgreSQL/SQLite).
2. **Run the script**:
   ```sql
   source Retail_Sales_Analysis.sql;
   ```
3. **Analyze the results** using SQL queries.

## Technologies Used
- SQL (MySQL/PostgreSQL/SQLite)
- Data Analysis Queries
- Aggregate Functions, Joins, Subqueries, CTEs

## Results & Insights
- Identified best-selling products and categories.
- Analyzed revenue trends over different time periods.
- Determined customer segmentation based on purchasing behavior.




