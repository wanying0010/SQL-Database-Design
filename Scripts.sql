```sql
CREATE TABLE customers(
customer_ID DECIMAL(10) NOT NULL,
membership_ID DECIMAL(15) NOT NULL,
customer_first VARCHAR(30),
customer_last VARCHAR(40),
customer_email VARCHAR(80),
stree_address VARCHAR(200),
city VARCHAR(50),
state VARCHAR(10),
zip_code DECIMAL(20),
phone_number DECIMAL(20),
PRIMARY KEY (customer_ID),
POREIGN KEY (membership_ID) REFERENCES memberships);

INSERT INTO customers VALUES
(1,2,'Amy','Lee','amyLee@gmail.com','63 Buicker Streest','Boston','MA',02216,6174582093);
INSERT INTO customers VALUES
(2,1,'Andrew','Williams','williams@gmail.com','25 New London Streer','Newark','DE',19711,3025746890);

ALTER TABLE customers
ADD status VARCHAR(25);

UPDATE customers 
SET status = 'Renewal' WHERE customer_id = 1;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 2;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 3;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 4;
UPDATE customers 
SET status = 'Active' WHERE customer_id = 5;


```
