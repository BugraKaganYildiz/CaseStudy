-- Primary Keys
ALTER TABLE Customer
   ADD CONSTRAINT PK_Customer_customer_id PRIMARY KEY CLUSTERED (customer_id);
ALTER TABLE Product
   ADD CONSTRAINT PK_Product_product_id PRIMARY KEY CLUSTERED (product_id);
ALTER TABLE Sales_Outlet
   ADD CONSTRAINT PK_Sales_Outlet_sales_outlet_id PRIMARY KEY CLUSTERED (sales_outlet_id);
ALTER TABLE Staff
   ADD CONSTRAINT PK_Staff_staff_id PRIMARY KEY CLUSTERED (staff_id);
ALTER TABLE Generations
   ADD CONSTRAINT PK_Generations_birth_year PRIMARY KEY CLUSTERED (birth_year);
ALTER TABLE Dates
   ADD CONSTRAINT PK_Dates_transaction_date PRIMARY KEY CLUSTERED (transaction_date);


-- Foreign Keys
ALTER TABLE Customer
	ADD CONSTRAINT FK_Customer_Generations_birth_year
	FOREIGN KEY (birth_year) REFERENCES Generations(birth_year);

ALTER TABLE Sales_Targets
	ADD CONSTRAINT FK_Sales_Targets_Sales_Outlet_sales_outlet_id
	FOREIGN KEY (sales_outlet_id) REFERENCES Sales_Outlet(sales_outlet_id);

ALTER TABLE Pastry_Inventory
	ADD CONSTRAINT FK_Pastry_Inventory_Sales_Outlet_sales_outlet_id
	FOREIGN KEY (sales_outlet_id) REFERENCES Sales_Outlet(sales_outlet_id);
ALTER TABLE Pastry_Inventory
	ADD CONSTRAINT FK_Pastry_Inventory_Product_product_id
	FOREIGN KEY (product_id) REFERENCES Product(product_id);
ALTER TABLE Pastry_Inventory
	ADD CONSTRAINT FK_Pastry_Inventory_Dates_transaction_date
	FOREIGN KEY (transaction_date) REFERENCES Dates(transaction_date);

ALTER TABLE Sales_Reciepts
	ADD CONSTRAINT FK_Sales_Reciepts_Product_product_id
	FOREIGN KEY (product_id) REFERENCES Product(product_id);
ALTER TABLE Sales_Reciepts
	ADD CONSTRAINT FK_Sales_Reciepts_Sales_Outlet_sales_outlet_id
	FOREIGN KEY (sales_outlet_id) REFERENCES Sales_Outlet(sales_outlet_id);
ALTER TABLE Sales_Reciepts
	ADD CONSTRAINT FK_Sales_Reciepts_Staff_staff_id
	FOREIGN KEY (staff_id) REFERENCES Staff(staff_id);
ALTER TABLE Sales_Reciepts
	ADD CONSTRAINT FK_Sales_Reciepts_Dates_transaction_date
	FOREIGN KEY (transaction_date) REFERENCES Dates(transaction_date);

ALTER TABLE Sales_Reciepts
	ADD CONSTRAINT FK_Sales_Reciepts_Customer_customer_id
	FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);
--The ALTER TABLE statement conflicted with the FOREIGN KEY constraint "FK_Sales_Reciepts_Customer_customer_id". The conflict occurred in database "ABCCoffeeShop", table "dbo.Customer", column 'customer_id'.
--Customer id values 0, 5000, 8000 in Sales_Reciepts does not exist in Customer table
SELECT DISTINCT [customer_id] FROM [dbo].[Sales_Reciepts]
WHERE [customer_id] NOT IN (
	SELECT [customer_id] FROM customer);