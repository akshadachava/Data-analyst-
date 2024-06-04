-- KPI
select * from hr_analysis.hr_1;
select * from hr_analysis.hr_2;

-- KPI - 1) Average Attrition rate for all Departments

select department, 
avg(
case when attrition = "yes" then 100 else 0 end
) as Attrition_Rate
from hr_analysis.hr_1
group by 1;

-- KPI - 2) Average Hourly rate of Male Research Scientist

select gender, avg(
case when gender = "male" then hourlyrate else null end) as "Average Hourly Rate"
from hr_analysis.hr_1
where jobrole = "Research scientist" group by 1;


-- Attrition rate Vs Monthly income stats

select distinct a.department,
round(avg(b.monthlyincome),2) as average_monthly_income
from hr_1 a
join hr_2 b on a.employeenumber = b.employeeid
where attrition = "yes" group by a.department;


-- Average working years for each Department

select a.department, 
avg(b.TotalWorkingYears) as "Avg_TotalWorkingyears" 
from hr_1 a 
join hr_2 b on a.employeenumber = b.employeeid 
group by a.department;

-- Job Role Vs Work life balance

select a.jobrole, 
b.worklifebalance, 
sum(b.worklifebalance) 
from hr_1 a join hr_2 b on a.employeenumber = b.employeeid
group by 1, 2
order by 2;

-- Attrition rate Vs Year since last promotion relation
select a.attrition, b.yearssincelastpromotion from hr_1 a join hr_2 b where attrition = "yes";

select b.yearssincelastpromotion,
count(a.attrition)  as attrition_count,
count(a.attrition) * 100.0/sum(count(a.attrition)) over () as attrition_rate
from hr_1 a join hr_2 b on a.employeenumber = b.employeeid
where a.attrition = "yes"
group by 1
order by 1;