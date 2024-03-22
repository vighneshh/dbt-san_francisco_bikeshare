{{
  config(
    materialized='table'
  )
}}

with bikeshare_stations as (

    select
        station_id,
    name as station_name,
    short_name,
    lat,
    lon,
    region_id,
    capacity,
    has_kiosk
    from `dataengzoomcamp-413305.san_francisco_bikeshare.bikeshare_station_info`

),


regions as (

    select
        region_id,
        name as region_name
 
    from `dataengzoomcamp-413305.san_francisco_bikeshare.bikeshare_regions`

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

select * from dbt_bikeshare_station_region_info