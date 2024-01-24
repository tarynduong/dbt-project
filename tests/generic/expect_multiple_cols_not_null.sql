{% test expect_multiple_cols_not_null(model, list_column_names) %}
select 
    * 
from {{ model }}
where 
{% for column_name in list_column_names %}
column_name is null
{% if not loop.last %}
or
{% endif %}
{% endfor %}
{% endtest %}