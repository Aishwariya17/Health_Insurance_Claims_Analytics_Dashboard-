{{ config(materialized='table') }}

WITH provider_denials AS (
    SELECT 
        provider_id,
        COUNT(CASE WHEN claim_status = 'denied' THEN 1 END) AS denied_claims,
        COUNT(claim_id) AS total_claims,
        ROUND(100.0 * COUNT(CASE WHEN claim_status = 'denied' THEN 1 END) / NULLIF(COUNT(claim_id), 0), 2) AS denial_rate
    FROM {{ ref('stg_claims') }}
    GROUP BY provider_id
)
SELECT * FROM provider_denials
ORDER BY denial_rate DESC
