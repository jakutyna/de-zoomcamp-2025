CREATE EXTERNAL TABLE
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024_ext`
  -- This works because "month=<val>" prefixes were created for each month data in GCS
WITH PARTITION COLUMNS OPTIONS ( uris = ['gs://terraform-demo-449409-terra-bucket/yellow_tripdata_2024/*'],
    format = 'PARQUET',
    hive_partition_uri_prefix = 'gs://terraform-demo-449409-terra-bucket/yellow_tripdata_2024',
    require_hive_partition_filter = FALSE);


CREATE OR REPLACE TABLE
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024` AS (
  SELECT
    *
  FROM
    `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024_ext` );


SELECT
  COUNT( DISTINCT PULocationID)
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`;


SELECT
  COUNT( DISTINCT PULocationID)
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024_ext`;


SELECT
  PULocationID
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`;


SELECT
  PULocationID,
  DOLocationID
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`;


SELECT
  COUNT(fare_amount)
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`
WHERE
  fare_amount=0;


CREATE OR REPLACE TABLE
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024_partitioned` LIKE `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`
PARTITION BY
  DATE(tpep_dropoff_datetime)
CLUSTER BY
  VendorID ;


INSERT INTO
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024_partitioned`
SELECT
  *
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`;


SELECT
  DISTINCT VendorID
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`
WHERE
  tpep_dropoff_datetime BETWEEN "2024-03-01"
  AND "2024-03-15";


SELECT
  DISTINCT VendorID
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024_partitioned`
WHERE
  tpep_dropoff_datetime BETWEEN "2024-03-01"
  AND "2024-03-15";

-- This query uses 0B of data because information about number of rows is stored in metadata
SELECT
  COUNT(*)
FROM
  `terraform-demo-449409.demo_dataset.yellow_taxi_data_2024`;