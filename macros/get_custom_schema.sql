{% macro generate_schema_name(custom_schema_name, node) -%}

   {%- set default_schema = target.schema -%}
   {%- if target.name == "circleci" -%}
       {# replace everything except letter and number in branch name to be underscore#}
       {% set re = modules.re %}
       {% set git_branch = modules.re.sub('[^a-zA-Z0-9]', '_', env_var('CIRCLE_BRANCH')).lower() %}
       {%- if custom_schema_name is none -%}
           z_pr_{{ git_branch }}_{{ default_schema }}
       {%- else -%}
           z_pr_{{ git_branch }}_{{default_schema}}_{{ custom_schema_name | trim }}
       {%- endif -%}
   {%- else -%}
       {%- if custom_schema_name is none -%}
           {{ default_schema }}
       {%- else -%}
           {{ custom_schema_name | trim }}
       {%- endif -%}
{%- endmacro -%}       