with payments as (
    select * from {{ ref('int_customer_enrichment') }}
)
select 
    amount
from payments
where amount < 0