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
