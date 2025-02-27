
WITH trips as
(
  SELECT * FROM {{ ref('fact_trips') }}
  WHERE fare_amount > 0
  AND trip_distance > 0
  AND payment_type_description in ('Cash', 'Credit card')
),

percentile as(
  SELECT 
    *,
    PERCENTILE_CONT(fare_amount, 0.97) OVER (PARTITION BY service_type, year, month) p97,
    PERCENTILE_CONT(fare_amount, 0.95) OVER (PARTITION BY service_type, year, month) p95,
    PERCENTILE_CONT(fare_amount, 0.90) OVER (PARTITION BY service_type, year, month) p90
  FROM trips
)

SELECT DISTINCT service_type,
    year,
    month,
    p97,
    p95,
    p90
FROM percentile
ORDER BY service_type, year, month
