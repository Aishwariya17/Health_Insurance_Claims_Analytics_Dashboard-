{{ config(materialized='table') }}

WITH denials AS (
    SELECT 
        reason_code,
        COUNT(claim_id) AS denied_claims
    FROM {{ ref('stg_claims') }}
    WHERE claim_status = 'denied'
    GROUP BY reason_code
)
SELECT 
    reason_code, 
    denied_claims,
    ROUND(100.0 * denied_claims / NULLIF(SUM(denied_claims) OVER(), 0), 2) AS denial_percentage
FROM denials
ORDER BY denied_claims DESC
