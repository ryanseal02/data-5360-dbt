{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}


select
employee_id as employee_key,
employee_id,
first_name,
last_name,
email,
hire_date,
position,
phone_number
FROM {{ source('oliver_landing', 'employee') }}