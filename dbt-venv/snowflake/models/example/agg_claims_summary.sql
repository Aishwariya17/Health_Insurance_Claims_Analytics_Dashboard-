{{ config(materialized='table') }}

WITH claim_summary AS (
    SELECT 
        provider_id,
        insurance_type,
        COUNT(claim_id) AS total_claims,
        SUM(billed_amount) AS total_billed,
        SUM(allowed_amount) AS total_allowed,
        SUM(paid_amount) AS total_paid,
        ROUND(SUM(paid_amount) / NULLIF(SUM(billed_amount), 0), 2) AS payment_ratio,
        ROUND(SUM(allowed_amount) / NULLIF(SUM(billed_amount), 0), 2) AS allowed_ratio
    FROM {{ ref('stg_claims') }}
    GROUP BY provider_id, insurance_type
)
SELECT * FROM claim_summary
