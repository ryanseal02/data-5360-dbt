{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}


SELECT
    emailid AS email_key,
    emailid,
    emailname,
    d.date_key AS send_date_key
FROM GROUP1PROJECT.ecoessentials_salesforce_source.marketing_emails me
INNER JOIN GROUP1PROJECT.dbt_rseal.eco_dim_date d 
    ON d.date_key = TO_DATE(NULLIF(TO_VARCHAR(me.sendtimestamp), 'NULL'))

