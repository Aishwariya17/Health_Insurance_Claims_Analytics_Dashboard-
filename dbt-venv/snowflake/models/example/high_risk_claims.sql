{{ config(materialized='view') }}

SELECT 
    claim_id,
    provider_id,
    patient_id,
    billed_amount,
    paid_amount,
    ROUND(paid_amount / NULLIF(billed_amount, 0), 2) AS payment_ratio,
    CASE 
        WHEN paid_amount < (0.5 * billed_amount) THEN 'high risk'
        ELSE 'normal'
    END AS risk_flag
FROM {{ ref('stg_claims') }}
