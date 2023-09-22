--1. Given SQL query will execute successfully: TRUE/FALSE SELECT last_name, job_id, salary AS Sal FROM employees;

--yes execute scuessfully
	select * from employees

--2. Identity errors in the following statement: SELECT employee_id, last_name, sal*12 ANNUAL SALARY FROM employees;
--error in a sal*12 => incorret column name 

--3. Write a query to determine the structure of the table 'DEPARTMENTS'
sp_help departments

--4. Write a query to determine the unique Job IDs from the EMPLOYEES table.
select distinct job_id from employees

--5. Write a query to display the employee number, lastname, salary (oldsalary), salary increased by 15.5% name it has NewSalary and subtract the (NewSalary from OldSalary) name the column as Increment.
select employee_id,last_name,salary as oldsalary ,salary+(salary*15.5/100) as newsalary,salary*15.5/100 as increment from employees

--6. Write a query to display the minimum, maximum, sum and average salary for each job type.
select min(salary),max(salary),sum(salary),avg(salary) from employees

--7. The HR department needs to find the names and hire dates of all employees who were hired before their managers, along with their managers’ names and hire dates.
select first_name ,hire_date from employees where hire_date <=  ( select max(hire_date) from employees where job_id='SA_MAN' ) --pending

--8. Create a report for the HR department that displays employee last names, department numbers, and all the employees who work in the same department as a given employee.
select e.last_name,d.DEPARTMENT_NAME,e.EMPLOYEE_ID from employees e inner join DEPARTMENTS d on e.DEPARTMENT_ID=d.DEPARTMENT_ID

--9. Find the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number.
select Round(max(salary),0) as Maximum, Round(min(salary),0) as Minimum, Round(sum(salary),0) as sum ,Round(avg(salary),0)as average from employees

--10. Create a report that displays list of employees whose salary is more than the salary of any employee from department 60.
--create view [salary more than department 60_1] as
--select * from employees where salary > any (select salary from employees where department_id='60')

select * from [salary more than department 60_1]

--11. Create a report that displays last name and salary of every employee who reports to King(Use any manager name instead of King).
select last_name ,salary from employees where manager_id = any (select employee_id from employees where last_name='king')

--12. Write a query to display the list of department IDs for departments that do not contain the job Id ST_CLERK(Add this job ST_CLERK to Job table). Use SET Operator for this query
	select distinct department_id from employees where DEPARTMENT_ID in  (select DEPARTMENT_ID from employees where job_id !='ST_CLERK')
	except (select distinct department_id from employees where job_id='ST_CLERK');
--	SELECT DISTINCT department_id
--FROM employees
--WHERE department_id NOT IN (
--  SELECT DISTINCT department_id
--  FROM employees
--  WHERE job_id = 'ST_CLERK'
--)
--UNION
--SELECT DISTINCT department_id
--FROM employees
--WHERE department_id IS NULL;

	
--13. Write a query to display the list of employees who work in department 50 and 80. Show employee Id, job Id and department Id by using set operators. - Add 50 and 80 department Id to department table
select employee_id,job_id,department_id from employees where department_id='50' 
union 
select employee_id,job_id,department_id from employees where department_id='80'