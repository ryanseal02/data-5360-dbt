{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
) }}

SELECT
    e.email_key,
    c.customer_key,
    d.date_key as event_date_key,
    cp.campaign_key,
    me.emaileventid
FROM {{source('salesforce_landing', 'marketing_emails')}} me
INNER JOIN {{ ref('eco_dim_email') }} e ON TRY_TO_NUMBER(NULLIF(TO_VARCHAR(me.emailid), 'NULL')) = e.email_key
INNER JOIN {{ ref('eco_dim_customer') }} c ON TRY_TO_NUMBER(NULLIF(TO_VARCHAR(me.customerid), 'NULL')) = c.customer_id
INNER JOIN {{ ref('eco_dim_campaign') }} cp ON TRY_TO_NUMBER(NULLIF(TO_VARCHAR(me.campaignid), 'NULL')) = cp.campaign_key
INNER JOIN {{ ref('eco_dim_date') }} d ON d.date_key = TO_DATE(NULLIF(TO_VARCHAR(me.eventtimestamp), 'NULL'))
