<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${product.name} - Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="CSS/style.css"/>
        <link rel="stylesheet" href="CSS/function_addbuy.css"/>
        <style>
            .product-detail-container {
                display: flex;
                flex-wrap: wrap;
                gap: 50px;
                padding: 40px;
                background-color: white;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(150, 77, 50, 0.05);
                margin-bottom: 50px;
            }
            .product-detail-img {
                flex: 1;
                min-width: 300px;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(166, 82, 56, 0.15);
            }
            .product-detail-img img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease;
            }
            .product-detail-img:hover img {
                transform: scale(1.05);
            }
            .product-detail-info {
                flex: 1;
                min-width: 300px;
                display: flex;
                flex-direction: column;
                justify-content: flex-start;
                padding-top: 20px;
            }
            .product-detail-info h1 {
                font-size: 42px;
                color: #a65238;
                margin-bottom: 15px;
                font-weight: 700;
            }
            .product-detail-price {
                font-size: 38px;
                color: #ff4d4f;
                font-weight: bold;
                margin-bottom: 25px;
            }
            .product-detail-desc {
                font-size: 18px;
                color: #666;
                line-height: 1.8;
                margin-bottom: 40px;
                text-align: justify;
                border-top: 1px dashed #e2cdc7;
                border-bottom: 1px dashed #e2cdc7;
                padding: 25px 0;
            }
            .btn-add-to-cart-large {
                background-color: #e58277;
                color: white;
                border: none;
                padding: 16px 35px;
                font-size: 20px;
                font-weight: bold;
                border-radius: 30px;
                cursor: pointer;
                transition: all 0.3s ease;
                display: inline-flex;
                align-items: center;
                gap: 12px;
                width: fit-content;
                box-shadow: 0 4px 15px rgba(229, 130, 119, 0.3);
            }
            .btn-add-to-cart-large:hover {
                background-color: #d8695d;
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(229, 130, 119, 0.5);
            }
            .breadcrumb {
                padding: 20px 0;
                font-size: 16px;
                color: #a48a7e;
                margin-bottom: 10px;
            }
            .breadcrumb a {
                color: #9b6b55;
                text-decoration: none;
                font-weight: bold;
            }
            .breadcrumb a:hover {
                color: #e58277;
            }
            .extra-info {
                margin-top: 30px;
                display: flex;
                gap: 20px;
                color: #9b6b55;
            }
            .extra-info-item {
                display: flex;
                align-items: center;
                gap: 8px;
                font-weight: 500;
                background-color: #fceeea;
                padding: 10px 15px;
                border-radius: 10px;
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
                                <c:forEach items="${listCategories}" var="cat">
                                    <li><a href="index#Category_${cat.id}">${cat.name}</a></li>
                                </c:forEach>
                            </ul>
                        </li>
                        <li><a href="#" class="nav-item">Cửa Hàng</a></li>
                    </ul>
                </nav>
                <div class="header-right">
                    <div class="utility-icons">
                        <a href="cart" class="icon-link cart-link" title="Giỏ hàng">
                            <i class="fa-solid fa-cart-shopping"></i>
                            <span class="cart-badge" id="cart-badge">
                                ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}
                            </span>
                        </a>
                        <c:if test="${sessionScope.account == null}">
                            <a href="login" class="icon-link" title="Tài khoản"><i class="fa-regular fa-user"></i></a>
                        </c:if>
                        <c:if test="${sessionScope.account != null}">
                            <div class="nav-item-dropdown user-menu-box">
                                <a href="#" class="icon-link" style="background-color: #e58277; color: white">
                                    <i class="fa-solid fa-user-check"></i>
                                </a>
                                <ul class="dropdown-menu" >
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
                    </div>
                </div>
            </div>
        </header>

        <main class="container">
            <div class="breadcrumb">
                <a href="index">Trang chủ</a> <i class="fa-solid fa-angle-right" style="font-size: 12px; margin: 0 8px;"></i> 
                Sản phẩm <i class="fa-solid fa-angle-right" style="font-size: 12px; margin: 0 8px;"></i> 
                ${product.name}
            </div>

            <div class="product-detail-container">
                <div class="product-detail-img">
                    <img src="image/${product.image}" alt="${product.name}" />
                </div>
                <div class="product-detail-info">
                    <h1>${product.name}</h1>
                    <div class="product-detail-price">
                        <fmt:formatNumber value="${product.price}" pattern="#,###"/>đ
                    </div>
                    <div class="product-detail-desc">
                        ${product.description}
                    </div>
                    <button type="button" class="btn-add-to-cart-large" onclick="addToCart(${product.id})" title="Thêm vào giỏ hàng">
                        <i class="fa-solid fa-cart-plus"></i> Thêm Vào Giỏ Hàng
                    </button>
                    
                    <div class="extra-info">
                        <div class="extra-info-item"><i class="fa-solid fa-truck-fast"></i> Giao hàng tận nơi</div>
                        <div class="extra-info-item"><i class="fa-solid fa-cake-candles"></i> Bánh tươi mỗi ngày</div>
                    </div>
                </div>
            </div>
        </main>
        
        <script src="JS/scrip.js"></script>
    </body>
</html>
