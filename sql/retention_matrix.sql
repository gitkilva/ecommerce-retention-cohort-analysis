-- retention_matrix.sql
-- Purpose:
-- Calculate customer retention percentages using cohort analysis.
-- Output:
-- One row per cohort_month and cohort_age showing
-- active customers, cohort size, and retention percentage.

WITH orders_clean AS (

    -- Use customer_unique_id instead of customer_id
    -- to track actual customers across multiple orders.
    SELECT
        c.customer_unique_id,
        DATE_TRUNC('month', o.order_date) AS order_month,
        o.revenue

    FROM orders o
    JOIN customers c
        ON o.customer_id = c.customer_id

),

first_purchase AS (

    -- Determine each customer's first purchase month.
    SELECT
        customer_unique_id,
        MIN(order_month) AS cohort_month

    FROM orders_clean

    GROUP BY customer_unique_id

),

cohort_base AS (

    -- Attach the cohort month to every order
    -- and calculate months since first purchase.
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

),

cohort_sizes AS (

    -- Month 0 represents customers entering each cohort.
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_unique_id) AS cohort_size

    FROM cohort_base

    WHERE cohort_age = 0

    GROUP BY cohort_month

),

active_customers AS (

    -- Count unique customers active in each cohort month.
    SELECT
        cohort_month,
        cohort_age,
        COUNT(DISTINCT customer_unique_id) AS active_customers

    FROM cohort_base

    GROUP BY
        cohort_month,
        cohort_age

)

-- Customer Retention % = Active Customers / Cohort Size

SELECT

    a.cohort_month,
    a.cohort_age,
    a.active_customers,
    s.cohort_size,

    ROUND(
        100.0 * a.active_customers / s.cohort_size,
        2
    ) AS retention_pct

FROM active_customers a

JOIN cohort_sizes s
    ON a.cohort_month = s.cohort_month

WHERE a.cohort_age >= 0

ORDER BY
    a.cohort_month,
    a.cohort_age;

/*
Alternative approach:
The first_purchase logic can also be implemented using
MIN(order_month) OVER (PARTITION BY customer_unique_id).
A CTE-based approach was chosen here for readability.
*/
