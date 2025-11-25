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
INNER JOIN {{ ref('eco_dim_email') }} e ON me.emailid = e.email_key
INNER JOIN {{ ref('eco_dim_customer') }} c ON me.customerid = c.customer_id
INNER JOIN {{ ref('eco_dim_campaign') }} cp ON me.campaignid = cp.campaign_key
INNER JOIN {{ ref('eco_dim_date') }} d ON d.date_key = date(me.eventtimestamp)