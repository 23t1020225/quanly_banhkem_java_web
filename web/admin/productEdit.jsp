<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sửa Thông Tin Bánh - Admin Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css"/>
        <style>
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
                background-color: #f57c00;
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
                background-color: #e65100;
            }
            .btn-cancel {
                background-color: #9e9e9e;
                color: white;
                border: none;
                padding: 12px 25px;
                font-size: 15px;
                font-weight: bold;
                border-radius: 8px;
                cursor: pointer;
                text-decoration: none;
                display: inline-block;
                margin-left: 10px;
            }
            .btn-cancel:hover {
                background-color: #757575;
            }
            .current-image {
                margin-top: 10px;
                width: 100px;
                height: 100px;
                object-fit: cover;
                border-radius: 8px;
                border: 2px solid #e0d0c8;
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
                    <h1><i class="fa-solid fa-pen-to-square"></i> Sửa Thông Tin Bánh</h1>
                    <p>Cập nhật thông tin chi tiết cho bánh #${product.id}.</p>
                </div>

                <div class="add-product-card">
                    <h3 style="margin-bottom: 20px; color: #5c4135; border-bottom: 1px solid #f0e4df; padding-bottom: 10px;">
                        <i class="fa-solid fa-edit"></i> Thông Tin Bánh
                    </h3>
                    <form action="editProduct" method="POST" enctype="multipart/form-data">
                        <input type="hidden" name="id" value="${product.id}">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="name">Tên bánh <span style="color:red">*</span></label>
                                <input type="text" id="name" name="name" class="form-control" required value="${product.name}">
                            </div>
                            <div class="form-group">
                                <label for="price">Giá bán (VNĐ) <span style="color:red">*</span></label>
                                <input type="number" id="price" name="price" class="form-control" required min="0" value="${product.price}">
                            </div>
                            <div class="form-group">
                                <label for="categoryId">Danh mục <span style="color:red">*</span></label>
                                <select id="categoryId" name="categoryId" class="form-control" required>
                                    <c:forEach items="${categoryList}" var="cat">
                                        <option value="${cat.id}" ${cat.id == product.categoryId ? 'selected' : ''}>${cat.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="image">Hình ảnh mới (Để trống nếu không muốn đổi)</label>
                                <input type="file" id="image" name="image" class="form-control" accept="image/*">
                                <p style="font-size: 13px; color: #757575; margin-top: 5px;">Ảnh hiện tại:</p>
                                <img src="${pageContext.request.contextPath}/image/${product.image}" class="current-image" alt="Current Image">
                            </div>
                            <div class="form-group full-width">
                                <label for="description">Mô tả bánh</label>
                                <textarea id="description" name="description" class="form-control" rows="4">${product.description}</textarea>
                            </div>
                        </div>
                        <div style="margin-top: 15px;">
                            <button type="submit" class="btn-submit">
                                <i class="fa-solid fa-save"></i> Cập Nhật Thông Tin
                            </button>
                            <a href="productManagement" class="btn-cancel">
                                Hủy Bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </body>
</html>
