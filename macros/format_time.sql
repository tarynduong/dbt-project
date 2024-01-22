{% macro format_time(column) %}
    substr(lpad({{ column }}, 4, '0'), 1, 2) || ':' || substr(lpad({{ column }}, 4, '0'), -2)
{% endmacro %}