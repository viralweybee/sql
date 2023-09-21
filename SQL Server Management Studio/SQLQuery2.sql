select orders.orderid, employees.LastName, employees.FirstName
from orders
right join employees on orders.EmployeeID=employees.EmployeeID
order by orders.OrderID

select count(customerid), country
from customers 
group by country;

select count(customerid),country
from customers
group by country 
order by count(customerid) desc;

select * into customersbackup2017
from customers;

select * from customersbackup2017
drop table customersbackup2017