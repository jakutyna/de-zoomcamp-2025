{{
    config(
        materialized='table'
    )
}}

with q_revenue AS
(
  SELECT
  service_type,
  year,
  quarter,
  sum(total_amount) quarterly_revenue
  FROM {{ ref('fact_trips') }}
  GROUP BY service_type, year, quarter
  ORDER BY service_type, year, quarter
)

SELECT *, 
  (quarterly_revenue
  - LAG(quarterly_revenue) OVER (PARTITION BY service_type ORDER BY quarter, year)) * 100 
  / LAG(quarterly_revenue) OVER (PARTITION BY service_type ORDER BY quarter, year) yoy_revenue
FROM q_revenue
WHERE quarterly_revenue != 0