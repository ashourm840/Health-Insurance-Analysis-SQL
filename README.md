Health Insurance Claims Analysis (PostgreSQL)

## Project Overview
This project focuses on analyzing a healthcare insurance dataset to extract meaningful business insights. I used advanced SQL techniques to evaluate financial performance, provider efficiency, and patient behavior.

##  Key Features & SQL Techniques Used
* **KPI Dashboard:** Calculated Approval Rates, Total Payouts, and Savings using `FILTER` clauses.
* **Fraud Detection:** Identified frequent claimants using `GROUP BY` and `HAVING`.
* **Provider Analysis:** Analyzed rejection rates per specialty to identify operational bottlenecks.
* **Advanced Ranking:** Implemented `DENSE_RANK()` Window Functions to rank claims by cost within each location.

##  How to Run the Queries
1. Create the table using the schema provided in `insurance_analysis_project.sql`.
2. Import your dataset (CSV).
3. Execute the queries to see the insights.

Dataset details
The project uses a dataset named `enhanced_health_insurance_claims.csv`. It contains:
- Demographics: Age, PatientID.
- Provider Info:Specialty, Location.
- Financials: ClaimAmount, ClaimStatus (Approved/Denied)

-schema
- <img width="1381" height="952" alt="schema" src="https://github.com/user-attachments/assets/11289021-d09a-412c-a48d-5c2887fa9268" />


1. Executive Summary
Below is the output of the KPI query showing total claims and approval rates:
<img width="1498" height="925" alt="kpi_results" src="https://github.com/user-attachments/assets/b194c5e0-2c3c-4087-b648-3160e558f113" />


3. Advanced Ranking
This screenshot shows how we ranked claims by amount within each location:
<img width="1503" height="917" alt="rank_results" src="https://github.com/user-attachments/assets/ac5bee0c-51aa-425a-bcd8-0727e3dafc87" />

