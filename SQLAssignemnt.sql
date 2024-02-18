-- Command to create Database
CREATE DATABASE SQLASSIGNMENT;

-- Command to use Database
USE SQLASSIGNMENT;

-- Q1 Given a table of employees, find the number of male and female employees in each department:

-- Command to create table emp
CREATE TABLE emp (
    EmpID INT,
    EName VARCHAR(50),
    Gender VARCHAR(10),
    Department VARCHAR(50)
);

-- Command to add data in the table as per in question
INSERT INTO emp (EmpID, EName, Gender, Department)
VALUES
    (1, 'X', 'Female', 'Finance'),
    (2, 'Y', 'Male', 'IT'),
    (3, 'Z', 'Male', 'HR'),
    (4, 'W', 'Female', 'IT');

-- Solution Query to print output
SELECT Department, 
       SUM(CASE WHEN Gender = 'Male' THEN 1 ELSE 0 END) AS Male_Count,
       SUM(CASE WHEN Gender = 'Female' THEN 1 ELSE 0 END) AS Female_Count
FROM emp
GROUP BY Department
ORDER BY Department;


-- Q2 Given a table with salaries of employees for different month, find the max amount from the rows with month name:

-- Command to create table Salary
CREATE TABLE Salary (
    Name VARCHAR(50),
    Jan INT,
    Feb INT,
    Mar INT
);

-- Command to add data in the table as per in question
INSERT INTO Salary (Name, Jan, Feb, Mar)
VALUES 
    ('X', 5200, 9093, 3832),
    ('Y', 9023, 8942, 4000),
    ('Z', 9834, 8197, 9903),
    ('W', 3244, 4321, 293);
SELECT * FROM Salary;

-- Solution Query to print output
SELECT Name, Value, Month
FROM (
    SELECT 
        Name,
        CASE 
            WHEN Jan >= Feb AND Jan >= Mar THEN 'Jan'
            WHEN Feb >= Jan AND Feb >= Mar THEN 'Feb'
            ELSE 'Mar'
        END AS Month,
        CASE 
            WHEN Jan >= Feb AND Jan >= Mar THEN Jan
            WHEN Feb >= Jan AND Feb >= Mar THEN Feb
            ELSE Mar
        END AS Value
    FROM Salary
) AS MaxSalaries;

-- Q3 Given the marks obtained by candidates in a test, rank them in proper order.

-- Command to create table Marks
CREATE TABLE Marks (
    Candidate_ID INT,
    Marks INT
);

-- Command to add data in the table as per in question
INSERT INTO Marks (Candidate_ID, Marks)
VALUES 
    (1, 98),
    (2, 78),
    (3, 87),
    (4, 98),
    (5, 78);

-- Solution Query to print output
WITH RankedCandidates AS (
    SELECT
        Marks,
        RANK() OVER (ORDER BY Marks DESC) AS Ranking,
        GROUP_CONCAT(Candidate_ID) AS Candidate_ID
    FROM
        Marks
    GROUP BY
        Marks
)
SELECT
    Marks,
    Ranking,
    Candidate_ID
FROM
    RankedCandidates
ORDER BY
    Ranking;


-- Q4 If same value is repeated for different id, then keep the value that has smallest id and delete all the other rows having same value:

-- Command to create table CandidateEmails
CREATE TABLE CandidateEmails (
    Candidate_ID INT,
    Email VARCHAR(255)
);

-- Command to add data in the table as per in question
INSERT INTO CandidateEmails (Candidate_ID, Email)
VALUES 
    (45, 'abc@gmail.com'),
    (23, 'def@yahoo.com'),
    (34, 'abc@gmail.com'),
    (21, 'bcf@gmail.com'),
    (94, 'def@yahoo.com');
 
-- Solution Query to print output   
SELECT 
    Candidate_ID,
    Email
FROM 
    (SELECT 
        Candidate_ID,
        Email
    FROM 
        CandidateEmails
    WHERE 
        (Email, Candidate_ID) IN (
            SELECT 
                Email,
                MIN(Candidate_ID) AS MinCandidateID
            FROM 
                CandidateEmails
            GROUP BY 
                Email
        )
    ) AS UniqueEmails
ORDER BY 
    Candidate_ID DESC;