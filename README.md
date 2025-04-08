# MSSQL
 Repository for doing SQL Server hands-on excercises
 ---------------------------------------------------
 SQL:


correlated subquery and a nested subquery:

Correlated Subquery
A correlated subquery depends on values from the outer query.
The subquery is executed once for every row processed by the outer query.

Example:

SELECT e.EmployeeID, e.Name
FROM Employees e
WHERE e.Salary > (
    SELECT AVG(Salary)
    FROM Employees d
    WHERE d.DepartmentID = e.DepartmentID
);
The subquery runs repeatedly for each row in the Employees table because it depends on the DepartmentID from the outer query.

Nested Subquery
A nested subquery is independent of the outer query.
The subquery is executed once, and the result is used by the outer query.
SELECT EmployeeID, Name
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

What are the subsets of SQL?

Data definition language (DDL):  CREATE, ALTER, DROP,Truncate
Data manipulation language (DML): SELECT, UPDATE, INSERT,DELETE
Data control language (DCL): GRANT and REVOKE.

 Grant : It enables system administrators to assign privileges and roles to the specific user accounts
REVOKE: It enables system administrators to revoke privileges and roles from the user accounts 

Transaction Control Language (TCL) : ROLLBACK, SET TRANSACTION, SAVEPOINT


primary key 

uniquely identify each record in the table.
cannot be null or empty.


foreign key

used to link one or more tables together.
It means a foreign key field in one table refers to the primary key field of the other table.

A foreign key can have NULL values, as long as the column allows NULL values (i.e., it is not defined with NOT NULL constraint)

unique key

Uniquely identify each record in the table.
It can accept a null value but only one null value per column. 


composite primary key

A primary key that uses multiple columns to identify a row in a database.


VIEW 

It is a virtual table that contains a subset of data within a table. 
It looks like an actual table containing rows and columns, but it takes less space because it is not present physically. 

A view is considered updatable if ,
The view is based on a single table.
It does not use aggregate functions (SUM, COUNT, etc.).
It does not include DISTINCT, GROUP BY, or UNION.
It does not include subqueries or joins that are ambiguous.

Index:
It is used to increase the performance and allow faster retrieval of records from the table. 

Clustered Index:

Determines the physical order of data in the table.
A table can have only one clustered index because data can be sorted in only one way.
Example: Primary keys usually create a clustered index automatically.

Non-Clustered Index:
It creates a separate structure to store references to the data.
A table can have multiple non-clustered indexes.



JOINS

INNER JOIN : Combines rows from two tables where there is a matching value in both tables.
 LEFT JOIN : Returns all rows from the left table and matching rows from the right table.If there is no match, NULL values are returned for columns of the right table.
RIGHT JOIN :
FULL  JOIN :Returns all rows when there is a match in either table. Rows without a match in one table will have NULL values for the other table's columns.
CROSS JOIN :Produces a Cartesian product of the two tables, combining every row from the first table with every row from the second table.It does not require an ON clause.
SELF JOIN :


TRIGGER
A trigger in SQL is a special type of stored procedure that automatically runs when a specified event (such as an INSERT, UPDATE, or DELETE) occurs on a table or view.
CREATE TRIGGER trigger_name
AFTER INSERT ON table_name
FOR EACH ROW
BEGIN
    -- trigger actions
END;


ALTER TRIGGER [dbo].[tgr_AuditSchedules] ON [dbo].[schedules]
FOR INSERT
	,UPDATE
AS


Uses:
- Auditing and Logging
-Used for updating related tables.


UNION :
Combines the results of two or more SELECT queries and removes duplicate rows from the final result set.

UNION ALL:

 Combines the results of two or more SELECT queries and includes duplicates 
UNION ALL is generally faster than UNION because it doesn't require the database to check and remove duplicate rows.



IN operator:  Used to find a specific value that exists within a set of values.

BETWEEN  operator:  used to select the range of data between two values. 




Constraints:

