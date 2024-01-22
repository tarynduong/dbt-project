select
    {{ dbt_utils.generate_surrogate_key(['crs_dep_time', 'arr_time', 'crs_arr_time', get_unique_id(12), get_unique_id(10)]) }} AS flight_id,
    *,
    (distance * 1.6) AS distance_in_km
from {{ source('openflight_database', 'flights_2008') }}