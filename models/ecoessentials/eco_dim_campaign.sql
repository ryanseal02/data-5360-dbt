{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
) }}

WITH promotional AS (
    SELECT
        CAMPAIGN_ID AS campaign_key,
        CAMPAIGN_NAME,
        CAMPAIGN_DISCOUNT
    FROM {{ source('transactional_landing', 'promotional_campaign') }}
),

orderline AS (
    SELECT
        CAMPAIGN_ID AS campaign_key,
        PROMOTIONAL_CAMPAIGN
    FROM {{ source('transactional_landing', 'order_line') }}
),

salesforce AS (
    SELECT
        CAMPAIGNID,
        CAMPAIGNNAME
    FROM {{ source('salesforce_landing', 'marketing_emails') }}
)

SELECT 
    COALESCE(p.campaign_key, o.campaign_key, s.CAMPAIGNID) AS campaign_key,
    p.CAMPAIGN_NAME AS transactional_campaign_name,
    s.CAMPAIGNNAME AS salesforce_campaign_name,
    p.CAMPAIGN_DISCOUNT,
    o.PROMOTIONAL_CAMPAIGN
FROM promotional p
FULL JOIN orderline o
    ON p.campaign_key = o.campaign_key
FULL JOIN salesforce s
    ON COALESCE(p.campaign_key, o.campaign_key) = s.CAMPAIGNID


