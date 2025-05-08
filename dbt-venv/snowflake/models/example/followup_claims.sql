{{ config(materialized='view') }}

SELECT 
    claim_id,
    provider_id,
    patient_id,
    claim_status,
    reason_code,
    ar_status,
    outcome
FROM {{ ref('stg_claims') }}
WHERE follow_up_required = 'yes'
