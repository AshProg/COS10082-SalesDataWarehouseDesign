-- COS10082 Applied Analytics in Business - Assignment 2
-- Student Name: Muhammad Ashrull bin Rahmad
-- Student ID: 102782025
-- Part I: SQL Queries (Question 2 - Question 13)

-- Question 2: [7 Marks] Implement the above database and tables using SQL, create all tables with the appropriate data types (refer to tables when deciding on the data types, and make sure the order is correct).

-- Drop tables if they already exist to avoid errors
DROP TABLE SalesFurniture CASCADE CONSTRAINTS;
DROP TABLE SalesElectronic CASCADE CONSTRAINTS;
DROP TABLE CustomerFurniture CASCADE CONSTRAINTS;
DROP TABLE CustomerElectronic CASCADE CONSTRAINTS;
DROP TABLE ProductFurniture CASCADE CONSTRAINTS;
DROP TABLE ProductElectronic CASCADE CONSTRAINTS;
DROP TABLE Region CASCADE CONSTRAINTS;

-- Create Region table (common to both databases)
CREATE TABLE Region (
    REGIONID NUMBER(2) PRIMARY KEY,
    REGIONNAME VARCHAR2(50) NOT NULL
);

-- Furniture part 

-- Create ProductFurniture table
CREATE TABLE ProductFurniture (
    PRODNO VARCHAR2(10) PRIMARY KEY,
    PRODNAME VARCHAR2(50) NOT NULL,
    PURCHASECOST NUMBER(10,2) NOT NULL
);

-- Create CustomerFurniture table
CREATE TABLE CustomerFurniture (
    CUSTNO NUMBER(10) PRIMARY KEY,
    CUSTNAME VARCHAR2(50) NOT NULL,
    MYIC NUMBER(12) NOT NULL,
    GENDER VARCHAR2(10) NOT NULL,
    REGIONID NUMBER(2) NOT NULL,
    CONSTRAINT fk_custfurn_region FOREIGN KEY (REGIONID) REFERENCES Region(REGIONID)
);

-- Create SalesFurniture table
CREATE TABLE SalesFurniture (
    SALESID NUMBER(10) PRIMARY KEY,
    PRODNO VARCHAR2(10) NOT NULL,
    CUSTNO NUMBER(10) NOT NULL,
    QTY NUMBER(10) NOT NULL,
    SALEPRICE NUMBER(10,2) NOT NULL,
    SALEDATE DATE,
    CONSTRAINT fk_salesfurn_prod FOREIGN KEY (PRODNO) REFERENCES ProductFurniture(PRODNO),
    CONSTRAINT fk_salesfurn_cust FOREIGN KEY (CUSTNO) REFERENCES CustomerFurniture(CUSTNO)
);

-- Electronic part

-- Create ProductElectronic table
CREATE TABLE ProductElectronic (
    PRODNO NUMBER(10) PRIMARY KEY,
    PRODNAME VARCHAR2(50) NOT NULL,
    PURCHASECOST NUMBER(10,2) NOT NULL
);

-- Create CustomerElectronic table
CREATE TABLE CustomerElectronic (
    CUSTNO NUMBER(10) PRIMARY KEY,
    CUSTNAME VARCHAR2(50) NOT NULL,
    MYIC NUMBER(12) NOT NULL,
    GENDER VARCHAR2(10) NOT NULL,
    REGIONID NUMBER(2) NOT NULL,
    CONSTRAINT fk_custelec_region FOREIGN KEY (REGIONID) REFERENCES Region(REGIONID)
);

-- Create SalesElectronic table
CREATE TABLE SalesElectronic (
    SALESID NUMBER(10) PRIMARY KEY,
    PRODNO NUMBER(10) NOT NULL,
    CUSTNO NUMBER(10) NOT NULL,
    QTY NUMBER(10) NOT NULL,
    SALEPRICE NUMBER(10,2) NOT NULL,
    SALEDATE DATE,
    CONSTRAINT fk_saleselec_prod FOREIGN KEY (PRODNO) REFERENCES ProductElectronic(PRODNO),
    CONSTRAINT fk_saleselec_cust FOREIGN KEY (CUSTNO) REFERENCES CustomerElectronic(CUSTNO)
);


-- Question 3: [4 Marks] Insert the data in the above tables to each table created accordingly.

-- Insert data into Region table
INSERT INTO Region(REGIONID, REGIONNAME)
SELECT 1, 'Sarawak' FROM DUAL UNION ALL
SELECT 2, 'Sabah' FROM DUAL UNION ALL
SELECT 3, 'Semenanjung' FROM DUAL;

