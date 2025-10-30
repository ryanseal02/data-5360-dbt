{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}


select
customer_id as customer_key,
customer_id,
customer_first_name,
customer_last_name,
customer_phone,
customer_address,
customer_city,
customer_state,
customer_zip,
customer_country
FROM {{ source('transactional_landing', 'customer') }}

--We have this as a conformed dimension because we were doing to use it in conjuction with the salesforce email data.
--The main fields that we were going to combine/use together were customer email, first name, last name, and subscriber email, first name, last name.
--Not sure if these are the same or not but we should figure out if we need to have one, the other, or both.
--Also potentially need subscriber ID in here somewhere