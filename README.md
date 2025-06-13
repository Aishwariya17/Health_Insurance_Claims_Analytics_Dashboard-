
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
-- Create stage
CREATE OR REPLACE STAGE s3_stage
URL='s3://claims-data-bucket'
STORAGE_INTEGRATION = your_aws_integration;

-- Create table
CREATE OR REPLACE TABLE raw_claims (
    claim_id STRING, provider_id BIGINT, patient_id BIGINT,
    date_of_service STRING, billed_amount FLOAT,
    procedure_code STRING, diagnosis_code STRING,
    allowed_amount FLOAT, paid_amount FLOAT,
    insurance_type STRING, claim_status STRING,
    reason_code STRING, follow_up_required STRING,
    ar_status STRING, outcome STRING
);

-- Load data
COPY INTO raw_claims
FROM @s3_stage/claims_data.csv
FILE_FORMAT = (TYPE = CSV FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
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



