<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ Hàng - Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="CSS/style.css"/>
        <style>
            .cart-container {
                max-width: 1000px;
                margin: 40px auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(155, 107, 85, 0.1);
            }
            .cart-title {
                color: #9b6b55;
                text-align: center;
                margin-bottom: 30px;
                font-size: 28px;
            }
            .cart-table {
                width: 100%;
                border-collapse: collapse;
            }
            .cart-table th {
                background-color: #fceeea;
                color: #9b6b55;
                padding: 15px;
                text-align: center;
            }
            .cart-table td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #f5ece9;
            }
            .cart-product-info {
                display: flex;
                align-items: center;
                gap: 15px;
                text-align: left;
            }
            .cart-product-info img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
            }
            .cart-qty-btn {
                background-color: #fceeea;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
                border-radius: 5px;
                color: #9b6b55;
                font-weight: bold;
            }
            .cart-qty-btn:hover {
                background-color: #e58277;
                color: white;
            }
            .btn-remove {
                color: #ff4d4f;
                background: none;
                border: none;
                cursor: pointer;
                font-size: 18px;
            }
            .cart-summary {
                margin-top: 30px;
                text-align: right;
            }
            .cart-summary h3 {
                color: #9b6b55;
                font-size: 24px;
                margin-bottom: 15px;
            }
            .btn-checkout {
                background-color: #e58277;
                color: white;
                padding: 12px 30px;
                border-radius: 25px;
                text-decoration: none;
                font-size: 16px;
                font-weight: bold;
                display: inline-block;
                transition: background 0.3s;
            }
            .btn-checkout:hover {
                background-color: #c7675c;
            }
            .empty-cart {
                text-align: center;
                padding: 40px;
                color: #9b6b55;
            }
        </style>
    </head>
    <body>
        <header class="header">
            <div class="container header-wrapper">
                <div class="logo-area">
                    <a href="index" class="logo-text">
                        <img src="image/logo.png" alt="Logo Sugar Town" class="logo-img"/>
                    </a>
                </div>
                <nav class="navigation">
                    <ul class="nav-links">
                        <li><a href="index" class="nav-item">Trang Chủ</a></li>
                        <li class="nav-item-dropdown">
                            <a href="#" class="nav-item">Sản Phẩm <i class="fa-solid fa-chevron-down icon-arrow"></i></a>
                            <ul class="dropdown-menu">
                                <!-- Categories won't be listed unless passed to cart.jsp, but it's ok for now or we can hardcode -->
                                <c:forEach items="${listCategories}" var="cat">
                                    <li><a href="index#Category_${cat.id}">${cat.name}</a></li>
                                    </c:forEach>
                            </ul>
                        </li>
                        <li class="nav-item-dropdown">
                            <a href="#" class="nav-item">Bánh Kem <i class="fa-solid fa-chevron-down icon-arrow"></i></a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Bánh Kem Mini</a></li>
                                <li><a href="#">Bánh Sinh Nhật</a></li>
                                <li><a href="#">Bánh Sự Kiện</a></li>
                            </ul>
                        </li>
                        <li><a href="#" class="nav-item">Cửa Hàng</a></li>
                    </ul>
                </nav>
                <div class="header-right">
                    <div class="hotline-box">
                        <div class="hotline-icon">
                            <i class="fa-solid fa-phone-volume"></i>
                        </div>
                        <div class="hotline-text">
                            <span class="hotline-label">Liên hệ đặt món</span>
                            <a href="#" class="hotline-number">0392046613</a>
                        </div>
                    </div>
                    <div class="utility-icons">
                        <a href="#" class="icon-link" title="Tìm kiếm"><i class="fa-solid fa-magnifying-glass"></i></a>
                        <c:if test="${sessionScope.account == null}">
                            <a href="login" class="icon-link" title="Tài khoản"><i class="fa-regular fa-user"></i></a>
                        </c:if>
                        <c:if test="${sessionScope.account != null}">
                            <div class="nav-item-dropdown user-menu-box">
                                <a href="#" class="icon-link" style="background-color: #e58277; color: white">
                                    <i class="fa-solid fa-user-check"></i>
                                </a>
                                <ul class="dropdown-menu" style="margin-top: 5px; width: 200px; right: 0; left: auto;">
                                    <li><a href="#" style="font-weight: bold; color: #e58277;">Chào, ${sessionScope.account.fullname}</a></li>
                                        <c:if test="${sessionScope.account.role == 1}"> 
                                        <li><a href="orderManagement"><i class="fa-solid fa-clipboard-list"></i> Quản lý đơn hàng</a></li>
                                        </c:if>
                                        <c:if test="${sessionScope.account.role != 1}"> 
                                        <li><a href="orderHistory"><i class="fa-solid fa-clock-rotate-left"></i> Lịch sử mua hàng</a></li>
                                        </c:if>
                                    <li><a href="logout"><i class="fa-solid fa-right-from-bracket"></i> Đăng xuất</a></li>
                                </ul>
                            </div>
                        </c:if>
                        <a href="cart" class="icon-link cart-link" title="Giỏ hàng">
                            <i class="fa-solid fa-cart-shopping"></i>
                            <span class="cart-badge" id="cart-badge">
                                ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}
                            </span>
                        </a>
                    </div>
                </div>
            </div>
        </header>
        
        <div class="cart-container">
            <h2 class="cart-title">Giỏ Hàng Của Bạn</h2>
            
            <c:if test="${sessionScope.cart == null || sessionScope.cart.items.size() == 0}">
                <div class="empty-cart">
                    <h3>Giỏ hàng đang trống</h3>
                    <br>
                    <a href="index" class="btn-checkout">Quay lại mua sắm</a>
                </div>
            </c:if>
            
            <c:if test="${sessionScope.cart != null && sessionScope.cart.items.size() > 0}">
                <table class="cart-table">
                    <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Đơn giá</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${sessionScope.cart.items}" var="i">
                            <tr>
                                <td>
                                    <div class="cart-product-info">
                                        <img src="image/${i.product.image}" alt="${i.product.name}">
                                        <strong>${i.product.name}</strong>
                                    </div>
                                </td>
                                <td>
                                    <span style="color: red; font-weight: bold;">
                                        <fmt:formatNumber value="${i.product.price}" pattern="#,###"/>đ
                                    </span>
                                </td>
                                <td>
                                    <a href="cart?action=decrease&id=${i.product.id}" class="cart-qty-btn">-</a>
                                    <span style="margin: 0 10px; font-weight: bold;">${i.quantity}</span>
                                    <a href="cart?action=increase&id=${i.product.id}" class="cart-qty-btn">+</a>
                                </td>
                                <td>
                                    <span style="color: red; font-weight: bold;">
                                        <fmt:formatNumber value="${i.product.price * i.quantity}" pattern="#,###"/>đ
                                    </span>
                                </td>
                                <td>
                                    <a href="cart?action=remove&id=${i.product.id}" class="btn-remove"><i class="fa-solid fa-trash"></i></a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                
                <div class="cart-summary">
                    <h3>Tổng tiền: 
                        <span style="color: red;">
                            <fmt:formatNumber value="${sessionScope.cart.totalMoney}" pattern="#,###"/>đ
                        </span>
                    </h3>
                    <a href="checkout" class="btn-checkout">Thanh toán ngay</a>
                </div>
            </c:if>
        </div>
    </body>
</html>
