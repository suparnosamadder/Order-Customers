create database “items_customers_database”;
select* from customers;
select* from items_ordered;
-- From the items_ordered table, select a list of all items purchased for customerid 10449.
-- Display the customerid, item, and price for this customer.
select customerid , item, price 
from items_ordered
where customerid =10449;
-- Select all columns from the items_ordered table for whoever purchased a Tent.
select * from items_ordered
where item ="tent";
-- Select the customerid, order_date, and item values from the items_ordered table for any
-- items in the item column that start with the letter "S".
select customerid, order_date,  item ,price 
from items_ordered
where item like "%s%";
-- Select the distinct items in the items_ordered table. In other words, display a listing of each
-- of the unique items from the items_ordered table.
select distinct item
from items_ordered;
-- Select the maximum price of any item ordered in the items_ordered table. Hint: Select the
-- maximum price only.
select max(price) as highestprice, item
from items_ordered
group by item;
-- Select the average price of all of the items ordered that were purchased in the month of Dec.
alter table items_ordered
add column neworder_date date;
select order_date,left(order_date,10),str_to_date(Left(order_date,10), "%d-%m-%Y"),
str_to_date(order_date,"%d-%m-%Y %H:%i") as neworder_date
from items_ordered;
set sql_safe_updates=0;
update items_ordered
SET neworder_date = Str_To_Date(Left(order_date,10), "%d-%m-%Y");
select  avg(price) as avgprice 
from items_ordered
where month(neworder_date)=12;
-- What are the total number of rows in the items_ordered table?
select count(*) 
from items_ordered;
-- For all of the tents that were ordered in the items_ordered table, what is the price of the lowest
-- tent? Hint: Your query should return the price only.
select min(price)
from items_ordered
where item= "tent";
-- How many people are in each unique state in the customers table? Select the state and display
-- the number of people in each. Hint: count is used to count rows in a column, sum works on
-- numeric data only.

select distinct(state)
from customers;
select count(customerid),state
from customers
group by state;
-- From the items_ordered table, select the item, maximum price, and minimum price for each
-- specific item in the table. Hint: The items will need to be broken up into separate groups.
select max(price) as maxprice ,min(price) as minprice,item
from items_ordered
group by item;
-- How many orders did each customer make? Use the items_ordered table. Select the
-- customerid, number of orders they made, and the sum of their orders.
select customerid,sum(quantity)
from items_ordered
group by customerid;
-- How many people are in each unique state in the customers table that have more than one
-- person in the state? Select the state and display the number of how many people are in each if
-- it's greater than 1.
select count(customerid),state
from customers
group by state
having count(customerid)>1;
-- From the items_ordered table, select the item, maximum price, and minimum price for each
-- specific item in the table. Only display the results if the maximum price for one of the items is
-- greater than 190.00.
select item, max(price) as maxprice, min(price) as minprice
from items_ordered
group by item
having max(price) >190;
-- How many orders did each customer make? Use the items_ordered table. Select the
-- customerid, number of orders they made, and the sum of their orders if they purchased more
-- than 1 item.
SELECT customerid, count(*) as nooforders, Sum(quantity) as TotalQty
FROM items_ordered
Group By customerid
HAVING sum(quantity) > 1;
-- Select the lastname, firstname, and city for all customers in the customers table. Display the
-- results in Ascending Order based on the lastname.
select lastname , firstname,city 
from customers 
order by lastname asc;
-- Select the item and price for all of the items in the items_ordered table that the price is greater
-- than 10.00. Display the results in Ascending order based on the price.
SELECT Item, Price
FROM items_ordered
WHERE price > 10
Order by Price ASC;
-- Select the customerid, order_date, and item from the items_ordered table for all items unless
-- they are 'Snow Shoes' or if they are 'Ear Muffs'. Display the rows as long as they are not either of
-- these two items.
select customerid,order_date,item
from items_ordered
where item NOT IN ("Snow Shoes", "Ear Muffs");
-- Select the item and price of all items that start with the letters 'S', 'P', or 'F'.

-- Select the date, item, and price from the items_ordered table for all of the rows that have a
-- price value ranging from 10.00 to 80.00.
select neworder_date,item , price 
from items_ordered
where price between 10 and 80;
-- Select the firstname, city, and state from the customers table for all of the rows where the state
-- value is either: Arizona, Washington, Oklahoma, Colorado, or Hawaii.
SELECT firstname, City, state
FROM customers
WHERE State in ("Arizona", "Washington", "Oklahoma",
"Colorado", "Hawai");
-- Select the item and per unit price for each item in the items_ordered table. Hint: Divide the
-- price by the quantity.
SELECT item, Sum(Price)/Sum(Quantity) as PricePerUnit
FROM items_ordered
Group By Item;
-- Write a query using a join to determine which items were ordered by each of the customers in
-- the customers table. Select the customerid, firstname, lastname, order_date, item, and price for
-- everything each customer purchased in the items_ordered table.
select  i.customerid, c.firstname, c.lastname, i.order_date, i.item, i.price
from items_ordered i inner join customers c
on i.customerid=c.customerid;
-- repeat excercise however display the results sorted by state in descending order.
select  i.customerid, c.firstname, c.lastname, i.order_date, i.item, i.price,c.state
from items_ordered i inner join customers c
on i.customerid=c.customerid
order by state desc;

