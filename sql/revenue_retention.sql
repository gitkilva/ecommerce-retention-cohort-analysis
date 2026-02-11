-- revenue_retention.sql
-- Purpose:
-- Analyze how revenue from each customer cohort changes over time
-- Includes:
-- 1) Monthly revenue by cohort and cohort_age
-- 2) Base revenue (cohort_age = 0) as reference point
-- 3) Revenue retention % relative to first purchase month
-- Output:
-- One row per cohort_month per cohort_age with revenue retention %
-- Used for:
-- Understanding long-term customer value and revenue decay

WITH cohort_base AS (
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
        ) AS cohort_age,
        revenue
    FROM orders
),

cohort_revenue AS (
    SELECT
        cohort_month,
        cohort_age,
        SUM(revenue) AS revenue
    FROM cohort_base
    GROUP BY cohort_month, cohort_age
),

cohort_base_revenue AS (
    SELECT
        cohort_month,
        revenue AS base_revenue
    FROM cohort_revenue
    WHERE cohort_age = 0
)

SELECT
    r.cohort_month,
    r.cohort_age,
    r.revenue,
    b.base_revenue,
    ROUND(
        100.0 * r.revenue / NULLIF(b.base_revenue, 0),
        2
    ) AS revenue_retention_pct
FROM cohort_revenue r
JOIN cohort_base_revenue b
    ON r.cohort_month = b.cohort_month
ORDER BY r.cohort_month, r.cohort_age;