-- Furniture part

-- Insert data into ProductFurniture table
INSERT INTO ProductFurniture(PRODNO, PRODNAME, PURCHASECOST)
SELECT 'A18', 'Sofa', 35 FROM DUAL UNION ALL
SELECT 'K67', 'Dining table', 15 FROM DUAL;

-- Insert data into CustomerFurniture table
INSERT INTO CustomerFurniture(CUSTNO, CUSTNAME, MYIC, GENDER, REGIONID)
SELECT 11, 'Dave Smith', '870112135245', 'MALE', 1 FROM DUAL UNION ALL
SELECT 22, 'Sue John', '891224135762', 'FEMALE', 1 FROM DUAL UNION ALL
SELECT 33, 'Bobby Brown', '721224135777', 'MALE', 3 FROM DUAL;

-- Insert data into SalesFurniture table
INSERT INTO SalesFurniture(SALESID, PRODNO, CUSTNO, QTY, SALEPRICE, SALEDATE)
SELECT 1, 'A18', 11, 1, 50, TO_DATE('21-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 2, 'K67', 11, 4, 22, TO_DATE('21-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 3, 'K67', 22, 4, 22, TO_DATE('25-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 4, 'A18', 22, 1, 50, TO_DATE('27-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 5, 'K67', 11, 5, 22, NULL FROM DUAL UNION ALL
SELECT 6, 'A18', 22, 9, 50, TO_DATE('04-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 7, 'A18', 33, 6, 50, TO_DATE('05-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 8, 'K67', 11, 2, 22, NULL FROM DUAL;

-- Electronic part

-- Insert data into ProductElectronic table
INSERT INTO ProductElectronic(PRODNO, PRODNAME, PURCHASECOST)
SELECT 23, 'Microwave', 10 FROM DUAL UNION ALL
SELECT 54, 'Water heater', 50 FROM DUAL UNION ALL
SELECT 9, 'Television', 4 FROM DUAL;

-- Insert data into CustomerElectronic table
INSERT INTO CustomerElectronic(CUSTNO, CUSTNAME, MYIC, GENDER, REGIONID)
SELECT 1, 'Dave Smith', '870112135245', 'MALE', 1 FROM DUAL UNION ALL
SELECT 2, 'Sue John', '891224135762', 'FEMALE', 1 FROM DUAL UNION ALL
SELECT 3, 'Emma Goss', '880405135322', 'FEMALE', 2 FROM DUAL;

-- Insert data into SalesElectronic table
INSERT INTO SalesElectronic(SALESID, PRODNO, CUSTNO, QTY, SALEPRICE, SALEDATE)
SELECT 1, 23, 1, 2, 25, TO_DATE('21-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 2, 54, 1, 1, 175, TO_DATE('21-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 3, 9, 2, 10, 12, TO_DATE('22-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 4, 23, 2, 2, 25, TO_DATE('23-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 5, 54, 3, 1, 175, NULL FROM DUAL UNION ALL
SELECT 6, 54, 2, 8, 70, TO_DATE('23-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 7, 9, 3, 6, 12, TO_DATE('23-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 8, 23, 2, 10, 25, TO_DATE('24-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 9, 54, 2, 4, 175, TO_DATE('24-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 10, 23, 1, 10, 25, TO_DATE('25-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 11, 54, 2, 9, 175, TO_DATE('26-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 12, 9, 3, 7, 12, TO_DATE('26-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 13, 23, 1, 7, 25, TO_DATE('26-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 14, 54, 1, 8, 175, TO_DATE('28-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 15, 9, 1, 9, 12, TO_DATE('29-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 16, 23, 2, 8, 25, TO_DATE('30-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 17, 9, 3, 8, 12, TO_DATE('31-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 18, 23, 3, 10, 25, TO_DATE('31-MAY-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 19, 54, 3, 3, 175, TO_DATE('01-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 20, 23, 3, 4, 25, TO_DATE('02-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 21, 9, 2, 3, 12, TO_DATE('03-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 22, 9, 1, 9, 12, TO_DATE('03-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 23, 23, 2, 7, 25, TO_DATE('04-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 24, 9, 1, 7, 12, TO_DATE('04-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 25, 23, 1, 6, 25, TO_DATE('05-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 26, 9, 1, 10, 12, TO_DATE('06-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 27, 23, 1, 9, 25, TO_DATE('07-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 28, 54, 2, 1, 175, TO_DATE('08-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 29, 23, 1, 9, 25, TO_DATE('08-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 30, 23, 3, 4, 25, TO_DATE('09-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 31, 54, 3, 7, 175, TO_DATE('09-JUN-15', 'DD-MON-YY') FROM DUAL UNION ALL
SELECT 32, 23, 1, 9, 25, TO_DATE('10-JUN-15', 'DD-MON-YY') FROM DUAL;

COMMIT;


-- Question 4: [2 Marks] Write a query to display all columns in the SalesElectronic table for all sales that were conducted on or before 26th of May 2015 or those without a specific date. Sort the result in descending sales price order.

SELECT * FROM SalesElectronic
WHERE SALEDATE <= TO_DATE('26-MAY-15', 'DD-MON-YY') OR SALEDATE IS NULL
ORDER BY SALEPRICE DESC;


-- Question 5: [1.5 Marks] For each of the furniture products in the SalesFurniture table, display the product number, quantity and total sales.
-- Note: You need to sort the output by the product number.

SELECT PRODNO AS "Product Number", QTY AS "Quantity", QTY * SALEPRICE AS "Total Sales" FROM SalesFurniture
ORDER BY PRODNO;


-- Question 6: [3 Marks] For each of the electronic products, display the product name and total sales.
-- Note: Sort the output by the Product name.

SELECT p.PRODNAME AS "Product Name", SUM(s.QTY * s.SALEPRICE) AS "Total Sales" FROM ProductElectronic p
JOIN SalesElectronic s ON p.PRODNO = s.PRODNO
GROUP BY p.PRODNAME
ORDER BY p.PRODNAME;


-- Question 7: [5 Marks] Write the SQL statement that would display the following output.
-- Note: Your SQL query must use Union.

SELECT p.PRODNAME AS "Product Name", SUM(s.QTY) AS "Total Quantity" FROM ProductFurniture p
JOIN SalesFurniture s ON p.PRODNO = s.PRODNO
GROUP BY p.PRODNAME

UNION

SELECT p.PRODNAME AS "Product Name", SUM(s.QTY) AS "Total Quantity" FROM ProductElectronic p
JOIN SalesElectronic s ON p.PRODNO = s.PRODNO
GROUP BY p.PRODNAME
ORDER BY "Total Quantity";


-- Question 8: [5 Marks] Write the SQL statement that would display the product name and the gross margin for each product.
-- Gross Margin = Qty * (saleprice – purchasecost)
-- Note: Your SQL query must use Union.

SELECT p.PRODNAME AS "Product Name", SUM(s.QTY * (s.SALEPRICE - p.PURCHASECOST)) AS "Gross Margin" FROM ProductFurniture p
JOIN SalesFurniture s ON p.PRODNO = s.PRODNO
GROUP BY p.PRODNAME

UNION

SELECT p.PRODNAME AS "Product Name", SUM(s.QTY * (s.SALEPRICE - p.PURCHASECOST)) AS "Gross Margin" FROM ProductElectronic p
JOIN SalesElectronic s ON p.PRODNO = s.PRODNO
GROUP BY p.PRODNAME
ORDER BY "Gross Margin" DESC;


-- Question 9: [9 Marks] Modify question 8 so that the output will display the category of each product (i.e. Electronic or furniture) and its ranking based on the gross margin.

WITH DataUnited AS (
    SELECT p.PRODNAME, 'Electronics' AS Category, SUM(s.QTY * (s.SALEPRICE - p.PURCHASECOST)) AS GrossMargin FROM ProductElectronic p
    JOIN SalesElectronic s ON p.PRODNO = s.PRODNO
    GROUP BY p.PRODNAME

    UNION ALL

    SELECT p.PRODNAME, 'Furniture' AS Category, SUM(s.QTY * (s.SALEPRICE - p.PURCHASECOST)) AS GrossMargin FROM ProductFurniture p
    JOIN SalesFurniture s ON p.PRODNO = s.PRODNO
    GROUP BY p.PRODNAME
)

SELECT PRODNAME AS "Product Name", Category, GrossMargin AS "Gross Margin", RANK() OVER (PARTITION BY Category ORDER BY GrossMargin DESC) AS "Ranking by Profitability" FROM DataUnited
ORDER BY GrossMargin DESC;


-- Question 10: [8.5 Marks] Using Rollup & Cube, write the two SQL statements that would display the following:

-- Output 1: Using ROLLUP
SELECT c.CUSTNAME AS "Customer Name", p.PRODNAME AS "Product Name", SUM(s.QTY) AS "Quantity Sold" FROM CustomerElectronic c
JOIN SalesElectronic s ON c.CUSTNO = s.CUSTNO
JOIN ProductElectronic p ON s.PRODNO = p.PRODNO
GROUP BY CUBE(c.CUSTNAME, p.PRODNAME)
ORDER BY UPPER(c.CUSTNAME) DESC NULLS FIRST, p.PRODNAME NULLS FIRST;

-- Output 2: Using CUBE
WITH Temp_data AS (
  SELECT c.CUSTNAME AS "Customer Name", p.PRODNAME AS "Product Name", SUM(s.QTY) AS "Quantity Sold" FROM CustomerElectronic c
  JOIN SalesElectronic s ON c.CUSTNO = s.CUSTNO
  JOIN ProductElectronic p ON s.PRODNO = p.PRODNO
  GROUP BY ROLLUP(c.CUSTNAME, p.PRODNAME)
  HAVING c.CUSTNAME IS NOT NULL OR p.PRODNAME IS NOT NULL OR (c.CUSTNAME IS NULL AND p.PRODNAME IS NULL)
)
SELECT "Customer Name", "Product Name", "Quantity Sold" FROM Temp_data
ORDER BY CASE WHEN "Customer Name" IS NULL AND "Product Name" IS NOT NULL THEN 0 
              WHEN "Customer Name" IS NOT NULL AND "Product Name" IS NULL THEN 2
              ELSE 1 END, "Product Name",
         CASE WHEN "Product Name" = 'Microwave' THEN "Quantity Sold" END DESC,
         CASE WHEN "Product Name" = 'Television' THEN CASE WHEN "Customer Name" = 'Sue John' THEN 0 ELSE 1 END 
         END,
         CASE WHEN "Product Name" = 'Television' THEN "Customer Name" END ASC,
         UPPER("Customer Name") DESC NULLS LAST, "Product Name" NULLS LAST;



-- Question 11: [4 Marks] Write a query to find the top 2 most valuable electronic products sold, along with the total revenue and the number of distinct customers who bought each product.
-- Note: Only include sales where the sale data is not empty.

SELECT * FROM (
    SELECT p.PRODNO, p.PRODNAME, SUM(s.QTY * s.SALEPRICE) AS "TOTAL REVENUE", COUNT(DISTINCT s.CUSTNO) AS "CUSTOMER COUNT" FROM ProductElectronic p
    JOIN SalesElectronic s ON p.PRODNO = s.PRODNO
    WHERE s.SALEDATE IS NOT NULL
    GROUP BY p.PRODNO, p.PRODNAME
    ORDER BY "TOTAL REVENUE" DESC
)

WHERE ROWNUM <= 2;


-- Question 12: [2 Marks] Based on the tables created above, write any SQL statement that would produce a foreign key constraint violation. Explain why the error occurs.

INSERT INTO SalesElectronic(SALESID, PRODNO, CUSTNO, QTY, SALEPRICE, SALEDATE)
SELECT 99, 100, 99, 1, 25, TO_DATE('15-JUN-15', 'DD-MON-YY') FROM DUAL;

-- EXPLANATION:
-- Foreign key in simple term is like a connector between two tables. This statement below will actually cause a foreign key constraint violation since if you can see when inserting the value into the table, for the column 'CUSTNO', there is no corresponding value '99' if you check it on 'CustomerElectronic' table. 'CustomerElectronic' table only contain 'CUSTNO' of 1, 2 and 3. This is why there will be foreign key constraint violation here.


-- Question 13: [3 Marks] Write the SQL statement to alter the Sales-related tables to enforce having a sales date value for each row.

-- First, update any NULL SALEDATE values in SalesFurniture table
UPDATE SalesFurniture
SET SALEDATE = TO_DATE('20-AUGUST-15', 'DD-MON-YY')
WHERE SALEDATE IS NULL;

-- First, update any NULL SALEDATE values in SalesElectronic table
UPDATE SalesElectronic
SET SALEDATE = TO_DATE('20-AUGUST-15', 'DD-MON-YY')
WHERE SALEDATE IS NULL;

-- Alter SalesFurniture table to make SALEDATE column NOT NULL
ALTER TABLE SalesFurniture
MODIFY SALEDATE DATE NOT NULL;
SELECT * FROM SalesFurniture;

-- Alter SalesElectronic table to make SALEDATE column NOT NULL
ALTER TABLE SalesElectronic
MODIFY SALEDATE DATE NOT NULL;
SELECT * FROM SalesElectronic;