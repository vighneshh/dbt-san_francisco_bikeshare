{{
  config(
    materialized='table'
  )
}}

with bikeshare_stations as (

    select * from {{ ref('stg_bikeshare_station_info') }}

),


regions as (

   select * from {{ ref('stg_bikeshare_regions') }}
  
),

trips as (

   select * from {{ ref('stg_bikeshare_trips') }}
  
),



dbt_bikeshare_station_region_info as (

    select
        bikeshare_stations.station_id,
        bikeshare_stations.station_name,
        bikeshare_stations.short_name,
        bikeshare_stations.lat,
        bikeshare_stations.lon,
        bikeshare_stations.region_id,
        bikeshare_stations.capacity,
        bikeshare_stations.has_kiosk,
        regions.region_name

    from bikeshare_stations

    left join regions using (region_id)

)

-- select * from dbt_bikeshare_station_region_info




select 
trips.trip_id,
trips.duration_sec,
date(trips.start_date) as start_date,
trips.start_station_id,
date(trips.end_date) as end_date,
trips.end_station_id,
trips.bike_number,
trips.subscriber_type,
trips.member_birth_year,
trips.member_gender,
trips.bike_share_for_all_trip,
start_station.station_name as start_station_name,
start_station.region_name as start_station_region,
end_station.station_name as end_station_name,
end_station.region_name as end_station_region

from trips
inner join dbt_bikeshare_station_region_info as start_station
on trips.start_station_id = start_station.station_id
inner join dbt_bikeshare_station_region_info as end_station
on trips.start_station_id = end_station.station_id