Constraints are the  set of rules for  managing the structure and data of a database.

maintaining the accuracy and quality of data

Primary Key ensures uniqueness and no null values.
Foreign Key maintains relationships between tables.
Unique ensures no duplicates in a column.
Check validates that data meets specific conditions.
Not Null ensures a column can't have empty values.
Default sets automatic values for missing data.
Index improves performance for searching data.



Write the SQL query to get the third maximum salary of an employee from a table named employees.

SELECT TOP 1 salary   
FROM   
    (SELECT DISTINCT TOP 3 salary   
     FROM employees   
     ORDER BY salary DESC) AS Temp   
ORDER BY salary ASC;  






DELETE and TRUNCATE  and DROP

DELETE 
Delete statement removes single or multiple rows from an existing table depending on the specified condition.
DELETE statements don’t reset identity columns.



TRUNCATE : 

Deletes the whole contents of an existing table without the table itself.
 It preserves the table structure or schema
DELETE statements reset identity columns.

DROP : 

Deletes the entire table or database
Removes table and data completely.




Common Table Expressions (CTEs) :
 temporary result set defined within the execution scope of a SELECT, INSERT, UPDATE, or DELETE statement.
defined using the WITH keyword
CTEs only exist for the duration of the query.
Not stored; exists in memory during execution.

EG : Find the top 3 employees with the highest salary.
WITH SalaryCTE AS (
    SELECT EmployeeName, Salary, ROW_NUMBER() OVER (ORDER BY Salary DESC) AS RowNum
    FROM Employees
)
SELECT EmployeeName, Salary
FROM SalaryCTE
WHERE RowNum <= 3;

Temp Table:

A temporary table is used to store the data temporarily during a session or transaction. 
It exists only for the duration of the session or until it is explicitly dropped.

Stored in tempdb (temporary storage).

Local Temporary Table: Prefixed with # (e.g., #TempTable), visible only to the session that created it.
Global Temporary Table: Prefixed with ## (e.g., ##TempTable), visible to all sessions but dropped when the last session ends.













Aggregate Functions
It is a function that performs a calculation on a set of values, and returns a single value.
used with the GROUP BY clause
MIN() - returns the smallest value within the selected column
MAX() - returns the largest value within the selected column
COUNT() - returns the number of rows in a set
SUM() - returns the total sum of a numerical column
AVG() - returns the average value of a numerical column

SELECT Name, SUM(Salary) AS TotalSalary
FROM Employee
GROUP BY Name
HAVING SUM(Salary) > 600

















Normalization 


 used to organize data in a database to reduce redundancy and improve data integrity. 
It involves dividing a database into tables and establishing relationships between them.

1. First Normal Form (1NF)

Each column contains only atomic (indivisible) values.
Each column contains values of a single type.
Each row is unique (using a primary key).


Example:



Note:

Here, StudentID alone cannot be the primary key because it repeats for the same student who is enrolled in multiple subjects. To uniquely identify each row, we need to use a composite primary key.

composite primary key
It is a combination of two or more columns that together uniquely identify each row. 
Primary Key: (StudentID, Subject)


2. Second Normal Form (2NF) 

It is already in 1NF.
All columns should fully dependent on the primary key column (no partial dependency)
Example:






3. Third Normal Form (3NF)

It is in 2NF.
No transitive dependency exists.

Example:


Primary Key: (StudentID, Subject)
Transitive Dependency: InstructorPhone depends on Instructor, which in turn depends on the primary key (StudentID, Subject).
This violates 3NF because  InstructorPhone is indirectly dependent on the primary key.

4. Boyce-Codd Normal Form (BCNF):

It is in 3NF.
For every functional dependency, the determinant must be a candidate key.  If (X → Y),then  X must be a candidate key.


What is a Candidate Key?
A candidate key is a column or a combination of columns that can uniquely identify each row in a table. It is a potential primary key, meaning:
It uniquely identifies rows.
It has no redundant attributes 


