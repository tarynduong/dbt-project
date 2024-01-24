{{ config(materialized = 'incremental', on_schema_change = 'sync_all_columns') }}

select 
    * 
from {{ ref('int_customer_enrichment') }}
{% if is_incremental() -%}
where date_first_purchase >= (select max(date_first_purchase) from {{ this }})
{%- endif -%}