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
    FROM GROUP1PROJECT.ECOESSENTIALS_SALESFORCE_SOURCE.marketing_emails
),

orders AS (
    SELECT
        NULL AS EVENTTIMESTAMP,
        NULL AS SENDTIMESTAMP,
        ORDER_TIMESTAMP
    FROM GROUP1PROJECT.ECOESSENTIALS_TRANSACTIONAL_SOURCE_TRANSACTIONAL_DB."ORDER"
)

SELECT * FROM marketing
UNION ALL
SELECT * FROM orders

--How can we create a date key/do we need one?
--Also not sure if this is connected to the rest of the data warehouse, because there is no source linked on the lineage graph below.