FIX : we decompose it into two tables: 

CourseID | Instructor

Instructor | Department

4NF - Remove multi-valued dependencies.

5 NF - Eliminate join dependencies.







Window functions like ROW_NUMBER(), RANK(), and PARTITION BY.


1. Stored Procedures
A stored procedure is a precompiled collection of SQL statements 
2. Functions
It is a database object that performs a specific task and returns a single value or a table. 
It is used to perform calculations or to transform data.

Scalar Functions:
Return a single value (e.g., integer, string, or date).
Accept parameters as input.
Cannot modify database data.
—----------------------------------------------------------------------------
CREATE FUNCTION GetStudentName (@StudentID INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @Name VARCHAR(100);
    SELECT @Name = Name FROM Students WHERE StudentID = @StudentID;
    RETURN @Name;
END;
—-----------------------------------------------------------------------------------------------

Table-Valued Functions:
Return a table as output.
Useful for generating derived tables in queries.

—------------------------------------------------------------------------------------------
CREATE FUNCTION GetStudentsByCourse (@CourseID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT StudentID, Name FROM Students WHERE CourseID = @CourseID
);
—-----------------------------------------------------------------------------------------------


ACID Properties in Database Management Systems
Key properties of a reliable database transaction
1. Atomicity
Ensures that partial transactions do not occur.
Example: Consider a bank transfer:
Deduct $100 from Account A.
Add $100 to Account B.
If the deduction succeeds but the addition fails, Atomicity ensures that the entire transaction is rolled back.
Key Rule: All-or-nothing execution.

2.Consistency
Guarantees that a transaction leaves the database in a valid state.
 Example:
In a bank transfer, if  100 is deducted from one account, it must be added to another account to maintain the rule that the total balance in the system remains unchanged.

3. Isolation
Transactions are independent of each other.
Prevents dirty reads, phantom reads
Example: Two users try to book the last seat in a theater at the same time. Isolation ensures that only one user succeeds, and the other transaction is processed based on the updated state.

4. Durability
Once a transaction is committed, its changes are permanent, even in the case of a system crash or power failure.

Example: After a successful bank transfer, the updated balances in both accounts are permanently saved. Even if the system crashes immediately after the transaction, the changes remain intact.

BEGIN TRANSACTION, COMMIT, and ROLLBACK in SQL



BEGIN TRANSACTION : Start a transaction.
COMMIT : Finalize and save changes permanently.
ROLLBACK : Undo all changes in the transaction.
TRY - CATCH




ERROR_NUMBER(): Returns the error number.
ERROR_MESSAGE(): Returns the error description.
ERROR_SEVERITY(): Returns the severity level of the error.
ERROR_STATE(): Returns the error state.
ERROR_LINE(): Returns the line number where the error occurred.
ERROR_PROCEDURE(): Returns the procedure name where the error occurred.

DEadLock:

A deadlock occurs when two or more transactions block each other from continuing.

How Deadlocks Happen:
Transaction A locks Resource X and requests Resource Y.
Transaction B locks Resource Y and requests Resource X.
Both transactions wait for the other to release the lock, causing a deadlock.
SQL Server automatically detects deadlocks.
It selects one transaction as the deadlock victim and terminates it to break the deadlock.

Query Optimization

Avoid SELECT *
Use filters before joining tables with subqueries or CTEs.
Use Temporary Tables or Common Table Expressions (CTEs)


Cursors in SQL
A cursor acts as a pointer to a specific row in a query result set.
It allows controlled row-by-row processing.

Use Cases:
When complex row-by-row operations are required.
Performing updates or calculations for each row of a query.
Types of Cursors:
Implicit Cursor: Automatically created by SQL for single DML operations (e.g., INSERT, UPDATE).
Explicit Cursor: Defined explicitly by the programmer for more control over query execution.

Cursor Lifecycle:  Declare: Open: Fetch: Process: Close: Deallocate: 



