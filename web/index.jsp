<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sugar Town - Tiệm Bánh Kem & Bánh Lạnh</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="CSS/style.css"/>
        <link rel="stylesheet" href="CSS/function_addbuy.css"/>
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
                                    <li><a href="#Category_${cat.id}">${cat.name}</a></li>
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
                            <a href="https://www.facebook.com/huy.tran.257658?locale=vi_VN" class="hotline-number">0392046613</a>
                        </div>
                    </div>

                    <div class="utility-icons">
                        <!-- Thanh Tìm Kiếm -->
                        <div class="search-box-wrapper">
                            <div class="search-input-container">
                                <input type="text" id="searchInput" class="search-input" placeholder="Tìm bánh..." autocomplete="off">
                                <button class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                            <div id="searchSuggestions" class="search-suggestions"></div>
                        </div>
                        
                        <script>
                            document.addEventListener('DOMContentLoaded', function() {
                                const searchInput = document.getElementById('searchInput');
                                const searchSuggestions = document.getElementById('searchSuggestions');

                                searchInput.addEventListener('input', function() {
                                    const keyword = this.value.trim();
                                    if (keyword.length > 0) {
                                        fetch('search-suggest?keyword=' + encodeURIComponent(keyword))
                                            .then(response => response.text())
                                            .then(html => {
                                                if(html.trim() !== "") {
                                                    searchSuggestions.innerHTML = html;
                                                    searchSuggestions.style.display = 'block';
                                                } else {
                                                    searchSuggestions.style.display = 'none';
                                                }
                                            });
                                    } else {
                                        searchSuggestions.style.display = 'none';
                                    }
                                });

                                // Ẩn khi click ra ngoài
                                document.addEventListener('click', function(e) {
                                    if (!searchInput.contains(e.target) && !searchSuggestions.contains(e.target)) {
                                        searchSuggestions.style.display = 'none';
                                    }
                                });
                            });
                        </script>
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
        <section class="banner-section">
            <div class="banner-container">

                <div class="banner" style="display: block;">
                    <img src="image/banner.jpg" alt="Banner 1"/>
                </div>

                <div class="banner">
                    <img src="image/banner1.jpg" alt="Banner 2"/>
                </div>

                <div class="banner">
                    <img src="image/banner3.jpg" alt="Banner 3"/>
                </div>
                <div class="dot-container">
                    <span class="dot active-dot" onclick="doiAnh(0 - viTri)"></span>
                    <span class="dot" onclick="doiAnh(1 - viTri)"></span>
                    <span class="dot" onclick="doiAnh(2 - viTri)"></span>
                </div>


            </div>
        </section>
        <script src="JS/scrip.js"></script>
        <section class="banner-menu">
            <div class="container">
                <div class="banner-thucdon">
                    <h2>THỰC ĐƠN TIÊU BIỂU</h2>
                </div>
                <div class="grip-layout">
                    <div class="grip-left">
                        <ul class="category-list">
                            <li><a se href="#sanpham_noibat" >Sản Phẩm Nổi Bật</a></li>
                                <c:forEach items="${listCategories}" var="cat">
                                <li><a href="#Category_${cat.id}">${cat.name}</a></li>
                                </c:forEach>
                        </ul>
                    </div>
                    <div class="grip-right">

                        <div class="box-loai-banh">
                            <h2 class="section-title" id="sanpham_noibat" style="font-size: 30px">Sản Phẩm Nổi Bật</h2>

                            <div id="productList" class="product-list" >
                                <c:forEach items="${listProducts}" var="c">
                                    <div class="product-item">
                                        <div class="product-img">
                                            <img src="image/${c.image}" alt="${c.name}"/>
                                        </div>
                                        <div class="product-info">
                                            <h4 style="font-size: 30px;font-weight: 500;">${c.name}</h4>
                                            <p style="font-size: 20px;padding: 10px 0px">${c.description}</p>

                                            <span class="price" style="font-size: 30px;color: red">
                                                <fmt:formatNumber value="${c.price}" pattern="#,###"/>đ
                                            </span>
                                            <button type="button" class="btn-add-cart" onclick="addToCart(${c.id})" title="Thêm vào giỏ hàng">
                                                <i class="fa-solid fa-plus"></i>
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="view-more-box" id="viewMoreBox" style="border-top: 1px dashed #ccc;">
                                <button id="btnViewMore" class="btn-view-more">Xem thêm <i class="fa-solid fa-chevron-down"></i></button>
                            </div>
                        </div> <div class="boc" style="width: 100%; clear: both;">
                            <c:forEach items="${listCategories}" var="c">

                                <div class="grip-right-1 box-loai-banh" id="Category_${c.id}">

                                    <h2 class="section-title"  style="font-size: 30px">${c.name}</h2>

                                    <div class="product-list">
                                        <c:forEach items="${listProducts}" var="sp">
                                            <c:if test="${sp.categoryId == c.id}">

                                                <div class="product-item">
                                                    <div class="product-img">
                                                        <img src="image/${sp.image}" alt="${sp.name}"/>
                                                    </div>

                                                    <div class="product-info">
                                                        <h4 style="font-size: 30px;font-weight: 500">${sp.name}</h4>
                                                        <p style="font-size: 20px;padding: 10px 0px">${sp.description}</p>

                                                        <span class="price" style="font-size: 30px;color: red">
                                                            <fmt:formatNumber value="${sp.price}" pattern="#,###"/>đ
                                                        </span>
                                                        <button type="button" class="btn-add-cart" onclick="addToCart('${sp.id}')" title="Thêm vào giỏ hàng">
                                                            <i class="fa-solid fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </div>

                                            </c:if>
                                        </c:forEach>
                                    </div>

                                </div> 

                            </c:forEach>
                        </div> </div>
                </div>
            </div>
        </div>
    </section>
        <section class="full-introduce">
            <div class="container-introduce">
                <div class="grip-introduce">
                    <div class="introduce-left">
                        <h2>Sugar Town – Tiệm bánh ngon với không gian ăn uống thoải mái</h2>
                        <p>Sugar Town là tiệm bánh ngon ở Sài Gòn được nhiều khách hàng lựa chọn nhờ sự kết hợp hài hòa giữa bánh chất lượng, 
                            nước uống đa dạng và không gian ngồi lại thoải mái. Với hệ thống 8 chi nhánh tại TP.HCM, 
                            Sugar Town không chỉ là nơi mua bánh mang đi mà còn là điểm hẹn quen thuộc cho gia đình, 
                            nhóm bạn hay những buổi gặp gỡ cuối tuần.</p>
                        <p>Các dòng bánh nổi bật tại Sugar Town gồm bánh nướng phô mai tan chảy – best seller, bánh cookies đa dạng và bánh lạnh nhẹ nhàng như su kem, tiramisu, panna cotta. Bên cạnh đó, menu nước uống dùng tại chỗ giúp trải nghiệm thưởng thức bánh trở nên trọn vẹn và thư giãn hơn.</p>
                    </div>
                    <div class="introduce-right">
                        <img src="image/home.jpg" alt="alt"/>
                        
                    </div>
                </div>
                
            </div>
            
        </section>
        <section class="full-footer-img">
            <div class="container-img-footer">
                <div class="img-footer parallax-footer" style="background-image: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)), url('image/Gemini_Generated_Image_mm34k2mm34k2mm34.png');">
                    <div class="footer-stats-overlay">
                        <div class="stat-item">
                            <i class="fa-solid fa-book-open"></i>
                            <div class="stat-text">
                                <h3>+120</h3>
                                <p>LOẠI BÁNH</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <i class="fa-solid fa-bell-concierge"></i>
                            <div class="stat-text">
                                <h3>+1000</h3>
                                <p>KHÁCH HÀNG MỖI NGÀY</p>
                            </div>
                        </div>
                        <div class="stat-item">
                            <i class="fa-solid fa-kitchen-set"></i>
                            <div class="stat-text">
                                <h3>+4</h3>
                                <p>NĂM KINH NGHIỆM</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
</body>
</html>