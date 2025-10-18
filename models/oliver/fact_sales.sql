{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    p.product_key,
    c.customer_key,
    e.employee_key,
    d.date_key,
    s.store_key,
    o.total_amount
FROM {{ source('oliver_landing', 'orderline') }} ol
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON ol.order_id = o.order_id
INNER JOIN {{ ref('oliver_dim_customer') }} c ON o.customer_id = c.customer_id 
INNER JOIN {{ ref('oliver_dim_employee') }} e ON o.employee_id = e.employee_id 
INNER JOIN {{ ref('oliver_dim_store') }} s ON o.store_id = s.store_id
INNER JOIN {{ ref('oliver_dim_product') }} p ON ol.product_id = p.product_id
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_day = o.order_date
