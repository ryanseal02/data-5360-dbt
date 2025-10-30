{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}


WITH promotional AS (
    SELECT
        CAMPAIGN_NAME,
        CAMPAIGN_DISCOUNT,
        NULL AS PROMOTIONAL_CAMPAIGN
    FROM GROUP1PROJECT.ECOESSENTIALS_TRANSACTIONAL_SOURCE_TRANSACTIONAL_DB.PROMOTIONAL_CAMPAIGN
),

orderline AS (
    SELECT
        NULL AS CAMPAIGN_NAME,
        NULL AS CAMPAIGN_DISCOUNT,
        PROMOTIONAL_CAMPAIGN
    FROM GROUP1PROJECT.ECOESSENTIALS_TRANSACTIONAL_SOURCE_TRANSACTIONAL_DB."ORDER_LINE"
)

SELECT * FROM promotional
UNION ALL
SELECT * FROM orderline

--There is also a campaign name in the salesforce email source data, not sure if we need that/want to include it
--Also not sure if this is connected to the rest of the data warehouse, because there is no source linked on the lineage graph below.