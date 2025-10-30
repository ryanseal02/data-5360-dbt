{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}


WITH marketing AS (
    SELECT
        EVENTTIMESTAMP,
        SENDTIMESTAMP,
        NULL AS ORDER_TIMESTAMP
    FROM {{ source('salesforce_landing', 'marketing_emails') }}
),

orders AS (
    SELECT
        NULL AS EVENTTIMESTAMP,
        NULL AS SENDTIMESTAMP,
        ORDER_TIMESTAMP
    FROM {{ source('transactional_landing', 'orders') }}
)

SELECT * FROM marketing
UNION ALL
SELECT * FROM orders

--How can we create a date key/do we need one?
--Also not sure if this is connected to the rest of the data warehouse, because there is no source linked on the lineage graph below.