<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Thanh Toán - Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="CSS/style.css"/>
        <style>
            .checkout-container {
                max-width: 800px;
                margin: 40px auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(155, 107, 85, 0.1);
            }
            .checkout-title {
                color: #9b6b55;
                text-align: center;
                margin-bottom: 30px;
                font-size: 28px;
            }
            .checkout-form {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }
            .checkout-form input {
                padding: 12px;
                border: 1px solid #e2cdc7;
                border-radius: 6px;
                font-size: 16px;
                color: #4a4a4a;
            }
            .order-summary {
                background-color: #fceeea;
                padding: 20px;
                border-radius: 8px;
                margin-top: 20px;
            }
            .order-summary-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 10px;
                font-size: 16px;
                color: #9b6b55;
            }
            .order-summary-total {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
                padding-top: 15px;
                border-top: 1px dashed #e58277;
                font-size: 20px;
                font-weight: bold;
                color: red;
            }
            .btn-confirm {
                background-color: #e58277;
                color: white;
                padding: 15px;
                border: none;
                border-radius: 25px;
                font-size: 18px;
                font-weight: bold;
                cursor: pointer;
                transition: background 0.3s;
                margin-top: 20px;
            }
            .btn-confirm:hover {
                background-color: #c7675c;
            }
        </style>
    </head>
    <body>
        <div class="checkout-container">
            <h2 class="checkout-title">Xác Nhận Đơn Hàng</h2>
            
            <c:if test="${sessionScope.account == null}">
                <div style="text-align: center; color: red;">
                    Bạn cần <a href="login" style="color: #9b6b55; text-decoration: underline;">đăng nhập</a> để thanh toán!
                </div>
            </c:if>

            <c:if test="${sessionScope.account != null}">
                <form action="checkout" method="post" class="checkout-form">
                    <input type="text" value="Họ và tên: ${sessionScope.account.fullname}" disabled>
                    <input type="text" value="Email: ${sessionScope.account.username}" disabled>
                    <input type="text" name="address" placeholder="Nhập địa chỉ giao hàng..." required>
                    <input type="text" name="phone" placeholder="Nhập số điện thoại..." required>
                    
                    <div class="order-summary">
                        <c:forEach items="${sessionScope.cart.items}" var="i">
                            <div class="order-summary-item">
                                <span>${i.product.name} (x${i.quantity})</span>
                                <span><fmt:formatNumber value="${i.product.price * i.quantity}" pattern="#,###"/>đ</span>
                            </div>
                        </c:forEach>
                        <div class="order-summary-total">
                            <span>Tổng thanh toán:</span>
                            <span><fmt:formatNumber value="${sessionScope.cart.totalMoney}" pattern="#,###"/>đ</span>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-confirm">Xác Nhận Đặt Hàng</button>
                    <a href="cart" style="text-align: center; display: block; margin-top: 15px; color: #9b6b55; text-decoration: underline;">Quay lại giỏ hàng</a>
                </form>
            </c:if>
        </div>
    </body>
</html>
