# Health-Insurance-Analysis-SQL
Analyzing medical insurance claims using PostgreSQL to drive financial insights.
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
