{{
    config(
        materialized='table'
    )
}}

with fhv as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select fhv.*, 
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone,
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone, 
    EXTRACT(YEAR FROM fhv.pickup_datetime) year,
    EXTRACT(MONTH FROM fhv.pickup_datetime) month,
    CASE
        WHEN EXTRACT(MONTH FROM fhv.pickup_datetime) BETWEEN 1 AND 3 THEN 'Q1'
        WHEN EXTRACT(MONTH FROM fhv.pickup_datetime) BETWEEN 4 AND 6 THEN 'Q2'
        WHEN EXTRACT(MONTH FROM fhv.pickup_datetime) BETWEEN 7 AND 9 THEN 'Q3'
        ELSE 'Q4'
        END quarter,
from fhv
inner join dim_zones as pickup_zone
on fhv.pickup_locationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on fhv.dropoff_locationid = dropoff_zone.locationid