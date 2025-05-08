{{
    config(
        materialized='table'
    )
}}

with final as (
    select distinct
        Claim_ID,
        Provider_ID,
        Patient_ID,
        Date_of_Service,
        Billed_Amount,
        Procedure_Code,
        Diagnosis_Code,
        Allowed_Amount,
        Paid_Amount,
        Insurance_Type,
        Claim_Status,
        Reason_Code,
        Follow_up_Required,
        AR_Status,
        Outcome
    from 
        {{ ref('stg_claims') }}
)
select 
    *
from 
    final
