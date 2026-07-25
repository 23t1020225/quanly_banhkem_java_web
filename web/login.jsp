<%-- 
    Document   : login
    Created on : Jul 5, 2026, 4:51:11 PM
    Author     : tranv
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="CSS/login.css"/>
        <title>JSP Page</title>
    </head>
    <body>
        <div class="login-container">
            <div class="tab-header">
                <button class="tab-btn ${activeTab != 'register' ? 'active' : ''}" onclick="switchTab('login')">Đăng Nhập</button>
                <button class="tab-btn ${activeTab == 'register' ? 'active' : ''}" onclick="switchTab('register')">Đăng Ký</button>
            </div>

            <!-- Form Đăng Nhập -->
            <div id="loginForm" class="tab-content" style="${activeTab == 'register' ? 'display: none;' : 'display: block;'}">
                <c:if test="${not empty error}">
                    <p style="color: red; text-align: center;">${error}</p>
                </c:if>

                <form action="login" method="POST">
                    <div class="input-group">
                        <input type="text" id="username" name="username" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <input type="password" id="password" name="password" placeholder="Mật khẩu" required>
                    </div>
                    <button type="submit" class="btn-login">Đăng nhập</button>
                </form>
            </div>

            <!-- Form Đăng Ký -->
            <div id="registerForm" class="tab-content" style="${activeTab == 'register' ? 'display: block;' : 'display: none;'}">
                <c:if test="${not empty error_register}">
                    <p style="color: red; text-align: center;">${error_register}</p>
                </c:if>

                <form action="register" method="POST">
                    <div class="input-group">
                        <input type="text" name="fullname" placeholder="Họ và tên" required>
                    </div>
                    <div class="input-group">
                        <input type="email" name="username" placeholder="Email" required>
                    </div>
                    <div class="input-group">
                        <input type="password" name="password" placeholder="Mật khẩu" required>
                    </div>
                    <button type="submit" class="btn-login" style="background-color: #4CAF50; border: none; padding: 12px; width: 100%; border-radius: 4px; color: white; cursor: pointer; font-size: 16px;">Đăng ký</button>
                </form>
            </div>
        </div>

        <script>
            function switchTab(tabName) {
                // Ẩn nội dung
                document.getElementById('loginForm').style.display = 'none';
                document.getElementById('registerForm').style.display = 'none';
                
                // Xoá class active
                var buttons = document.getElementsByClassName('tab-btn');
                for (var i = 0; i < buttons.length; i++) {
                    buttons[i].classList.remove('active');
                }
                
                // Hiển thị nội dung
                if (tabName === 'login') {
                    document.getElementById('loginForm').style.display = 'block';
                    buttons[0].classList.add('active');
                } else {
                    document.getElementById('registerForm').style.display = 'block';
                    buttons[1].classList.add('active');
                }
            }
        </script>
    </body>
</html>
