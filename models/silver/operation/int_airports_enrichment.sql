with airports as (
    select * from {{ ref('stg_airports') }}
),
airlines as (
    select * from {{ ref('stg_airlines') }}
)
select
    airports.airport_id,
    airports.iata_code,
    airports.airport as airport_name,
    airlines.airline as airline_name,
    countries.region AS region_name,
    airports.country,
    countries.name as country_full_name,
    airports.state,
    airports.city,
    airports.latitude,
    airports.longitude
from
    airports 
    join airlines using (iata_code)
    left join {{ ref('iso_3166_countries_seed') }} countries on airports.country = countries.iso3