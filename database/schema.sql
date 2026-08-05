CREATE DATABASE cake;
CREATE DATABASE admin;

\c cake

CREATE TABLE Categories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    customerName VARCHAR(255) NOT NULL,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    totalMoney DECIMAL(18,2) NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending'
);

CREATE TABLE OrderDetails (
    orderId INT NOT NULL,
    productId INT NOT NULL,
    quantity INT,
    price DECIMAL(18,2),
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES Orders(id)
);

CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(200) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    ImageURL TEXT,
    Description TEXT,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

INSERT INTO Categories (CategoryID, CategoryName) VALUES
(1, 'Bánh Nướng'),
(2, 'Bánh Lạnh'),
(3, 'Bánh Cookies'),
(4, 'Bánh Cấp Đông'),
(5, 'Noel'),
(6, 'Thức uống');

INSERT INTO Orders (id, customerName, orderDate, totalMoney, status) VALUES
(1, 'Khách hàng Sugar Town', '2026-07-07 23:43:53.780', 300000.00, 'Done'),
(2, 'staff', '2026-07-24 14:39:23.453', 300000.00, 'Cancel'),
(3, 'staff', '2026-07-24 15:22:23.040', 90000.00, 'Cancel'),
(1002, 'staff', '2026-07-25 15:46:56.847', 210000.00, 'Cancel'),
(1003, 'staff', '2026-07-25 19:06:59.687', 150000.00, 'Done');

INSERT INTO OrderDetails (orderId, productId, quantity, price) VALUES
(1, 1, 2, 150000.00),
(2, 1, 2, 150000.00),
(3, 2, 1, 35000.00),
(3, 4, 1, 55000.00),
(1002, 1, 1, 150000.00),
(1002, 7, 1, 60000.00),
(1003, 1, 1, 150000.00);

INSERT INTO Products (ProductID, ProductName, Price, ImageURL, Description, CategoryID) VALUES
(1, 'Bánh Macaron (Hộp)', 150000.00, 'macaron.jpg', 'Những chiếc bánh thơm giòn mang đến sự lựa chọn đa dạng...', 3),
(2, 'Bánh Sừng Trâu (Croissant)', 35000.00, 'croissant.jpg', 'Bánh sừng trâu nướng thơm lừng bơ Pháp, vỏ giòn xốp tuyệt hảo.', 1),
(3, 'Bánh Tart Trứng', 25000.00, 'tart_trung.jpg', 'Lớp vỏ ngàn lớp giòn rụm bọc lấy nhân kem trứng béo ngậy, nướng vàng ươm.', 1),
(4, 'Bánh Tiramisu Ý', 55000.00, 'tiramisu.jpg', 'Sự hòa quyện giữa phô mai Mascarpone mềm mịn và hương vị cà phê Espresso đậm đà.', 2),
(5, 'Mousse Chanh Dây', 45000.00, 'mousse_chanhday.jpg', 'Bánh mousse có vị chua ngọt thanh mát của chanh dây tươi, cực kỳ giải nhiệt.', 2),
(6, 'Cookies Chocochip', 40000.00, 'cookies_chocochip.jpg', 'Bánh quy bơ giòn tan kết hợp cùng những hạt socola chip nguyên chất đậm vị.', 3),
(7, 'Đế Bánh Pizza Mini', 60000.00, 'pizza_base.jpg', 'Đế bánh pizza làm sẵn tiện lợi, bảo quản đông lạnh, chỉ cần thêm topping và nướng.', 4),
(8, 'Bánh Khúc Cây (Buche de Noel)', 250000.00, 'khuc_cay.jpg', 'Bánh bông lan cuộn kem socola đặc trưng mùa lễ hội Giáng Sinh, trang trí bắt mắt.', 5),
(9, 'Bánh Nhà Gừng', 120000.00, 'gingerbread_house.jpg', 'Ngôi nhà gừng thơm mùi quế và mật ong, được trang trí bằng đường icing xinh xắn.', 5),
(10, 'Trà Nhãn Hoa Nhài', 45000.00, 'tra_nhan.jpg', 'Thức uống cực fresh với nền trà hoa nhài thanh mát kết hợp cùng nhãn nhục ngọt dịu.', 6),
(11, 'Trà Măng Cụt', 50000.00, 'tra_mangcut.jpg', 'Đập tan cơn khát mùa hè với vị chua ngọt đặc trưng và topping thịt măng cụt tươi.', 6);

\c admin

CREATE TABLE Account (
    username VARCHAR(50) PRIMARY KEY,
    password VARCHAR(50) NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    role INT NOT NULL
);

INSERT INTO Account (username, password, fullname, role) VALUES
('23t1020225@gmail.com', '123', 'admin1', 0),
('admin', '123', 'Trần Văn Huy', 1),
('staff', '123', 'Nguyễn Thị Nhân Viên', 2),
('tranvanhuy11042005@gmail.com', '123', 'huy háu hình', 0);
