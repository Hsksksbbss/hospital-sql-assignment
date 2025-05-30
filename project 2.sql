drop table hospital;
create table hospital(
  hospital_name varchar(50),
  location varchar(50),
  department varchar(50),
  doctor_count int,
  patient_count int,
  admission_date date,
  discharge_date date,
  medical_expenses numeric(10,2)
);
copy
hospital from
'D:\downloads 2\Hospital_Data.csv'
csv header;
select * from hospital;

--1.Total Number of Patients

select sum(patient_count) as total_patient from hospital;




--2.Average Number of Doctors per Hospital
select  distinct hospital_name,avg(doctor_count) as average_dortor from hospital
group by hospital_name;

--3.Top 3 Departments with the Highest Number of Patients
select department,sum(patient_count) as Total_patient from hospital group by department
order by Total_patient desc limit 3;

--4.Hospital with the Maximum Medical Expenses

SELECT hospital_name, SUM(medical_expenses) AS total_expenses
FROM hospital
GROUP BY hospital_name
ORDER BY total_expenses DESC
LIMIT 1;

--5.Daily Average Medical Expenses
select  distinct hospital_name,discharge_date-admission_date as duration_of_staying,
(medical_expenses/ nullif (discharge_date-admission_date,0)) as per_day_expenses
 from hospital;
--6.Longest Hospital Stay
select hospital_name ,discharge_date-admission_date as duration_of_staying
from hospital order by duration_of_staying desc limit 1;

--7.Total Patients Treated Per City
select  location ,sum(patient_count) as total_patient
from  hospital group by location;

--8.Average Length of Stay Per Department
select  distinct department, (patient_count/ nullif (discharge_date-admission_date,0)) as  stay_per_dep from
hospital group by department;

SELECT 
    department, 
    AVG(DATEDIFF(STR_TO_DATE(discharge_date, '%m-%d-%Y'), STR_TO_DATE(addmision_date, '%m-%d-%Y'))) AS Avg_Stay_Days
FROM hospital
GROUP BY department;


--9.Identify the Department with the Lowest Number of Patients

SELECT department, SUM(patient_count) AS TotalPatients
FROM hospital
GROUP BY department
ORDER BY TotalPatients ASC
LIMIT 1;

--10.Monthly Medical Expenses Report
SELECT 
    EXTRACT(MONTH FROM admission_date) AS month,
    SUM(medical_expenses) AS total_medical_expenses 
FROM hospital
GROUP BY EXTRACT(MONTH FROM admission_date)
ORDER BY month;













