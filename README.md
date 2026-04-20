# Customer Retention & Cohort Analysis (E-commerce)

## Overview
This project analyzes customer purchase behavior using cohort analysis to understand retention trends, revenue decay, and long-term customer value.

The analysis combines **SQL for data modeling** and **Python for analysis & visualization**, replicating a real-world data workflow.

---

## Objective
- Measure customer retention over time
- Analyze revenue behavior across cohorts
- Identify patterns in customer lifecycle
- Support data-driven decision making

---

## Approach

### 1. SQL Layer (Data Modeling)
Built core cohort datasets using SQL:

- **cohort_base.sql**
  - Creates customer-month level dataset
  - Calculates cohort_month (first purchase)
  - Computes cohort_age

- **retention_matrix.sql**
  - Calculates cohort size
  - Computes active customers
  - Derives retention %

- **revenue_retention.sql**
  - Aggregates revenue per cohort
  - Calculates revenue retention %

---

### 2. Python Layer (Analysis & Visualization)

- Data validation and transformation using Pandas
- Replicated retention logic
- Built cohort retention matrix
- Created heatmap for visualization

---

## Key Insights

- Customer retention drops sharply after the first month
- Only a small percentage of customers remain active long-term
- Revenue follows a similar decay pattern as retention
- Some cohorts show irregular spikes likely seasonal or campaign driven

---

## Project Structure

ecommerce-retention-cohort-analysis/
│
├── data/                  # Raw datasets
├── sql/                   # SQL queries for cohort analysis
├── python/                # Jupyter notebook (EDA & analysis)
├── documentation/         # Insights and analysis notes
├── dashboard/             # Power BI dashboard (to be added)
└── README.md

---

## Tools & Technologies

- SQL (CTEs, Window Functions, Aggregations)
- Python (Pandas, Matplotlib, Seaborn)
- Jupyter Notebook
- Git & GitHub

---

## Business Value

- Helps identify customer drop-off points
- Supports retention strategy improvements
- Enables understanding of long-term customer value
- Assists in evaluating marketing effectiveness across cohorts

---

## Next Steps

- Build a Power BI dashboard to make cohort insights easier to explore
- Segment cohorts by category or region to identify high-value customer groups
- Convert the analysis into a reusable pipeline instead of manual execution
