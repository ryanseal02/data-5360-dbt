{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}


WITH promotional AS (
    SELECT
        CAMPAIGN_ID AS campaign_key,
        CAMPAIGN_NAME,
        CAMPAIGN_DISCOUNT,
        NULL AS PROMOTIONAL_CAMPAIGN
    FROM {{ source('transactional_landing', 'promotional_campaign') }}
),

orderline AS (
    SELECT
        NULL AS campaign_key,
        NULL AS CAMPAIGN_NAME,
        NULL AS CAMPAIGN_DISCOUNT,
        PROMOTIONAL_CAMPAIGN
    FROM {{ source('transactional_landing', 'order_line') }}
)

SELECT * FROM promotional
UNION ALL
SELECT * FROM orderline


--There is also a campaign name in the salesforce email source data, not sure if we need that/want to include it
--Also not sure if this is connected to the rest of the data warehouse, because there is no source linked on the lineage graph below.