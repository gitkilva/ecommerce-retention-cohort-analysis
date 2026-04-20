# Cohort Analysis - Insights & Notes

## Objective
Analyze customer retention and revenue behavior using cohort analysis to understand lifecycle patterns and long term value.

---

## Key Findings

- Customer retention drops significantly after the first month, indicating weak repeat purchase behaviour.
- A small percentage of customers continue purchasing over long periods, forming a long tail retention pattern.
- Some cohorts show irregular retention spikes, likely due to seasonal effects or promotional campaigns.

---

## Revenue Insights

- Revenue follows a similar decay pattern as customer retention.
- Initial cohort (cohort_age = 0) generates the highest revenue, acting as the baseline.
- Revenue retention declines over time, indicating decreasing customer value.

---

## Cohort Behavior

- Early cohorts behave differently from later cohorts, suggesting changes in acquisition quality or business strategy.
- Later cohorts show slightly more consistent retention in early months.

---

## Assumptions

- First purchase month defines cohort assignment.
- Monthly aggregation is used for consistency.
- Each customer is counted once per cohort period.

---

## Edge Cases & Decisions

- Partial cohorts (recent months) were handled carefully to avoid misleading retention drops.
- Missing future data was not treated as churn.
- Null or missing revenue values were checked before calculations.

---

## Business Interpretation

- Improving early retention (Month 1–2) would have the highest impact on long-term growth.
- Focus should be on increasing repeat purchases shortly after acquisition.
- Identifying high-retention cohorts can help refine marketing strategies.
