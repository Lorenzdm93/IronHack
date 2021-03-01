use dummy1;
-- Write a query to print the ID, FIRST_NAME, and LAST_NAMEs of 
-- the customers whose combined name length, i.e., the sum of the 
-- length of the FIRST_NAME and LAST_NAME, is less than 12. 
-- The IDs and names should be printed in the ascending order of the combined name length. 
-- If two or more customers have the same combined name length, sort the result in lexicographical 
-- order of the full names, ignoring case. If two or more customers have the same full name, sort those results by ID, ascending.

select *, length(FIRST_NAME) + length(LAST_NAME) as combined 
from customer
where length(FIRST_NAME) + length(LAST_NAME) < 12
order by combined, first_name, last_name, ID;

-- Given two tables, Employee and Department, generate a summary of how many employees are in each department. 
-- Each department should be listed, whether they currently have any employees or not. 
-- The results should be sorted from high to low by number of employees, and then alphabetically 
-- by department when departments have the same number of employees. The results should list the department 
-- name followed by the employee count. The column names are not tested, so use whatever is appropriate.
select * from department;
select * from employee;

select *, count(e.name) from department as d
left join employee as e
on d.id = e.dept_id
group by d.name;

-- There are two data tables with employee information: EMPLOYEE2 and EMPLOYEE2_UIN. 
-- Query the tables to generate a list of all employees who are less than 25 years old first in order of NAME, 
-- then of ID, both ascending.  The result should include the UIN followed by the NAME.  
select * from employee2;
select * from employee2_uin;

select e.id, uin, e.name, e.age from employee2_uin as u
left join employee2 as e
on u.id = e.id
where age < 25
order by e.name, e.id;

-- A company maintains an EMPLOYEE3 table with information for each of their employees. 
-- Write a query to produce a list containing two columns.  The first column should include the name 
-- of an employee who earns less than some other employee.  The second column should contain the name 
-- of a higher earning employee. All combinations of lesser and greater earning employees should be included.  
-- Sort ascending, first by the lower earning employee's ID, then by the higher earning employee's SALARY.  

select a.name, a.salary, b.name, b.salary 
from employee3 as a
join employee3 as b
on a.id <> b.id and a.salary < b.salary
order by a.salary, b.salary;

