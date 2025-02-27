with fhv_t_diff AS
(
  SELECT 
    *,
    TIMESTAMP_DIFF(dropoff_datetime, pickup_datetime, SECOND) trip_duration
  FROM {{ ref('dim_fhv_trips') }}

),

percentile AS
( 
  SELECT 
  dispatching_base_num,
  year,
  month,
  pickup_zone,
  dropoff_zone,
  PERCENTILE_CONT(trip_duration, 0.9) OVER (PARTITION BY year, month, pickup_locationid, dropoff_locationid) p90
 FROM fhv_t_diff
)

SELECT DISTINCT * FROM percentile