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
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_date) AS order_month,
        o.revenue
    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id
),

first_purchase AS (
    SELECT
        customer_unique_id,
        MIN(order_month) AS cohort_month
    FROM orders_clean
    GROUP BY customer_unique_id
),

cohort_base AS (
    SELECT
        o.customer_unique_id,
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
        ON o.customer_unique_id = f.customer_unique_id
)

SELECT *
FROM cohort_base;
