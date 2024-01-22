select
    {{ dbt_utils.generate_surrogate_key(['tailnum', 'manufacturer', 'model', 'aircraft_type']) }} AS plane_id,
    *
from {{ source('openflight_database', 'plane') }}