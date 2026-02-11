-- cohort_base.sql
-- Purpose:
-- Build a customer-month level table with cohort information
-- Includes:
-- 1) First purchase month (cohort_month)
-- 2) Order month
-- 3) Cohort age (months since first purchase)
-- 4) Monthly revenue per customer

WITH orders_clean AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month,
        revenue
    FROM orders
),

first_purchase AS (
    SELECT
        customer_id,
        MIN(order_month) AS cohort_month
    FROM orders_clean
    GROUP BY customer_id
),

cohort_base AS (
    SELECT
        o.customer_id,
        o.order_month,
        f.cohort_month,
        DATE_DIFF(
            o.order_month,
            f.cohort_month,
            MONTH
        ) AS cohort_age,
        o.revenue
    FROM orders_clean o
    JOIN first_purchase f
        ON o.customer_id = f.customer_id
)

SELECT *
FROM cohort_base;
