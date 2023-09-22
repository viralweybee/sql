--create view [customer_details2] as
--select c.customer_id,c.customer_name,c.street_address,o.order_id,o.date_of_purchase,
--o.shopping_cart_id
--from customer c
--left join order_details o on c.customer_id=o.customer_id


select * from [customer_details2];





select * from jobs



-- 3) create a report file third task

	create view [report] as
	select c.customer_id,c.customer_name,s.book_id,o.date_of_purchase,o.shopping_cart_id from customer c inner join order_details o on c.customer_id=o.customer_id inner join shopping_cart s on o.shopping_cart_id=s.shopping_cart_id


	select * from [report];