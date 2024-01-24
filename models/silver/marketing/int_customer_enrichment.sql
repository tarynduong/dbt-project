select
    first_name || ' ' || middle_name || ' ' || last_name as full_name,
    year(current_date()) - year(birth_date) - (case when ((month(current_date()) < month(birth_date) or
                                               month(current_date()) = month(birth_date)) and
                                               day(current_date()) < day(birth_date)) then 1 else 0 end) as age,
    split(email_address, '@')[1] as email_domain,
    concat('XXXXX', substr(phone, -3)) as masked_phone,
    amount,
    number_of_ticket,
    date_first_purchase
from
    {{ ref('stg_customers') }}