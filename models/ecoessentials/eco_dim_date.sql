{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
) }}

WITH marketing AS (
    SELECT
        EVENTTIMESTAMP,
        SENDTIMESTAMP,
        NULL AS ORDER_TIMESTAMP,
        NULL AS date_key
    FROM {{ source('salesforce_landing', 'marketing_emails') }}
),

orders AS (
    SELECT
        NULL AS EVENTTIMESTAMP,
        NULL AS SENDTIMESTAMP,
        ORDER_TIMESTAMP AS ORDER_TIMESTAMP,
        ORDER_TIMESTAMP AS date_key
    FROM {{ source('transactional_landing', 'orders') }}
)

SELECT * FROM marketing
UNION ALL
SELECT * FROM orders
