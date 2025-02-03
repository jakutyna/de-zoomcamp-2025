-- SELECT count(index)
-- FROM public.green_taxi_data
-- WHERE lpep_pickup_datetime >= date '2019-10-01'
-- AND lpep_dropoff_datetime < date '2019-11-01'
-- AND trip_distance > 10
-- -- AND trip_distance <= 10;

-- SELECT lpep_pickup_datetime, trip_distance
-- FROM green_taxi_data
-- ORDER BY trip_distance DESC;

SELECT 
	z."Zone",
	SUM(total_amount) total_am_sum
FROM green_taxi_data t
JOIN taxi_zone_lookup z
	ON t."PULocationID" = z."LocationID"
WHERE DATE(lpep_pickup_datetime) = date '2019-10-18'
GROUP BY z."Zone"
ORDER BY "total_am_sum" DESC;

-- SELECT 
-- 	t.tip_amount,
-- 	zpu."Zone" pickup_zone,
-- 	zdo."Zone" dropoff_zone
-- FROM green_taxi_data t
-- JOIN taxi_zone_lookup zpu
-- 	ON t."PULocationID" = zpu."LocationID"
-- JOIN taxi_zone_lookup zdo
-- 	ON t."DOLocationID" = zdo."LocationID"
-- WHERE zpu."Zone"  = 'East Harlem North'
-- ORDER BY tip_amount desc;

-- SELECT * FROM green_taxi_data;

