select lower(customerName) as upperCaseCustomerName from customers
select trim('   viral                      devmurari       ') 
SELECT CURRENT_TIMESTAMP;
select getdate()
select row_number() over(order by customername asc) as row#,
customername from customers where customerid<5

select rank() over(order by customername asc) as row#, customername from customers where customerid<5

--scalar value function 
create function add_five(@num as int)
returns int
as 
begin
return (
@num+5
)
end

select dbo.add_five(10);

--table value function 

create function select_qunatity(@quantity as int)
returns table
as 
return 
(
select * from order_details where Quantity=@quantity
)

select * from dbo.select_qunatity(20)


--row number advance sql -- bridge course
select row_number() over(order by customername asc) as row#,
customername from customers where customerid<5

select * from employees


--offset

select employeeid,lastname,firstname from employees order by employeeid desc offset 2 rows fetch next 3 rows only


--types of table
create table #temp_employee(
employeeid int,
jobtitle varchar(100),
salary int)

select * from #temp_employee

insert into #temp_employee values('1001','intern','6000')


--declare table variable
declare @ab table(name varchar(100))
--insert to the table variable

insert into @ab (name) values ('a'),('b');

--select table variable
select * from @ab

select * from employees




--cursor in sql 

select * from order_details

declare @orderid int
declare @quantity int

declare ordercursor cursor for
select orderId,quantity from order_details where orderId<=10270

open ordercursor 
fetch next from ordercursor into @orderid,@quantity

while(@@FETCH_STATUS=0)
begin 
print 'Id = ' +cast(@orderid as nvarchar(20))+' Quantity = '+cast(@quantity as nvarchar(20))
fetch next from ordercursor into @orderid,@quantity
end
close ordercursor
deallocate ordercursor


--while loop in sql
declare @count int =1;
while(@count<=5)
begin
print @count;
set @count=@count+1;
end;

--try catch in sql
create procedure order_details_info
as 
select * from order_details
go

exec order_details_info

create procedure order_details_quantity @quantity int
as
select * from order_details where Quantity=@quantity
go
exec order_details_quantity @quantity=20


declare @val1 int 
declare @val2 int

begin try
set @val1=4;
set @val2=@val1/0;
end try

begin catch
print error_message()
end catch

begin try
select categoryId+categoryName from categories
end try
begin catch
print 'cannot add numberic value with a string value'
end catch



------------------------------date function in sql
select getdate()


select datepart(SECOND,getdate())


select day(getdate())

select datediff(day,getdate(),'2003-05-30')


select dateadd(month,3,getdate())



select convert(varchar,getdate(),101)


select cast(getdate() as date);

select eomonth(getdate())

select datepart(weekday,getdate())
select datename(weekday,getdate())


declare @d datetime=cast(getdate()as datetime);


----------------------------STRING COMPARISION 
select * from categories
select * from categories where categoryname='BEVERAGES';
--case expression 
select categoryname, case when categoryname='Beverages' then 'match' when upper(categoryname) ='BEVERAGES' then 'case insensitive match' else 'no match found' end as [check] from categories


---user defined type
create type dbo.personsType as table (firstname varchar(50) , lastname varchar(50),age int);

create type student from varchar(22) not null;

