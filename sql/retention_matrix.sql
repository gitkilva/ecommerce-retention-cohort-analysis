-- retention_matrix.sql
-- Purpose:
-- Calculate customer retention percentages using cohort analysis
-- Includes:
-- 1) Cohort sizes (customers in cohort_month = first purchase month)
-- 2) Active customers by cohort_age (months since first purchase)
-- 3) Retention % = active_customers / cohort_size
-- Output:
-- One row per cohort_month per cohort_age
-- Used for:
-- Retention heatmaps and lifecycle analysis

WITH cohort_base AS (
    -- cohort_base CTEs here
    SELECT
        customer_id,
        DATE_TRUNC('month', order_date) AS order_month,
        MIN(DATE_TRUNC('month', order_date))
            OVER (PARTITION BY customer_id) AS cohort_month,
        DATE_DIFF(
            DATE_TRUNC('month', order_date),
            MIN(DATE_TRUNC('month', order_date))
                OVER (PARTITION BY customer_id),
            MONTH
        ) AS cohort_age
    FROM orders
),

cohort_sizes AS (
    SELECT
        cohort_month,
        COUNT(DISTINCT customer_id) AS cohort_size
    FROM cohort_base
    WHERE cohort_age = 0
    GROUP BY cohort_month
),

retained_customers AS (
    SELECT
        cohort_month,
        cohort_age,
        COUNT(DISTINCT customer_id) AS active_customers
    FROM cohort_base
    GROUP BY cohort_month, cohort_age
)

SELECT
    r.cohort_month,
    r.cohort_age,
    r.active_customers,
    s.cohort_size,
    ROUND(
        100.0 * r.active_customers / s.cohort_size,
        2
    ) AS retention_pct
FROM retained_customers r
JOIN cohort_sizes s
    ON r.cohort_month = s.cohort_month
WHERE r.cohort_age >= 0
ORDER BY r.cohort_month, r.cohort_age;
