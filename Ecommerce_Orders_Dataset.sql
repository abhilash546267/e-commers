create database Ecommerce_Orders_Dataset ;

use ecommerce_orders_dataset;
select * from ecommerce_orders_dataset;

-- Order Volume & Revenue
-- total orders placed per month.

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity * price_per_unit) AS total_revenue
FROM
     ecommerce_orders_dataset
GROUP BY
    DATE_FORMAT(order_date, '%Y-%m')
ORDER BY
    month;
    
   -- Average shipping time
    -- Average delivery time
    
SELECT
    ROUND(AVG(DATEDIFF(ship_date, order_date)), 2) AS avg_shipping_days,
    ROUND(AVG(DATEDIFF(delivery_date, ship_date)), 2) AS avg_delivery_days
FROM ecommerce_orders_dataset
WHERE delivery_status = 'Delivered';

-- Count of delayed deliveries.

SELECT
    region,
    COUNT(*) AS delayed_orders
FROM ecommerce_orders_dataset
WHERE delivery_status = 'Delayed'
GROUP BY region;

-- Top 5 customers by total spend.

select customer_id,
sum(quantity*price_per_unit) as total_spend
from ecommerce_orders_dataset
group by customer_id
order by total_spend desc
limit 5;
-- Top-selling products by quantity and revenue.

select product_id,
sum(quantity) as total_units_sold,
sum(quantity*price_per_unit) as total_revenue
from ecommerce_orders_dataset
group by product_id
order by total_revenue desc
limit 5;