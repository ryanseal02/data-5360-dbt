{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}


select
emailid as email_key,
emailid,
emailname,
d.date_key as send_date_key
FROM {{ source('salesforce_landing', 'marketing_emails') }} me
INNER JOIN {{ ref('eco_dim_date') }} d ON d.date_key = me.sendtimestamp