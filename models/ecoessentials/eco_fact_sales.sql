{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
) }}

SELECT
    ep.product_key,
    c.customer_key,
    d.date_key as order_date_key,
    cp.campaign_key,
    p.price,
    ol.quantity,
    ol.discount,
    ol.price_after_discount
FROM {{ source('transactional_landing', 'product') }} p
INNER JOIN {{ source('transactional_landing', 'order_line') }} ol ON p.product_id = ol.product_id
INNER JOIN {{ source('transactional_landing', 'orders') }} o ON ol.order_id = o.order_id
INNER JOIN {{ ref('eco_dim_product') }} ep ON ol.product_id = ep.product_id
INNER JOIN {{ ref('eco_dim_customer') }} c ON o.customer_id = c.customer_id
INNER JOIN {{ ref('eco_dim_campaign') }} cp ON ol.campaign_id = cp.campaign_key
INNER JOIN {{ ref('eco_dim_date') }} d ON d.date_key = o.order_timestamp