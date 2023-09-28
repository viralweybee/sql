--1) Create a scalar function that accepts string as a parameter and return whether the string is correct mail Id or not

create function checkMail (@mail as varchar(60))
returns varchar(20)
as
begin
    Return 
    case 
        when @mail like '%@%.%' then 'valid'
        else 'invalid'
    end
end

select dbo.checkMail('abc@mail.com')
-- 2) Create a tabular function that accepts one parameter as employee department and return the employees working in that department.

create function working_department(@val as int)
returns table
as 
return (
select * from employees where DEPARTMENT_ID=@val
)
select * from working_department(80)

-- 3) Create a function that returns the data of employee records based on the page number passed. Parameters required are PageNumber, PageSize (Hint: use Row_Number, Partition by)
	create function page1(@pagenumber as int,@size as int)
	returns table
	as return(
	select * from employees order by employee_id asc offset (@pagenumber-1)*(@size) rows fetch next @size rows only
	)
	select * from employees

	select * from page1(3,10);



--4) Select EmpId, FirstName, LastName, PhoneNumber, Email from Employees’ check the execution plan for the given query and save it. Now, optimize the query and then check the execution plan and save it.

select employee_id[employeeid],FIRST_NAME[firstname],LAST_NAME[lastname],PHONE_NUMBER[contact number],EMAIL[email id] from employees
 create index employee_id1 on employees (employee_id,first_name,last_name,phone_number,email)
--5)Create a stored procedure that prints the employee info in the following format: 'employeename' hired on 'hiredate' has a salary package of 'salarypackage'
--Print only for 10 employees
--Implement it using cursor and then with while loop also



--using cursor
declare @firstname varchar(50)
declare @hiredate varchar(50)
declare @salary int
declare @count int =1;
declare employeecursor cursor for
select FIRST_NAME,HIRE_DATE,salary from employees

open employeecursor
fetch next from employeecursor into @firstname,@hiredate,@salary



while(@@FETCH_STATUS=0 and @count<11)
begin 
print @firstname + ' hired on '+ @hiredate +' has a salary package of '+ cast(@salary as nvarchar(20))
set @count=@count+1
fetch next from employeecursor into @firstname,@hiredate,@salary
end
close employeecursor
deallocate employeecursor 


 --using while loop
 select * from employees
declare @firstname1 varchar(50)
declare @hiredate1 varchar(50)
declare @salary1 int
declare @count1 int =100;
 
while(@count1<111)
begin
select @firstname1=first_name,@hiredate1=HIRE_DATE,@salary1=SALARY from employees where EMPLOYEE_ID=@count1
print @firstname1 + ' hired on '+ @hiredate1 +' has a salary package of '+ cast(@salary1 as nvarchar(20))
set @count1=@count1+1;
end;



