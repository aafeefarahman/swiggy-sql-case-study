# 📊 Swiggy SQL Case Study

## 📌 Project Overview

This project explores a Swiggy-like food delivery dataset using SQL to answer business-oriented analytical questions. The goal of the project is to practice querying relational datasets, analyzing order patterns, and extracting insights related to restaurants, customers, delivery partners, and revenue.

This repository represents my **first SQL-based data analysis project**, created to strengthen foundational SQL skills and understand how structured datasets can be analyzed to answer real-world business questions.

---

## 📂 Project Structure

```
Swiggy
│
├── All-Datasets
│   ├── delivery_partner.csv
│   ├── food.csv
│   ├── menu.csv
│   ├── order_details.csv
│   ├── orders.csv
│   ├── restaurants.csv
│   └── users.csv
│
├── Swiggyproject.sql
└── executions.pdf
```

---

## 🗂 File Description

**All-Datasets/**
Contains all CSV files used to create the database tables.

**Swiggyproject.sql**
Contains all SQL queries used to perform the analysis.

**executions.pdf**
Contains screenshots of executed queries and their results.

---

## 🗄 Database Schema

The dataset consists of the following tables:

**Delivery_Partner**
Contains information about delivery personnel.

**Food**
Contains details about food items and food categories.

**Menu**
Contains pricing information for each food item offered by restaurants.

**Order_Details**
Stores details about each order and the food items included.

**Orders**
Contains order information including order value, delivery details, ratings, and timestamps.

**Restaurants**
Contains information about restaurants and their cuisines.

**Users**
Contains details about customers using the platform.

---

##  Case Study Analysis Questions ❔

The following analytical questions were explored in this project:

* Count of customers who have not placed any orders
* Average price of each food type
* Average price of food for each restaurant
* Top restaurant based on number of orders for each month
* Top restaurant based on number of orders in June
* Restaurants with monthly revenue greater than a given value
* Orders placed by a specific customer within a given date range
* Restaurant with the highest number of repeat customers
* Month-over-month revenue growth of the platform
* Top 3 most ordered dishes
* Month-over-month revenue growth of each restaurant
* Total revenue generated during a specific time period
* Average order value per user
* Relationship between delivery time and customer satisfaction
* Average ratings of restaurants and delivery partners
* Correlation between ratings and customer retention
* Days with the highest order volume
* Orders delivered by each delivery partner and their average delivery rating
* Distribution of delivery partners

---

##  SQL Techniques Used❕

This project demonstrates the use of several SQL techniques including:

* Joins
* Aggregation Functions
* Subqueries
* Common Table Expressions (CTE)
* Window Functions
* Ranking Functions
* Rolling Sum Calculations
* Date Manipulation
* Grouping and Sorting
* Correlation Analysis
* Descriptive Statistics

---

## 📝 Project Note

This project was developed as an **introductory SQL analysis project** to build a strong foundation in querying relational databases and performing analytical queries.

The main objective was to explore how SQL can be used to answer business questions related to:

* customer behavior
* restaurant performance
* order trends
* revenue insights
* delivery performance

---

## 🚀 Future Improvements

As a next step, I plan to expand my data analytics work by building a **separate end-to-end project** that will include:

* Data exploration using **Python (Pandas)**
* Data visualization
* Building an **interactive dashboard using Power BI**
* Working with larger real-world datasets for deeper insights

This repository focuses specifically on the **SQL analysis stage** of the data analytics workflow.
