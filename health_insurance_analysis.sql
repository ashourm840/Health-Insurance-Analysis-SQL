Healthcare Insurance Claims Analysis Project
Tools: PostgreSQL (Aggregations, Filtering, Window Functions)
Description: Analyzing medical claims to find financial insights and provider performance.
------------------------------------------------------------------------------------------------
--- create the table on POSTGRESQL then import the csv file  (Database Schema & Data Loading)

CREATE TABLE  enhanced_health_insurance_claims (
		ClaimID  VARCHAR(100) PRIMARY KEY ,   --KEY 
		PatientID VARCHAR(100),
		ProviderID	VARCHAR(100),
		ClaimAmount	DECIMAL(10,2),
		ClaimDate	DATE,
		DiagnosisCode VARCHAR(10),
		ProcedureCode	VARCHAR(10),
		PatientAge	INT,
		PatientGender	VARCHAR(1),   -- M or F
		ProviderSpecialty	VARCHAR(100),
		ClaimStatus	VARCHAR(100),
		PatientIncome	DECIMAL(10,2),
		PatientMaritalStatus VARCHAR(100),	
		PatientEmploymentStatus	VARCHAR(100),
		ProviderLocation	VARCHAR(100),
		ClaimType	VARCHAR(100),
		ClaimSubmissionMethod VARCHAR(100)
)


---Data Exploration (First Look)

SELECT *
FROM enhanced_health_insurance_claims
limit 10;


--- Financial Summary  
SELECT *
FROM enhanced_health_insurance_claims
where ClaimStatus = 'Approved'
order by ClaimAmount desc 
limit 5 ;


---  Financial Summary by Claim Status
SELECT ClaimStatus,
		count(*) as total_claims,
		sum(ClaimAmount) as total_money,
		round(avg(ClaimAmount),2) as average_per_claim
FROM enhanced_health_insurance_claims
group by ClaimStatus ;



---Geographic Analysis
SELECT ProviderLocation,
		sum(ClaimAmount) as total_amount
FROM enhanced_health_insurance_claims
where ClaimStatus = 'Approved'
group by ProviderLocation
order by total_amount desc 
limit 5 ;


---High-Frequency Patient Identification
SELECT  PatientID,
		count(*) as total_num_claims,
		sum(ClaimAmount) as total_cost
FROM enhanced_health_insurance_claims
group by PatientID
order by total_cost desc;


---Demographic Segmentation (Age Groups)
SELECT  
	CASE 
		WHEN PatientAge < 18 THEN 'minor'
		WHEN PatientAge BETWEEN 18 AND 40 THEN 'Adult'
		WHEN PatientAge BETWEEN 41 AND 60 THEN 'Middle Age'
		ELSE 'Senior'
	END AS age_group,
	COUNT(*) AS total_patient,
	ROUND(AVG(ClaimAmount),2) AS avg_cost
FROM enhanced_health_insurance_claims
GROUP BY age_group
ORDER BY avg_cost DESC


---Specialty Rejection  Analysis
SELECT  
	ProviderSpecialty,
	COUNT(*) AS total_claims,
	COUNT(*)  FILTER (WHERE ClaimStatus='Approved') AS claims_Approved ,
	COUNT(*)  FILTER (WHERE ClaimStatus='Denied') AS claims_Denied ,
	ROUND(
		CAST(COUNT(*) FILTER (WHERE ClaimStatus='Denied') AS DECIMAL)
		/COUNT(*) *100 ,2
	) || '%' AS rejection_rate
FROM enhanced_health_insurance_claims
GROUP BY ProviderSpecialty
ORDER BY total_claims DESC;


---Specialty  Savings Analysis
SELECT  
	ProviderSpecialty,
	SUM(ClaimAmount)  FILTER (WHERE ClaimStatus='Approved') AS money_paid ,
	SUM(ClaimAmount)  FILTER (WHERE ClaimStatus='Denied') AS money_saved ,
	ROUND(
		CAST(SUM(ClaimAmount) FILTER (WHERE ClaimStatus='Denied') AS DECIMAL)
		/SUM(ClaimAmount) *100 ,2
	) || '%' AS saving_rate
FROM enhanced_health_insurance_claims
GROUP BY ProviderSpecialty
ORDER BY money_saved DESC;


---  KPIs (Key Performance Indicators)
SELECT  
	 COUNT(*) AS total_claims_processed,
	 COUNT(DISTINCT PatientID) AS unique_patient_served,
	 SUM(ClaimAmount) FILTER (WHERE ClaimStatus = 'Approved') AS total_pay,
	 SUM(ClaimAmount) FILTER (WHERE ClaimStatus = 'Denied') AS total_saving,
	 ROUND(
			CAST(COUNT(*) FILTER (WHERE ClaimStatus = 'Approved') AS DECIMAL)
			/ COUNT(*) * 100 ,2
	 )|| '%' AS approving_rate ,
	 ROUND(AVG(ClaimAmount),2) AS avg_claim_value
FROM enhanced_health_insurance_claims



---Advanced Ranking (Window Functions)
SELECT  
	 PatientID ,
	 ProviderSpecialty,
	 ClaimAmount,
	 ProviderLocation,
	 RANK() OVER(PARTITION BY ProviderLocation ORDER BY ClaimAmount DESC ) AS rank_location
FROM enhanced_health_insurance_claims



---Advanced Ranking (Window Functions)
SELECT  
	 PatientID ,
	 ProviderSpecialty,
	 ClaimAmount,
	 ProviderLocation,
	 DENSE_RANK() OVER(PARTITION BY ProviderLocation ORDER BY ClaimAmount DESC ) AS rank_location
FROM enhanced_health_insurance_claims



---Top Performers using CTEs
WITH ranked_claims AS (
	SELECT  
		 PatientID ,
		 ProviderSpecialty,
		 ClaimAmount,
		 ProviderLocation,
		 DENSE_RANK() OVER(PARTITION BY ProviderLocation ORDER BY ClaimAmount DESC ) AS rank_location
	FROM enhanced_health_insurance_claims 
)
SELECT * 
FROM ranked_claims
WHERE rank_location <=2;


