-- 1️ Tạo Database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'ShoeStore')
CREATE DATABASE ShoeStore;
GO
USE ShoeStore;
GO

-- 2️ Bảng Khách Hàng
CREATE TABLE Customers (
    Customer_ID INT IDENTITY(1,1) PRIMARY KEY,
    User_name VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Full_name VARCHAR(100),
    Address TEXT,
    Phone_number VARCHAR(20)
);

-- 3️⃣ Bảng Đơn Hàng
CREATE TABLE Orders (
    Order_ID INT IDENTITY(1,1) PRIMARY KEY,
    Customer_ID INT,
    Order_date DATETIME DEFAULT GETDATE(),
    Total_amount DECIMAL(10,2) DEFAULT 0,
    Paid_Amount DECIMAL(10,2) DEFAULT 0,
    Status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
);

-- 4️⃣ Bảng Danh Mục Sản Phẩm
CREATE TABLE Categories (
    Category_ID INT IDENTITY(1,1) PRIMARY KEY,
    Category_name VARCHAR(50) UNIQUE NOT NULL
);

-- 5️⃣ Bảng Thương Hiệu
CREATE TABLE Brands (
    Brand_ID INT IDENTITY(1,1) PRIMARY KEY,
    Brand_name VARCHAR(50) UNIQUE NOT NULL
);

-- 6️⃣ Bảng Sản Phẩm
CREATE TABLE Products (
    Product_ID INT IDENTITY(1,1) PRIMARY KEY,
    Product_name VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10,2),
    Stock_quantity INT CHECK (Stock_quantity >= 0),
    Category_ID INT,
    Brand_ID INT,
    Image_URL VARCHAR(255),
    FOREIGN KEY (Category_ID) REFERENCES Categories(Category_ID),
    FOREIGN KEY (Brand_ID) REFERENCES Brands(Brand_ID)
);

-- 7️⃣ Bảng Chi Tiết Đơn Hàng
CREATE TABLE Order_Items (
    Order_Item_ID INT IDENTITY(1,1) PRIMARY KEY,
    Order_ID INT,
    Product_ID INT,
    Quantity INT CHECK (Quantity > 0),
    Price DECIMAL(10,2),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);

-- ======================= 🛒 THÊM DỮ LIỆU MẪU 🛒 =======================
INSERT INTO Customers (User_name, Password, Email, Full_name, Address, Phone_number)
VALUES 
('john_doe', '123', 'john@example.com', 'John Doe', '123 Main St', '0123456789'),
('jane_smith', '456', 'jane@example.com', 'Jane Smith', '456 Oak St', '0987654321'),
('Minh_An', '789', 'anne@example.com', 'Minh An', '37 Le Duan', '0945223881'),
('Viet_Quoc', '111', 'quoc@example.com', 'Viet Quoc', '56 Tran Tong', '0943232677');


INSERT INTO Categories (Category_name) VALUES ('Sneakers'), ('Football'), ('Running');
INSERT INTO Brands (Brand_name) VALUES ('Nike'), ('Adidas'), ('Puma');
-- Sản phẩm của Sneakers
INSERT INTO Products (Product_name, Description, Price, Stock_quantity, Category_ID, Brand_ID, Image_URL)
VALUES 
('Nike Air Max', 'Comfortable running shoes', 150.00, 50, 1, 1, 'nike_airmax.jpg'),
('Adidas Superstar', 'Classic streetwear shoes', 120.00, 40, 1, 2, 'adidas_superstar.jpg'),
('Puma Suede', 'Retro stylish sneakers', 110.00, 30, 1, 3, 'puma_suede.jpg');

-- Thêm 3 sản phẩm cho danh mục Football (Category_ID = 2)
INSERT INTO Products (Product_name, Description, Price, Stock_quantity, Category_ID, Brand_ID, Image_URL)
VALUES 
('Nike Mercurial', 'Lightweight football boots for speed', 200.00, 20, 2, 1, 'nike_mercurial.jpg'),
('Adidas Predator', 'Control-enhancing football cleats', 180.00, 15, 2, 2, 'adidas_predator.jpg'),
('Puma Future Z', 'Agile and responsive football boots', 170.00, 25, 2, 3, 'puma_future_z.jpg');

