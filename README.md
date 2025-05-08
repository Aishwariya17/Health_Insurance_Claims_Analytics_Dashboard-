# 🏥 Claims Data Analytics Pipeline

This project demonstrates an end-to-end data analytics pipeline built using **AWS S3**, **Snowflake**, **DBT**, and **Streamlit** to process, analyze, and visualize healthcare claims data. The goal is to identify trends, denial patterns, and high-risk claims across providers and insurance types.

## 🔧 Technologies Used
- **AWS S3** – For raw data storage
- **Snowflake** – Data warehousing and query processing
- **DBT** – Data transformation and modeling
- **Streamlit** – Dashboarding and interactive visualizations

## 📈 Key Features
- Ingested and processed 5,000+ claims records
- DBT models to compute:
  - Denial Rates by Reason & Provider
  - Payment & Allowed Ratios
  - High-Risk Claim Flags
- Streamlit dashboard includes:
  - KPI metrics (total claims, paid/denied claims)
  - Line chart of monthly claim trends
  - Pie chart for outcomes by insurance type
  - Bar charts for high-risk claims & procedure analysis
  - Filters for insurance type, year, and provider

## 📂 Project Structure
```
├── data/
│   └── raw_claims.csv              # Uploaded to AWS S3
├── dbt/
│   ├── models/
│   │   ├── incremental_claims.sql
│   │   ├── denial_rate.sql
│   │   ├── provider_denial_rate.sql
│   │   ├── high_risk_claims.sql
│   │   └── agg_claims_summary.sql
│   └── dbt_project.yml
├── dashboard/
│   └── streamlit_app.py            # Dashboard code
├── README.md
└── requirements.txt
```

## 🔄 Pipeline Flowchart
```
        +-----------+
        | Raw Data  |
        | (CSV/S3)  |
        +-----+-----+
              |
              v
     +--------+--------+
     | Snowflake Stage |
     +--------+--------+
              |
              v
      +-------+--------+
      |  DBT Transform |
      |  (SQL Models)  |
      +-------+--------+
              |
              v
   +----------+----------+
   | Streamlit Dashboard |
   +---------------------+
```

## 🚀 How to Run

### 1. Upload data to AWS S3:
Upload your CSV to your S3 bucket.

### 2. Set up Snowflake and DBT:
```bash
cd dbt/
dbt run
```

### 3. Run the Streamlit app:
```bash
cd dashboard/
streamlit run streamlit_app.py
```

## 📊 Dashboard Preview
> Interactive filters for claim status, insurance, and provider  
> KPIs + Line charts + Pie charts + High-risk claim visualizations

## 📌 Future Enhancements
- Add anomaly detection on high-risk claims
- Integrate Airflow for orchestration
- Schedule dashboard refresh with caching
