use ECommerce;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);


CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    description VARCHAR(MAX) NOT NULL,
    StockQuantity INT NOT NULL
);


CREATE TABLE Cart (
    cart_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    shipping_address VARCHAR(MAX) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);


CREATE TABLE Order_items (
    order_item_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO products (product_id, name, description, price, stockQuantity) 
VALUES 
(1, 'Laptop', 'High-performance laptop', 800.00, 10),
(2, 'Smartphone', 'Latest smartphone', 600.00, 15),
(3, 'Tablet', 'Portable tablet', 300.00, 20),
(4, 'Headphones', 'Noise-canceling', 150.00, 30),
(5, 'TV', '4K Smart TV', 900.00, 5),
(6, 'Coffee Maker', 'Automatic coffee maker', 50.00, 25),
(7, 'Refrigerator', 'Energy-efficient', 700.00, 10),
(8, 'Microwave Oven', 'Countertop microwave', 80.00, 15),
(9, 'Blender', 'High-speed blender', 70.00, 20),
(10, 'Vacuum Cleaner', 'Bagless vacuum cleaner', 120.00, 10);

select * from Products;


INSERT INTO Customers (customer_id, name, email, password) 
VALUES 
(1, 'John Doe', 'johndoe@example.com', 'password1'),
(2, 'Jane Smith', 'janesmith@example.com', 'password2'),
(3, 'Robert Johnson', 'robert@example.com', 'password3'),
(4, 'Sarah Brown', 'sarah@example.com', 'password4'),
(5, 'David Lee', 'david@example.com', 'password5'),
(6, 'Laura Hall', 'laura@example.com', 'password6'),
(7, 'Michael Davis', 'michael@example.com', 'password7'),
(8, 'Emma Wilson', 'emma@example.com', 'password8'),
(9, 'William Taylor', 'william@example.com', 'password9'),
(10, 'Olivia Adams', 'olivia@example.com', 'password10');




INSERT INTO Cart (cart_id, customer_id, product_id, quantity) 
VALUES 
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 3, 5, 3),
(4, 4, 8, 1),
(5, 5, 10, 2),
(6, 6, 2, 1),
(7, 7, 4, 2),
(8, 8, 6, 3),
(9, 9, 7, 1),
(10, 10, 9, 2);


INSERT INTO Orders (order_id, customer_id, order_date, total_price, shipping_address) 
VALUES 
(1, 1, '2024-01-01', 1600.00, '123 Main St, City'),
(2, 2, '2024-01-02', 300.00, '456 Elm St, Town'),
(3, 3, '2024-01-03', 2700.00, '789 Oak St, Village'),
(4, 4, '2024-01-04', 80.00, '101 Pine St, Suburb'),
(5, 5, '2024-01-05', 240.00, '234 Cedar St, District'),
(6, 6, '2024-01-06', 600.00, '567 Birch St, County'),
(7, 7, '2024-01-07', 300.00, '890 Maple St, State'),
(8, 8, '2024-01-08', 150.00, '321 Redwood St, Country'),
(9, 9, '2024-01-09', 700.00, '432 Spruce St, Province'),
(10, 10, '2024-01-10', 140.00, '765 Fir St, Territory');


INSERT INTO Order_items (order_item_id, order_id, product_id, quantity) 
VALUES 
(1, 1, 1, 2),
(2, 2, 3, 1),
(3, 3, 5, 3),
(4, 4, 8, 1),
(5, 5, 10, 2),
(6, 6, 2, 1),
(7, 7, 4, 2),
(8, 8, 6, 3),
(9, 9, 7, 1),
(10, 10, 9, 2);


--1. Update refrigerator product price to 800.
UPDATE Products SET price = 800.00 WHERE name = 'Refrigerator';

select * from Products;

--2. Remove all cart items for a specific customer.
DELETE FROM Cart WHERE customer_id = 1;

select * from Cart;

--3. Retrieve Products Priced Below $100.
select * from Products where price < 100;

--4. Find Products with Stock Quantity Greater Than 5.
select * from Products where StockQuantity > 5;

--5.Retrieve Orders with Total Amount Between $500 and $1000.
select * from Orders where total_price between 500 and 1000;

--6.Find Products which name end with letter ‘r’.
select name from Products where name like '%r';

--7.Retrieve Cart Items for Customer 5.
select p.product_id, name, description from Products p join Cart c on p.product_id = c.product_id where customer_id = 5; 
select * from Products;
select * from Cart;
select * from Customers;
select * from Orders;
select * from Order_items;

--8.Find Customers Who Placed Orders in 2023.
select * from Customers c join Orders o on c.customer_id = o.customer_id where YEAR(o.order_date) = '2023';

--9.Determine the Minimum Stock Quantity for Each Product Category
select name as ProductCategory, MIN(StockQuantity) as MinStockQuantity from Products group by name;

--10.Calculate the Total Amount Spent by Each Customer:
select c.customer_id, c.name as Customer_name, SUM(total_price) as totalAmountSpent from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name order by totalAmountSpent;

--11.Find the Average Order Amount for Each Customer:
select c.customer_id, c.name as Customer_name, AVG(total_price) as avgAmountSpent from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name order by avgAmountSpent;

--12. Count the Number of Orders Placed by Each Customer:
SELECT customer_id, COUNT(*) AS num_orders_placed FROM Orders GROUP BY customer_id;

--13.Find the Maximum Order Amount for Each Customer:
select c.customer_id, c.name as Customer_name, MAX(total_price) as maxOrderAmount from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name;

--14.Get Customers Who Placed Orders Totaling Over $1000.
select c.customer_id, c.name as Customer_name, o.total_price from Customers c join Orders o on c.customer_id = o.customer_id group by c.customer_id, c.name, o.total_price having SUM(o.total_price)>1000.00; 

--15. Subquery to Find Products Not in the Cart.
select name as product_name from Products where product_id not in (select distinct product_id from cart);

--16.Subquery to Find Customers Who Haven't Placed Orders:
select * from Customers where customer_id not in (select distinct customer_id from orders);

--17.Subquery to Calculate the Percentage of Total Revenue for a Product:
select  product_id, name, (sum(total_price)/(select sum(total_price)from orders))*100 as revenue_percentage from Orders o join Products p on p.product_id = o.order_id group by product_id, name;

--18.Subquery to Find Products with Low Stock:
select * from Products where StockQuantity< (select AVG(StockQuantity) from Products);

--19. Subquery to Find Customers Who Placed High-Value Orders:
select customer_id, name, email from customers where customer_id in (select customer_id from Orders where total_price>1000.00);