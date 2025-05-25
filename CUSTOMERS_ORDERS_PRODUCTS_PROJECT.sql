
CREATE DATABASE CUSTOMERS_ORDERS_PRODUCTS;

USE CUSTOMERS_ORDERS_PRODUCTS;

CREATE TABLE CUSTOMERS
(
  CustomerID INT PRIMARY KEY,
  Customer_Name VARCHAR(50),
  Email_id VARCHAR(100)
);

INSERT INTO CUSTOMERS VALUES
 (1, 'John Doe', 'johndoe@example.com'),
 (2, 'Jane Smith', 'janesmith@example.com'),
 (3, 'Robert Johnson', 'robertjohnson@example.com'),
 (4, 'Emily Brown', 'emilybrown@example.com'),
 (5, 'Michael Davis', 'michaeldavis@example.com'),
 (6, 'Sarah Wilson', 'sarahwilson@example.com'),
 (7, 'David Thompson', 'davidthompson@example.com'),
 (8, 'Jessica Lee', 'jessicalee@example.com'),
 (9, 'William Turner', 'williamturner@example.com'),
 (10, 'Olivia Martinez', 'oliviamartinez@example.com')


 CREATE TABLE ORDERS 
 (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductName VARCHAR(50),
  OrderDate DATE,
  Quantity INT
);

 INSERT INTO Orders VALUES
  (1, 1, 'Product A', '2023-07-01', 5),
  (2, 2, 'Product B', '2023-07-02', 3),
  (3, 3, 'Product C', '2023-07-03', 2),
  (4, 4, 'Product A', '2023-07-04', 1),
  (5, 5, 'Product B', '2023-07-05', 4),
  (6, 6, 'Product C', '2023-07-06', 2),
  (7, 7, 'Product A', '2023-07-07', 3),
  (8, 8, 'Product B', '2023-07-08', 2),
  (9, 9, 'Product C', '2023-07-09', 5),
  (10, 10, 'Product A', '2023-07-10', 1)

   
CREATE TABLE PRODUCTS
(
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Price DECIMAL(10, 2)
);

INSERT INTO PRODUCTS VALUES
  (1, 'Product A', 10.99),
  (2, 'Product B', 8.99),
  (3, 'Product C', 5.99),
  (4, 'Product D', 12.99),
  (5, 'Product E', 7.99),
  (6, 'Product F', 6.99),
  (7, 'Product G', 9.99),
  (8, 'Product H', 11.99),
  (9, 'Product I', 14.99),
  (10, 'Product J', 4.99)

   
------TASK 1-------

 SELECT * FROM CUSTOMERS

 SELECT * FROM CUSTOMERS 
   WHERE Customer_Name like 'J%'

   SELECT * FROM CUSTOMERS
   WHERE Email_id  like 'J%'

 SELECT OrderID, ProductName, Quantity FROM ORDERS
 
 SELECT SUM(QUANTITY) AS Total_QUANTITY FROM ORDERS

 SELECT Customer_Name
   FROM CUSTOMERS
   WHERE CustomerID IN (SELECT CustomerID FROM ORDERS)

  SELECT * FROM PRODUCTS
    WHERE Price > 10

 SELECT  Customer_Name , OrderDate FROM CUSTOMERS
   JOIN 
   ORDERS 
   ON CUSTOMERS.CustomerID = ORDERS.CustomerID
     WHERE OrderDate >= '2023-07-05'
  
 SELECT AVG(PRICE) AS AVG_PRICE FROM PRODUCTS

 SELECT  Customer_Name , Quantity FROM CUSTOMERS
   JOIN 
   ORDERS
   ON CUSTOMERS.CustomerID = ORDERS.CustomerID
   ORDER BY Customer_Name

 SELECT ProductName FROM PRODUCTS
  WHERE ProductName  NOT IN (SELECT ProductName FROM ORDERS)

