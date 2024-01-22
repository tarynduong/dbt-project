{% macro get_unique_id(digits=12) %}
    floor(random() * {{ 10 ** digits }})
{% endmacro %}