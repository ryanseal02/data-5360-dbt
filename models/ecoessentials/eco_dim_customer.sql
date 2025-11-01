{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
    )
}}

WITH customer as (
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
customer_country,
NULL AS subscriberid,
NULL AS customerid,
NULL AS subscriberemail,
NULL AS subscriberfirstname,
NULL AS subscriberlastname
FROM {{ source('transactional_landing', 'customer') }}
),

salesforce_email as (
select
NULL AS customer_key,
NULL AS customer_id,
NULL AS customer_first_name,
NULL AS customer_last_name,
NULL AS customer_phone,
NULL AS customer_address,
NULL AS customer_city,
NULL AS customer_state,
NULL AS customer_zip,
NULL AS customer_country,
subscriberid,
customerid,
subscriberemail,
subscriberfirstname,
subscriberlastname
FROM {{ source('salesforce_landing', 'marketing_emails') }}
)

SELECT * FROM customer
UNION ALL
SELECT * FROM salesforce_email
--We have this as a conformed dimension because we were doing to use it in conjuction with the salesforce email data.
--The main fields that we were going to combine/use together were customer email, first name, last name, and subscriber email, first name, last name.
--Not sure if these are the same or not but we should figure out if we need to have one, the other, or both.
--Also potentially need subscriber ID in here somewhere