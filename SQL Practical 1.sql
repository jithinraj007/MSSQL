-- USE NestTrainee
-- Create tables
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    DepartmentID INT,
    Salary INT,
    HireDate DATE
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- Insert sample data
INSERT INTO Departments VALUES (1, 'HR'), (2, 'IT'), (3, 'Sales');

INSERT INTO Employees VALUES 
(1, 'John', 1, 40000, '2021-05-01'),
(2, 'Jane', 2, 60000, '2020-01-10'),
(3, 'Alice', 2, 70000, '2019-11-20'),
(4, 'Bob', 3, 50000, '2022-02-15'),
(5, 'Charlie', 1, 42000, '2023-03-05');
-----------------------------------------------------------------------------------------------------
--2. JOINs
--List all employees with their department names.
select * from Employees
select * from Departments

select e.Name ,d.DepartmentName
from employees e join Departments d 
on e.DepartmentID=d.DepartmentID

--Show employees who don’t belong to any department (use LEFT JOIN).

select e.Name ,d.DepartmentName
from Employees e  left join Departments d 
on e.DepartmentID=d.DepartmentID
where d.DepartmentID is null
 
--3. GROUP BY + Aggregate
--Count of employees in each department.

SELECT d.DepartmentName, Count(*) as 'Employee Count' 
from employees e
join Departments d 
on e.DepartmentID=d.DepartmentID 
group by d.DepartmentName


--Average salary per department.

select AVG(Salary),d.DepartmentName
FROM Employees e
JOIN Departments d
on e.DepartmentID=d.DepartmentID 
group by d.DepartmentName


--4. Subqueries
--Get the employee(s) with the highest salary.
select top 1  Name,Salary 
from Employees 
order by Salary desc

SELECT Name, Salary
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);


--Get all employees whose salary is above the department average.

SELECT Name, Salary
FROM Employees e
JOIN Departments d on e.DepartmentID=d.DepartmentID 
WHERE e.Salary > (SELECT AVG(Salary) FROM Employees group by DepartmentID);

(select AVG(Salary) salary,d.DepartmentName
FROM Employees e
JOIN Departments d
on e.DepartmentID=d.DepartmentID 
group by d.DepartmentName)

SELECT e.Name, e.Salary, e.DepartmentID
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(e2.Salary)
    FROM Employees e2
    WHERE e2.DepartmentID = e.DepartmentID
);

--5. Window Functions
--Rank employees based on salary (use RANK()).

select name, salary, rank() over(order by salary) rank
from Employees

--Show running total of salaries ordered by HireDate.

--6. Common Table Expressions (CTE)
--Write a CTE to get employees with salary > 45000, and then get count from that result.
;with cte as(
select * from employees where salary < 45000)
select count(*) from cte
--7. Stored Procedure
--Write a stored procedure that accepts a department ID and returns all employees in that department.

--8. Indexing
--Create an index on the Salary column.

--Check execution time of a query before and after index (use SET STATISTICS TIME ON).

--9. Transactions
--Write a transaction that inserts a new employee and updates department name. Include rollback on error.

begin tran
declare @onerror int;
begin try
insert into employees(empid,name, salary, DepartmentID)
values(7,'sumesh', 90000, 3)
end try
begin catch
set @onerror = 1;
print('error')
rollback tran
end catch
if @onerror <>1
begin
commit tran
end



--10. Constraints
--Add a constraint so that Salary cannot be negative.

--Try inserting a row violating that constraint.