-- Thêm 3 sản phẩm cho danh mục Running (Category_ID = 3)
INSERT INTO Products (Product_name, Description, Price, Stock_quantity, Category_ID, Brand_ID, Image_URL)
VALUES 
('Nike Pegasus', 'Durable running shoes with great cushioning', 140.00, 35, 3, 1, 'nike_pegasus.jpg'),
('Adidas Ultraboost', 'High-energy return running shoes', 160.00, 30, 3, 2, 'adidas_ultraboost.jpg'),
('Puma Deviate Nitro', 'Responsive and lightweight running shoes', 150.00, 28, 3, 3, 'puma_deviate_nitro.jpg');



-- ======================= 📌 FUNCTION, TRIGGER, STORED PROCEDURE =======================

-- 🔹 Function: Lấy tổng số lượng sản phẩm theo thương hiệu
IF OBJECT_ID('GetBrandStock', 'FN') IS NOT NULL DROP FUNCTION GetBrandStock;
GO
CREATE FUNCTION GetBrandStock(@BrandID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalStock INT;
    SELECT @TotalStock = SUM(Stock_quantity) FROM Products WHERE Brand_ID = @BrandID;
    RETURN @TotalStock;
END;
GO

-- 🔹 Function: Tính tổng tiền của một đơn hàng
IF OBJECT_ID('CalculateOrderTotal', 'FN') IS NOT NULL DROP FUNCTION CalculateOrderTotal;
GO
CREATE FUNCTION CalculateOrderTotal(@OrderID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);
    SELECT @Total = SUM(Quantity * Price) FROM Order_Items WHERE Order_ID = @OrderID;
    RETURN @Total;
END;
GO

-- 🔹 Trigger: Cập nhật tồn kho khi đơn hàng được thêm
IF OBJECT_ID('UpdateStockOnOrder', 'TR') IS NOT NULL DROP TRIGGER UpdateStockOnOrder;
GO
CREATE TRIGGER UpdateStockOnOrder
ON Order_Items
AFTER INSERT
AS
BEGIN
    UPDATE P
    SET P.Stock_quantity = P.Stock_quantity - I.Quantity
    FROM Products P
    INNER JOIN inserted I ON P.Product_ID = I.Product_ID;
END;
GO

-- 🔹 Stored Procedure: Đặt Hàng
IF OBJECT_ID('PlaceOrder', 'P') IS NOT NULL DROP PROCEDURE PlaceOrder;
GO
CREATE PROCEDURE PlaceOrder
    @CustomerID INT,
    @ProductID INT,
    @Quantity INT
AS
BEGIN
    DECLARE @OrderID INT, @TotalAmount DECIMAL(10,2), @Stock INT;

    -- Kiểm tra số lượng hàng trong kho
    SELECT @Stock = Stock_quantity FROM Products WHERE Product_ID = @ProductID;
    IF @Stock < @Quantity
    BEGIN
        PRINT 'Không đủ hàng trong kho!';
        RETURN;
    END

    -- Tạo đơn hàng mới
    INSERT INTO Orders (Customer_ID, Order_date, Status, Total_amount, Paid_Amount)
    VALUES (@CustomerID, GETDATE(), 'Pending', 0, 0);
    SET @OrderID = SCOPE_IDENTITY();

    -- Thêm vào Order_Items
    INSERT INTO Order_Items (Order_ID, Product_ID, Quantity, Price)
    VALUES (@OrderID, @ProductID, @Quantity, (SELECT Price FROM Products WHERE Product_ID = @ProductID) * @Quantity);

    -- Cập nhật tổng tiền đơn hàng
    SELECT @TotalAmount = SUM(Quantity * Price) FROM Order_Items WHERE Order_ID = @OrderID;
    UPDATE Orders SET Total_amount = @TotalAmount WHERE Order_ID = @OrderID;
END;
GO

-- 🔹 Stored Procedure: Cập nhật thanh toán đơn hàng
IF OBJECT_ID('UpdatePayment', 'P') IS NOT NULL DROP PROCEDURE UpdatePayment;
GO
CREATE PROCEDURE UpdatePayment
    @OrderID INT,
    @AmountPaid DECIMAL(10,2)
AS
BEGIN
    UPDATE Orders
    SET Paid_Amount = Paid_Amount + @AmountPaid
    WHERE Order_ID = @OrderID;
END;
GO

-- 🔹 Stored Procedure: Lấy danh sách đơn hàng của khách hàng
IF OBJECT_ID('GetCustomerOrders', 'P') IS NOT NULL DROP PROCEDURE GetCustomerOrders;
GO
CREATE PROCEDURE GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT O.Order_ID, O.Order_date, O.Total_amount, O.Paid_Amount, O.Status
    FROM Orders O
    WHERE O.Customer_ID = @CustomerID
    ORDER BY O.Order_date DESC;
END;
GO
