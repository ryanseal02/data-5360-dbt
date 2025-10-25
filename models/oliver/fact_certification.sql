{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    e.employee_id,
    d.date_key,
    c.certification_name,
    c.certification_cost
from {{ ref('stg_customer_service_interactions1') }} c
inner join {{ ref('oliver_dim_employee') }} e
    on e.employee_id = c.employee_id
inner join {{ ref('oliver_dim_date') }} d
    on d.date_key = c.certification_awarded_date
