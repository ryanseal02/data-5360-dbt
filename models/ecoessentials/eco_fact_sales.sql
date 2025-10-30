{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

SELECT
    p.product_key,
    c.customer_key,
    e.employee_key,
    d.date_key,
    s.campagin_key,
    o.total_amount

