<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Tài Khoản - Admin Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css"/>
        <style>
            .alert {
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-weight: bold;
            }
            .alert-success {
                background-color: #e8f5e9;
                color: #2e7d32;
                border: 1px solid #c8e6c9;
            }
            .alert-danger {
                background-color: #ffebee;
                color: #c62828;
                border: 1px solid #ffcdd2;
            }
            .btn-action {
                padding: 6px 12px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                font-weight: bold;
                text-decoration: none;
                display: inline-block;
                color: white;
                font-size: 13px;
                transition: 0.3s;
            }
            .btn-lock { background-color: #f44336; }
            .btn-lock:hover { background-color: #d32f2f; }
            .btn-unlock { background-color: #4caf50; }
            .btn-unlock:hover { background-color: #388e3c; }
            .btn-disabled { background-color: #9e9e9e; cursor: not-allowed; }
            .status-badge {
                padding: 4px 8px;
                border-radius: 12px;
                font-size: 12px;
                font-weight: bold;
            }
            .status-active { background-color: #e8f5e9; color: #2e7d32; }
            .status-locked { background-color: #ffebee; color: #c62828; }
            .role-admin { background-color: #e3f2fd; color: #1565c0; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold;}
            .role-user { background-color: #f5f5f5; color: #616161; padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold;}
        </style>
    </head>
    <body>
        <div class="admin-wrapper">
            <!-- ========== SIDEBAR ========== -->
            <aside class="admin-sidebar">
                <div class="sidebar-header">
                    <h2>🍰 Sugar Town</h2>
                    <p>Admin Panel</p>
                </div>
                <nav class="sidebar-nav">
                    <a href="orderManagement">
                        <i class="fa-solid fa-clipboard-list"></i> Quản lý Đơn hàng
                    </a>
                    <a href="productManagement">
                        <i class="fa-solid fa-cake-candles"></i> Quản lý Bánh
                    </a>
                    <a href="accountManagement" class="active">
                        <i class="fa-solid fa-users"></i> Quản lý Tài khoản
                    </a>
                    <a href="index">
                        <i class="fa-solid fa-store"></i> Về trang chủ
                    </a>
                </nav>
                <div class="sidebar-footer">
                    <a href="logout">
                        <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                    </a>
                </div>
            </aside>

            <!-- ========== NỘI DUNG CHÍNH ========== -->
            <main class="admin-content">
                <div class="admin-page-header">
                    <h1><i class="fa-solid fa-users"></i> Quản Lý Tài Khoản</h1>
                    <p>Khóa hoặc mở khóa tài khoản người dùng.</p>
                </div>

                <c:if test="${not empty sessionScope.msgSuccess}">
                    <div class="alert alert-success">
                        <i class="fa-solid fa-check-circle"></i> ${sessionScope.msgSuccess}
                    </div>
                    <c:remove var="msgSuccess" scope="session" />
                </c:if>
                <c:if test="${not empty sessionScope.msgError}">
                    <div class="alert alert-danger">
                        <i class="fa-solid fa-triangle-exclamation"></i> ${sessionScope.msgError}
                    </div>
                    <c:remove var="msgError" scope="session" />
                </c:if>

                <div class="admin-table-wrapper">
                    <c:choose>
                        <c:when test="${empty accountList}">
                            <div class="empty-state">
                                <i class="fa-solid fa-users"></i>
                                <p>Chưa có tài khoản nào trong hệ thống.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                        <div class="table-responsive">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>Tên Đăng Nhập</th>
                                        <th>Họ Tên</th>
                                        <th>Vai Trò</th>
                                        <th>Trạng Thái</th>
                                        <th>Hành Động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${accountList}" var="acc">
                                        <tr>
                                            <td style="font-weight: 600; color: #5c4135;">${acc.username}</td>
                                            <td>${acc.fullname}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${acc.role == 1}">
                                                        <span class="role-admin">Admin</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="role-user">Khách hàng</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${acc.status == 'Locked'}">
                                                        <span class="status-badge status-locked">Đã Khóa</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-badge status-active">Hoạt động</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${acc.username == sessionScope.account.username}">
                                                        <button class="btn-action btn-disabled" title="Không thể tự khóa"><i class="fa-solid fa-ban"></i></button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <c:choose>
                                                            <c:when test="${acc.status == 'Locked'}">
                                                                <a href="accountManagement?action=unlock&username=${acc.username}" class="btn-action btn-unlock" onclick="return confirm('Bạn có chắc muốn mở khóa tài khoản này?');"><i class="fa-solid fa-lock-open"></i> Mở khóa</a>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <a href="accountManagement?action=lock&username=${acc.username}" class="btn-action btn-lock" onclick="return confirm('Bạn có chắc muốn khóa tài khoản này?');"><i class="fa-solid fa-lock"></i> Khóa</a>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </body>
</html>
