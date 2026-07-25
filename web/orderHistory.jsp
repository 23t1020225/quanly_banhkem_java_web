<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lịch Sử Mua Hàng - Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="CSS/style.css"/>
        <style>
            .history-container {
                max-width: 1000px;
                margin: 40px auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(155, 107, 85, 0.1);
            }
            .history-title {
                color: #9b6b55;
                text-align: center;
                margin-bottom: 30px;
                font-size: 28px;
            }
            .history-table {
                width: 100%;
                border-collapse: collapse;
            }
            .history-table th {
                background-color: #fceeea;
                color: #9b6b55;
                padding: 15px;
                text-align: center;
                font-size: 15px;
            }
            .history-table td {
                padding: 15px;
                text-align: center;
                border-bottom: 1px solid #f5ece9;
                font-size: 14px;
            }
            .history-table tbody tr:hover {
                background-color: #fcf9f8;
            }
            .status-badge {
                display: inline-block;
                padding: 5px 15px;
                border-radius: 20px;
                font-size: 13px;
                font-weight: bold;
            }
            .status-badge1{
                display: inline-block;
                background-color: #e58277;
                color: black;
                border-radius: 20px;
                font-size: 14px;
                padding: 5px 15px;
                font-size: 13px;
                font-weight: bold;
            }
            .status-pending {
                background-color: #fff3cd;
                color: #856404;
            }
            .status-done {
                background-color: #d4edda;
                color: #155724;
            }
            .status-cancel {
                background-color: #f8d7da;
                color: #721c24;
            }
            .empty-history {
                text-align: center;
                padding: 40px;
                color: #9b6b55;
            }
            .btn-back {
                display: inline-block;
                margin-top: 20px;
                background-color: #e58277;
                color: white;
                padding: 12px 30px;
                border-radius: 25px;
                text-decoration: none;
                font-size: 16px;
                font-weight: bold;
                transition: background 0.3s;
            }
            .btn-back:hover {
                background-color: #c7675c;
            }
        </style>
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

        <div class="history-container">
            <h2 class="history-title"><i class="fa-solid fa-clock-rotate-left"></i> Lịch Sử Mua Hàng</h2>

            <c:if test="${empty orderList}">
                <div class="empty-history">
                    <h3>Bạn chưa có đơn hàng nào</h3>
                    <a href="index" class="btn-back">Mua sắm ngay</a>
                </div>
            </c:if>

            <c:if test="${not empty orderList}">
                <table class="history-table">
                    <thead>
                        <tr>
                            <th>Mã đơn</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderList}" var="o">
                            <tr>
                                <td><strong>#Cake${o.id}</strong></td>
                                <td>
                                    <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td style="color: red; font-weight: bold;">
                                    <fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/>đ
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${o.status == 'Pending'}">
                                            <span class="status-badge status-pending">Đang xử lý</span>
                                            <hr style="width: 80px; margin: 8px auto; border: none; border-top: 1.5px solid #e58277;">
                                            <a href="orderHistory?action=cancel&orderId=${o.id}" 
                                               onclick="return confirm('Bạn có chắc chắn muốn huỷ đơn hàng #${o.id} này không?');"
                                               style="display: inline-block; color: #dc3545; font-size: 13px; text-decoration: underline;">
                                                <span class="status-badge1">Huỷ đơn</span>
                                            </a>
                                        </c:when>
                                        <c:when test="${o.status == 'Done'}">
                                            <span class="status-badge status-done">Đã giao</span>
                                        </c:when>
                                        <c:when test="${o.status == 'Cancel'}">
                                            <span class="status-badge status-cancel">Đã huỷ</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">${o.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div style="text-align: center; margin-top: 30px;">
                    <a href="index" class="btn-back">Tiếp tục mua sắm</a>
                </div>
            </c:if>
        </div>
    </body>
</html>
