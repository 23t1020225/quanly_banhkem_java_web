<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Bánh - Admin Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css"/>
        <style>
            /* Các style bổ sung cho form thêm bánh */
            .add-product-card {
                background-color: white;
                border-radius: 12px;
                padding: 25px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.05);
                margin-bottom: 30px;
                border: 1px solid #f0e4df;
            }
            .form-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }
            .form-group {
                display: flex;
                flex-direction: column;
                gap: 8px;
            }
            .form-group.full-width {
                grid-column: 1 / -1;
            }
            .form-group label {
                font-weight: 600;
                color: #5c4135;
                font-size: 14px;
            }
            .form-control {
                padding: 12px 15px;
                border: 1px solid #e0d0c8;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s ease;
                font-family: inherit;
            }
            .form-control:focus {
                outline: none;
                border-color: #a6745e;
                box-shadow: 0 0 0 3px rgba(166, 116, 94, 0.1);
            }
            .btn-submit {
                background-color: #4caf50;
                color: white;
                border: none;
                padding: 12px 25px;
                font-size: 15px;
                font-weight: bold;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s;
                margin-top: 10px;
            }
            .btn-submit:hover {
                background-color: #43a047;
            }
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
            /* Product List Table Adjustments */
            .product-img-cell img {
                width: 60px;
                height: 60px;
                object-fit: cover;
                border-radius: 8px;
            }
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
                    <a href="productManagement" class="active">
                        <i class="fa-solid fa-cake-candles"></i> Quản lý Bánh
                    </a>
                    <a href="accountManagement">
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
                    <h1><i class="fa-solid fa-cake-candles"></i> Quản Lý Bánh & Thêm Mới</h1>
                    <p>Thêm các loại bánh mới vào menu hoặc xem danh sách hiện tại.</p>
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

                <!-- ========== FORM THÊM SẢN PHẨM MỚI ========== -->
                <div class="add-product-card">
                    <h3 style="margin-bottom: 20px; color: #5c4135; border-bottom: 1px solid #f0e4df; padding-bottom: 10px;">
                        <i class="fa-solid fa-plus-circle"></i> Thêm Bánh Mới
                    </h3>
                    <form action="productManagement" method="POST" enctype="multipart/form-data">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="name">Tên bánh <span style="color:red">*</span></label>
                                <input type="text" id="name" name="name" class="form-control" required placeholder="Nhập tên bánh...">
                            </div>
                            <div class="form-group">
                                <label for="price">Giá bán (VNĐ) <span style="color:red">*</span></label>
                                <input type="number" id="price" name="price" class="form-control" required min="0" placeholder="VD: 55000">
                            </div>
                            <div class="form-group">
                                <label for="categoryId">Danh mục <span style="color:red">*</span></label>
                                <select id="categoryId" name="categoryId" class="form-control" required>
                                    <c:forEach items="${categoryList}" var="cat">
                                        <option value="${cat.id}">${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="image">Hình ảnh <span style="color:red">*</span></label>
                                <input type="file" id="image" name="image" class="form-control" accept="image/*" required>
                            </div>
                            <div class="form-group full-width">
                                <label for="description">Mô tả bánh</label>
                                <textarea id="description" name="description" class="form-control" rows="3" placeholder="Nhập mô tả nguyên liệu, hương vị..."></textarea>
                            </div>
                        </div>
                        <button type="submit" class="btn-submit">
                            <i class="fa-solid fa-save"></i> Lưu Thông Tin Bánh
                        </button>
                    </form>
                </div>

                <!-- ========== BẢNG DANH SÁCH BÁNH ========== -->
                <h3 style="margin-bottom: 15px; color: #5c4135;">Danh Sách Bánh Hiện Tại</h3>
                <div class="admin-table-wrapper">
                    <c:choose>
                        <c:when test="${empty productList}">
                            <div class="empty-state">
                                <i class="fa-solid fa-cake-candles"></i>
                                <p>Chưa có bánh nào trong hệ thống.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                        <div class="table-responsive">
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>Mã Bánh</th>
                                        <th>Hình ảnh</th>
                                        <th>Tên Bánh</th>
                                        <th>Giá</th>
                                        <th>Danh mục</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${productList}" var="p">
                                        <tr>
                                            <td><strong>#${p.id}</strong></td>
                                            <td class="product-img-cell">
                                                <img src="${pageContext.request.contextPath}/image/${p.image}" alt="${p.name}">
                                            </td>
                                            <td style="font-weight: 600; color: #5c4135;">${p.name}</td>
                                            <td style="color: #c62828; font-weight: bold;">
                                                <fmt:formatNumber value="${p.price}" pattern="#,###"/>đ
                                            </td>
                                            <td>
                                                <c:forEach items="${categoryList}" var="cat">
                                                    <c:if test="${cat.id == p.categoryId}">
                                                        <span class="admin-badge done" style="background-color: #f0e4df; color: #8d5d47;">${cat.name}</span>
                                                    </c:if>
                                                </c:forEach>
                                            </td>
                                            <td>
                                                <a href="editProduct?id=${p.id}" class="btn-action" style="background-color: #f57c00; color: white; padding: 6px 12px; border-radius: 4px; text-decoration: none; font-size: 13px; margin-right: 5px;"><i class="fa-solid fa-pen"></i> Sửa</a>
                                                <a href="productManagement?action=delete&id=${p.id}" class="btn-action" style="background-color: #d32f2f; color: white; padding: 6px 12px; border-radius: 4px; text-decoration: none; font-size: 13px;" onclick="return confirm('Bạn có chắc chắn muốn xóa bánh này không?');"><i class="fa-solid fa-trash"></i> Xóa</a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
        </div>
    </body>
</html>
