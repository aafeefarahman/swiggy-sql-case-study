USE swiggy;

-- 1. How many customers have not placed any orders?
select user_id from users
where user_id not in (
    select distinct user_id from orders
    where user_id is not null
);

-- 2. What is the average price of food for each restaurant?
SELECT 
    r.R_Name,
    ROUND(AVG(m.price),2) AS Avg_Price
FROM restaurants r
JOIN menu m
ON r.r_id = m.r_id
GROUP BY r.R_Name
ORDER BY r.R_Name;

-- 3. Find the top restaurant in terms of the number of orders for all months
WITH res_grouped AS (
    SELECT 
        MONTH(STR_TO_DATE(o.date,'%d-%m-%Y')) AS order_month,
        r.r_name,
        COUNT(*) AS order_count
    FROM orders o
    JOIN restaurants r
    ON o.r_id = r.r_id
    GROUP BY MONTH(STR_TO_DATE(o.date,'%d-%m-%Y')), r.r_name
),

res_ranked AS (
    SELECT *,
    RANK() OVER (
        PARTITION BY order_month
        ORDER BY order_count DESC
    ) AS res_rank
    FROM res_grouped
)

SELECT order_month, r_name
FROM res_ranked
WHERE res_rank = 1
ORDER BY order_month;


-- 4. Find the top restaurant in terms of the number of orders for the month of June
SELECT r.r_name, COUNT(*) AS total_orders
FROM restaurants r
JOIN orders o
ON r.r_id = o.r_id
WHERE MONTH(STR_TO_DATE(o.date,'%d-%m-%Y')) = 6
GROUP BY r.r_name
ORDER BY total_orders DESC
LIMIT 1;


-- 5. Restaurants with monthly revenue greater than 500
SELECT 
    MONTH(STR_TO_DATE(o.date,'%d-%m-%Y')) AS order_month,
    r.r_name,
    SUM(m.price) AS revenue
FROM restaurants r
JOIN orders o 
ON r.r_id = o.r_id
JOIN menu m 
ON r.r_id = m.r_id
GROUP BY MONTH(STR_TO_DATE(o.date,'%d-%m-%Y')), r.r_name
HAVING revenue >= 500
ORDER BY order_month;


-- 6. Show all orders with order details for a particular customer in a date range
SELECT *
FROM users u
JOIN orders o
ON u.user_id = o.user_id
WHERE u.user_id = 1
AND STR_TO_DATE(o.date,'%d-%m-%Y')
BETWEEN '2022-05-15' AND '2022-06-15';


-- 7. Which restaurant has the highest number of repeat customers?
WITH repeated_cust AS (
    SELECT 
        r.r_name,
        o.user_id,
        COUNT(*) AS order_count
    FROM restaurants r
    JOIN orders o
    ON r.r_id = o.r_id
    GROUP BY r.r_name, o.user_id
    HAVING COUNT(*) > 1
)

SELECT 
    r_name,
    COUNT(user_id) AS repeated_customers
FROM repeated_cust
GROUP BY r_name
ORDER BY repeated_customers DESC
LIMIT 1;


-- 8. Month over month revenue growth of Swiggy
WITH month_rev AS (
    SELECT 
        MONTH(STR_TO_DATE(o.date,'%d-%m-%Y')) AS order_month,
        SUM(m.price) AS monthly_rev
    FROM orders o
    JOIN menu m
    ON o.r_id = m.r_id
    GROUP BY MONTH(STR_TO_DATE(o.date,'%d-%m-%Y'))
)

SELECT 
order_month,
SUM(monthly_rev) OVER(
    ORDER BY order_month
) AS rolling_monthly_revenue
FROM month_rev;


-- 9. Find the top 3 most ordered dish
SELECT 
    f.f_name,
    COUNT(*) AS order_count
FROM order_details od
JOIN food f
ON f.f_id = od.f_id
GROUP BY f.f_name
ORDER BY order_count DESC
LIMIT 3;

-- 10. Overall revenue generated during a specific period
SELECT 
SUM(amount) AS total_revenue
FROM orders
WHERE STR_TO_DATE(date,'%d-%m-%Y')
BETWEEN '2022-05-01' AND '2022-06-01';

-- 11. What is the average order value per user?
SELECT 
user_id,
ROUND(AVG(amount),2) AS avg_order_value
FROM orders
GROUP BY user_id;


-- 12. Average delivery time and rating for each restaurant
SELECT 
r.r_name,
ROUND(AVG(o.delivery_time),2) AS avg_delivery_time,
ROUND(AVG(o.delivery_rating),2) AS avg_delivery_rating
FROM orders o
JOIN restaurants r
ON o.r_id = r.r_id
GROUP BY r.r_name;


-- 13. What is the average delivery time for each restaurant and how it affects customer satisfaction?
SELECT 
r.r_name,
ROUND(AVG(o.delivery_time),2) AS avg_delivery_time,
ROUND(AVG(o.delivery_rating),2) AS avg_delivery_rating
FROM orders o
JOIN restaurants r
ON o.r_id = r.r_id
GROUP BY r.r_name;

-- 13.b Average rating for each restaurant
SELECT 
r.r_name,
ROUND(AVG(o.restaurant_rating),2) AS avg_restaurant_rating
FROM orders o
JOIN restaurants r
ON o.r_id = r.r_id
GROUP BY r.r_name
ORDER BY avg_restaurant_rating DESC;

-- 14 Delivery Partner Ratings
SELECT 
dp.partner_name,
ROUND(AVG(o.delivery_rating),2) AS avg_delivery_rating
FROM orders o
JOIN delivery_partner dp
ON o.partner_id = dp.partner_id
GROUP BY dp.partner_name
ORDER BY avg_delivery_rating DESC;

-- 15. Correlation between restaurant rating and delivery rating
SELECT 
(
SUM((restaurant_rating - avg_r) * (delivery_rating - avg_d)) /
SQRT(
SUM(POW(restaurant_rating - avg_r,2)) *
SUM(POW(delivery_rating - avg_d,2))
)
) AS rating_correlation
FROM (
    SELECT 
        restaurant_rating,
        delivery_rating,
        (SELECT AVG(restaurant_rating) FROM orders) AS avg_r,
        (SELECT AVG(delivery_rating) FROM orders) AS avg_d
    FROM orders
) t;

-- 16. Which days and times see the highest order volume
SELECT 
DAYNAME(STR_TO_DATE(date,'%d-%m-%Y')) AS order_day,
HOUR(STR_TO_DATE(date,'%d-%m-%Y')) AS order_hour,
COUNT(order_id) AS order_count
FROM orders
GROUP BY order_day, order_hour
ORDER BY order_count DESC;

-- 17. How many orders were delivered by each delivery partner  and what is their average delivery rating?
SELECT 
DAYNAME(STR_TO_DATE(date,'%d-%m-%Y')) AS order_day,
COUNT(order_id) AS order_count
FROM orders
GROUP BY order_day
ORDER BY order_count DESC;

-- 18. What is the distribution of delivery partners in the Delivery_Partner table?
SELECT 
partner_name,
COUNT(*) AS partner_count
FROM delivery_partner
GROUP BY partner_name
ORDER BY partner_count DESC;

DESC orders;