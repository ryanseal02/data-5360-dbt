{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
) }}

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
        CAMPAIGN_ID AS campaign_key,
        NULL AS CAMPAIGN_NAME,
        NULL AS CAMPAIGN_DISCOUNT,
        PROMOTIONAL_CAMPAIGN
    FROM {{ source('transactional_landing', 'order_line') }}
)

SELECT
    COALESCE(p.campaign_key, o.campaign_key) AS campaign_key,
    p.CAMPAIGN_NAME,
    p.CAMPAIGN_DISCOUNT
FROM promotional p
FULL JOIN orderline o
    ON p.campaign_key = o.campaign_key