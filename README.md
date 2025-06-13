
# 🏥 Healthcare Claims Analytics Project (AWS S3 → Snowflake → DBT → Tableau)

This project presents a complete **healthcare claims analytics pipeline**, from raw data in **AWS S3**, transformation using **DBT** on **Snowflake**, and final visualization in **Tableau**.

---

## 📌 Pipeline Overview

```
[CSV Files] → [AWS S3] → [Snowflake External Stage & Table] → [DBT Transformations] → [Tableau Dashboard]
```

---

## 🧱 Tech Stack

| Layer         | Tool         | Purpose                           |
|---------------|--------------|-----------------------------------|
| Storage       | AWS S3       | Raw claims CSV files              |
| Warehouse     | Snowflake    | Centralized query & compute layer |
| Transformation| DBT          | SQL-based data modeling           |
| Visualization | Tableau      | Dashboard & insights              |

---

## 🛠️ Step-by-Step Setup

### ✅ 1. Upload Data to AWS S3

- Go to AWS S3 Console
- Create a bucket: `claims-data-bucket`
- Upload your file: `claims_data.csv`

---

### ✅ 2. Connect Snowflake to S3

**In Snowflake:**

```sql
create warehouse DWH_WH;
create database DBT_DB
create schema DBT_DB.CLAIM

create or replace storage integration Claim_OBJ
 type = external_stage
 storage_provider = s3
  enabled = true
  storage_aws_role_arn = 'arn:aws:iam::565393055875:role/claims-data-role'
 storage_allowed_locations = ('s3://healthplan-claims-project/');

 desc integration Claim_OBJ;

 create or replace file format csv_format type = csv field_delimiter = ',' skip_header = 1 null_if = ('NULL', 'null') empty_field_as_null = true;

 create or replace stage claim_stage
 storage_integration = Claim_OBJ
 url = 's3://healthplan-claims-project/'
 file_format = csv_format;

 CREATE OR REPLACE TABLE claims_data (
    CLAIM_ID VARCHAR(20),
    PROVIDER_ID BIGINT,
    PATIENT_ID BIGINT,
    DATE_OF_SERVICE DATE,
    BILLED_AMOUNT DECIMAL(10,2),
    PROCEDURE_CODE INT,
    DIAGNOSIS_CODE VARCHAR(10),
    ALLOWED_AMOUNT DECIMAL(10,2),
    PAID_AMOUNT DECIMAL(10,2),
    INSURANCE_TYPE VARCHAR(50),
    CLAIM_STATUS VARCHAR(20),
    REASON_CODE VARCHAR(100),
    FOLLOW_UP_REQUIRED VARCHAR(5),
    AR_STATUS VARCHAR(30),
    OUTCOME VARCHAR(30)
);

copy into claims_data from @claim_stage
ON_ERROR = 'skip_file';

select top 10* from claims_data;
```

---

### ✅ 3. Setup DBT Project

#### 🧩 Project Structure

```
models/
├── staging/
│   └── stg_claims.sql
├── marts/
│   ├── agg_claims_kpis.sql
│   ├── monthly_claims_trend.sql
│   ├── denial_rate.sql
│   ├── insurance_outcome_distribution.sql
│   └── high_risk_claims.sql
```

#### 🧬 DBT Commands (CMD Prompt)
```bash
# Create virtual env
python -m venv dbt-venv
dbt-venv\Scripts\activate

# Install packages
pip install dbt-core dbt-snowflake

# Initialize project
dbt init snowflake

# Run models
cd snowflake
dbt debug
dbt run
dbt test
dbt docs generate
dbt docs serve
```

---

### ✅ 4. Connect Tableau to Snowflake

1. Open Tableau Desktop
2. Click **Connect > Snowflake**
3. Enter:
   - Server: `MHGAFHR-DG43637.snowflakecomputing.com`
   - Warehouse: `DWH_WH`
   - Database: `DBT_DB`
   - Schema: `CLAIM`
   - Role: `ACCOUNTADMIN`
   - User: `Aishwariya170998`
4. Drag and drop DBT models like `agg_claims_kpis`, `monthly_claims_trend`, etc.

---

### ✅ 5. Dashboard Design (Suggested Layout)

| Row            | Content                            |
|----------------|-------------------------------------|
| KPI Row        | Total Claims, Paid Amount           |
| Chart Row 1    | Monthly Trend, Paid vs Denied       |
| Chart Row 2    | Claim Status by Insurance, Denial Reasons |
| Chart Row 3    | Follow-up by Reason Code, High-Risk Claims |

Use color palette:
- `#A66EFF` for Denied
- `#4DD0E1` for Paid
- Background: `#121212`

---

## 📷 Dashboard Preview

[🔗 View Tableau Dashboard](https://public.tableau.com/app/profile/aishwariya.alagesan/viz/ClaimsAnalytics_17497746800490/HealthcareClaimsAnalyticsDashboard)

![tableau](https://github.com/user-attachments/assets/912c9b13-6e98-4420-bba1-d2c05822a06d)

---

## 🗃️ Git Workflow (CMD Prompt)

```bash
# Git Init
git init
git add .
git commit -m "Initial commit with DBT + Tableau project"

# Add Remote and Push
git remote add origin https://github.com/yourusername/healthcare-claims-dashboard.git
git branch -M main
git push -u origin main
```

---

## 👤 Author

**Aishwariya A**  
🔗 [LinkedIn](https://www.linkedin.com/in/aishwariya-alagesan)



