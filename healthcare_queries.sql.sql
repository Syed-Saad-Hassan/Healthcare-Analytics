create database healthcare_db;
use healthcare_db;
select * from patients;

SELECT COUNT(*) AS total_patients
FROM patients;
select * from treatment;
select * from patients;
select * from doctor; 
select * from Lab_test ;
select * from visit;

---- Total Numbers of Patients
SELECT COUNT(*) AS total_patients
FROM patients; 
 
----Average Age of Patients
SELECT ROUND(AVG(age), 0) AS average_age
FROM patients;

---- Most Prescribed Medication
SELECT `Medication Prescribed`,
       COUNT(*) AS prescription_count
FROM treatment
GROUP BY `Medication Prescribed`
ORDER BY prescription_count DESC
LIMIT 5;


--- percentage of abnormal test
SELECT 
    (SUM(CASE WHEN `test result` = 'Abnormal' THEN 1 ELSE 0 END) 
     / COUNT(*) * 100) AS abnormal_percentage
FROM Lab_test;

--- Total Treatment Cost by Type
SELECT `Treatment Type`,
       ROUND(SUM(`Treatment Cost`), 0) AS total_treatment_cost
FROM treatment
GROUP BY `Treatment Type`;


--- Most Common Daignosis
SELECT Diagnosis, COUNT(*) AS Total_Cases
FROM Visit
GROUP BY Diagnosis
ORDER BY Total_Cases DESC
LIMIT 3;

--- Total Revenue
SELECT SUM(Cost) AS Total_Revenue
FROM Treatment;

--- Patient Visit History with Doctor Name
SELECT 
    p.`First Name`,
    d.`Doctor Name`,
    v.`Visit Date`,
    v.`Diagnosis`
FROM patients p
JOIN visit v ON p.`Patient ID` = v.`Patient ID`
JOIN doctor d ON v.`Doctor ID` = d.`Doctor ID`;

---- Doctor Revenue Contribution
SELECT d.`Doctor Name`, SUM(t.Cost) AS Total_Revenue
FROM Treatment t
JOIN Visit v ON t.`Visit ID` = v.`Visit ID`
JOIN Doctor d ON v.`Doctor ID` = d.`Doctor ID`
GROUP BY d.`Doctor Name`
ORDER BY Total_Revenue DESC;

Most Frequent Diagnosis Per Doctor
SELECT `Doctor Name`, Diagnosis, Diagnosis_Count
FROM (
    SELECT 
        d.`Doctor Name`,
        v.Diagnosis,
        COUNT(*) AS Diagnosis_Count,
        ROW_NUMBER() OVER (PARTITION BY d.`Doctor Name` ORDER BY COUNT(*) DESC) AS rn
    FROM Visit v
    JOIN Doctor d ON v.`Doctor ID` = d.`Doctor ID`
    GROUP BY d.`Doctor Name`, v.Diagnosis
) ranked
WHERE rn = 1;


