with airports as (
    select * from {{ ref('stg_airports') }}
),
airlines as (
    select * from {{ ref('stg_airlines') }}
),
flights as (
    select * from {{ ref('stg_flights_2008') }}
),
planes as (
    select * from {{ ref('int_plane_filter') }}
),
fct_flights as (
    select
        flights.*,
        air_origin.airport_id as origin_airport_id,
        air_origin.airport as origin_airport_name,
        air_origin.city as origin_airport_city,
        air_origin.state as origin_airport_state,
        air_origin.latitude as origin_latitude,
        air_origin.longitude as origin_longitude,
        air_dest.airport_id as dest_airport_id,
        air_dest.airport as dest_airport_name,
        air_dest.city as dest_airport_city,
        air_dest.state as dest_airport_state,
        air_dest.latitude as dest_latitude,
        air_dest.longitude as dest_longitude,
        current_timestamp as last_updated_ts
    from flights
    join airports air_origin on flights.origin = air_origin.iata_code
    join airports air_dest on flights.dest = air_dest.iata_code
)
select
    flight_id,
    origin_airport_name,
    dest_airport_name,
    origin_airport_state,
    dest_airport_state,
    origin_airport_city,
    dest_airport_city,
    origin_latitude,
    origin_longitude,
    dest_latitude,
    dest_longitude,
    cast((year || '-' || month || '-' || day_of_month) as date) AS flight_date,
    {% for column in ['dep_time', 'crs_dep_time', 'arr_time', 'crs_arr_time'] -%}
    cast((flight_date || 'T' || {{ format_time(column) }}) as timestamp) AS {{ column }}_timestamp,
    {% endfor -%}
    {{ get_distance_of_two_points('origin_latitude', 'origin_longitude', 'dest_latitude', 'dest_longitude', 'miles') }} AS airport_distance_in_miles,
    planes.type as plane_type,
    planes.manufacturer as plane_manufacturer,
    planes.year as plane_year
from fct_flights
join planes using (tailnum)