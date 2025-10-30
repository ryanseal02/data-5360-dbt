{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}


select
emailid as email_key,
emailid,
emailname
FROM {{ source('salesforce_landing', 'marketing_emails') }}