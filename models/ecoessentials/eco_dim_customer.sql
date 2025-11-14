{{ config(
    materialized = 'table',
    database = 'GROUP1PROJECT',
    schema = 'dw_ecoessentials'
) }}

WITH customer AS (
    SELECT
        customer_id AS customer_key,
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
),

salesforce_email AS (
    SELECT
        customerid,
        subscriberid,
        subscriberemail,
        subscriberfirstname,
        subscriberlastname
    FROM {{ source('salesforce_landing', 'marketing_emails') }}
)

SELECT
    c.customer_key,
    c.customer_id,
    COALESCE(c.customer_first_name, s.subscriberfirstname) AS customer_first_name,
    COALESCE(c.customer_last_name, s.subscriberlastname) AS customer_last_name,
    c.customer_phone,
    c.customer_address,
    c.customer_city,
    c.customer_state,
    c.customer_zip,
    c.customer_country,
    s.subscriberid,
    s.subscriberemail,
    CASE
        WHEN s.subscriberid IS NOT NULL THEN 'Yes'
        ELSE 'No'
    END AS issubscriber
FROM customer c
FULL JOIN salesforce_email s
    ON c.customer_first_name = s.subscriberfirstname
    AND c.customer_last_name = s.subscriberlastname