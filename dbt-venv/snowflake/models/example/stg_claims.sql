{{ config(materialized='view') }}

WITH base AS (
    SELECT 
        claim_id,
        provider_id,
        patient_id,
        TRY_CAST(date_of_service AS DATE) AS date_of_service,
        billed_amount,
        procedure_code,
        diagnosis_code,
        allowed_amount,
        paid_amount,
        LOWER(TRIM(insurance_type)) AS insurance_type,
        LOWER(TRIM(claim_status)) AS claim_status,
        LOWER(TRIM(reason_code)) AS reason_code,
        LOWER(TRIM(follow_up_required)) AS follow_up_required,
        LOWER(TRIM(ar_status)) AS ar_status,
        LOWER(TRIM(outcome)) AS outcome
    FROM {{ source('snowflake_source', 'claims_data') }}
)
SELECT * FROM base