------TASK 2------

 SELECT TOP 5 * FROM orders
   ORDER BY Quantity desc
  

 SELECT avg(price) FROM PRODUCTS

 SELECT Customer_Name AS CUSTOMERS
   FROM CUSTOMERS 
   WHERE CustomerID NOT IN (SELECT CustomerID from ORDERS)



 SELECT OrderID, ProductName, Quantity, Customer_Name FROM ORDERS 
   JOIN CUSTOMERS
   ON CUSTOMERS.CustomerID = ORDERS.CustomerID 
   WHERE  Customer_Name LIKE 'M%'

 SELECT SUM(Quantity * Price) AS TOTAL_REVENUE FROM ORDERS, PRODUCTS


SELECT CUSTOMER_NAME, SUM(QUANTITY * PRICE) AS TOTAL_RENVEUNE FROM  ORDERS, PRODUCTS
 JOIN CUSTOMERS
ON PRODUCTS.PRODUCTID = CUSTOMERS.CUSTOMERID
GROUP BY CUSTOMER_NAME


 SELECT Customer_Name , least (Quantity) as least_quantity  FROM  ORDERS
 join customers
 on orders.customerid = customers.customerid 
 order by quantity


 SELECT * ,LEAD(OrderDate) OVER(ORDER BY CustomerID) ORDERDATE1
   FROM ORDERS
   SELECT * FROM ORDERS

SELECT TOP 3 ProductName , AVG(quantity) AS avg_quantity FROM  ORDERS
GROUP BY ProductName
ORDER BY avg_quantity DESC


 SELECT (AVG(Price) / (SELECT SUM(Quantity) FROM ORDERS) * 100) FROM PRODUCTS
JOIN ORDERS 
ON PRODUCTS.ProductName = ORDERS.ProductName

-----------TASK 3---------------

  SELECT  OrderID, Customer_Name, ProductName FROM ORDERS
    JOIN CUSTOMERS
    ON ORDERS.CustomerID =CUSTOMERS.CustomerID 
 
 SELECT ProductName, Customer_Name FROM ORDERS
    JOIN CUSTOMERS
    ON ORDERS.CustomerID =CUSTOMERS.CustomerID 

  SELECT ORDERDATE , (QUANTITY * PRICE) AS TOTAL_REVENUE FROM ORDERS
 JOIN PRODUCTS
 ON ORDERS.ORDERID = PRODUCTS.PRODUCTID


 SELECT * FROM ORDERS
  where OrderID = (select count(*) from ORDERS) * 50/100

 SELECT  TOP 5 * FROM PRODUCTS
   ORDER BY Price desc
   
 SELECT * ,(SELECT SUM(T2.Quantity)  
FROM ORDERS AS T2
     WHERE T2.CustomerID <= T1.CustomerID
) AS [Running Total]
FROM CUSTOMERS AS T1

 SELECT  TOP 3 * FROM ORDERS
   ORDER BY OrderDate DESC

 SELECT SUM(Quantity * Price) AS TOTAL_REVENUE FROM ORDERS, PRODUCTS
INNER JOIN CUSTOMERS 
ON CUSTOMERS.CustomerID = PRODUCTS.ProductID
WHERE OrderDate >= DATEADD(day,-30,MAX(OrderDate))   
	
	SELECT Customer_Name, ProductName, Quantity FROM ORDERS
 JOIN CUSTOMERS
 ON ORDERS.ORDERID = CUSTOMERS.CUSTOMERID
 WHERE QUANTITY >= 2


 SELECT AVG(Quantity * Price) as AVG_revenue from ORDERS, PRODUCTS
 SELECT CUSTOMERID, AVG(PRICE * QUANTITY) AS AVG_REVENUE FROM ORDERS, PRODUCTS
GROUP BY CUSTOMERID



 SELECT  Customer_Name, OrderID, month(OrderDate) as month from ORDERS
     JOIN CUSTOMERS	 
	 ON CUSTOMERS.CustomerID = ORDERS.CustomerID
    ORDER BY MONTH(OrderDate) 

 select CustomerID, ProductName, "OrderDate",
 ROW_NUMBER() over (partition by CustomerID order by "OrderDate") AS Consecutive_Months
from ORDERS

 select ProductName, count(*) as product_orders, 
count(distinct CustomerID) as num_customers 
from ORDERS 
group by ProductName having count(*) > count(distinct CustomerID);
