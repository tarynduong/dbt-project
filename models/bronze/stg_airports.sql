select 
    {{ dbt_utils.generate_surrogate_key(['iata_code', 'city']) }} as airport_id,
    *
from {{ source('openflight_database', 'airports') }}