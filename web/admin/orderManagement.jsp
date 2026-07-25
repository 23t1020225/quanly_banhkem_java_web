<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản Lý Đơn Hàng - Admin Sugar Town</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css"/>
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
                    <a href="orderManagement" class="active">
                        <i class="fa-solid fa-clipboard-list"></i> Quản lý Đơn hàng
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

                <!-- Page Header -->
                <div class="admin-page-header">
                    <h1><i class="fa-solid fa-clipboard-list"></i> Quản Lý Đơn Hàng</h1>
                    <p>Xin chào, <strong>${sessionScope.account.fullname}</strong>! Dưới đây là tổng quan đơn hàng của cửa hàng.</p>
                </div>

                <!-- ========== DASHBOARD CARDS ========== -->
                <div class="dashboard-cards">
                    <div class="stat-card">
                        <div class="stat-icon total"><i class="fa-solid fa-box"></i></div>
                        <div class="stat-info">
                            <h3>${totalOrders}</h3>
                            <p>Tổng đơn hàng</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon pending"><i class="fa-solid fa-clock"></i></div>
                        <div class="stat-info">
                            <h3>${pendingOrders}</h3>
                            <p>Chờ xử lý</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon done"><i class="fa-solid fa-circle-check"></i></div>
                        <div class="stat-info">
                            <h3>${doneOrders}</h3>
                            <p>Đã giao</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon cancel"><i class="fa-solid fa-ban"></i></div>
                        <div class="stat-info">
                            <h3>${cancelOrders}</h3>
                            <p>Đã huỷ</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon revenue"><i class="fa-solid fa-coins"></i></div>
                        <div class="stat-info">
                            <h3><fmt:formatNumber value="${totalRevenue}" pattern="#,###"/>đ</h3>
                            <p>Doanh thu (Đã giao)</p>
                        </div>
                    </div>
                </div>

                <!-- ========== TOOLBAR: BỘ LỌC ========== -->
                <div class="admin-toolbar">
                    <div class="filter-group">
                        <a href="orderManagement" class="filter-btn ${currentFilter == 'all' ? 'active' : ''}">Tất cả</a>
                        <a href="orderManagement?filter=Pending" class="filter-btn ${currentFilter == 'Pending' ? 'active' : ''}">🟡 Chờ xử lý</a>
                        <a href="orderManagement?filter=Done" class="filter-btn ${currentFilter == 'Done' ? 'active' : ''}">🟢 Đã giao</a>
                        <a href="orderManagement?filter=Cancel" class="filter-btn ${currentFilter == 'Cancel' ? 'active' : ''}">🔴 Đã huỷ</a>
                    </div>
                </div>

                <!-- ========== BẢNG ĐƠN HÀNG ========== -->
                <div class="admin-table-wrapper">
                    <c:choose>
                        <c:when test="${empty orderList}">
                            <div class="empty-state">
                                <i class="fa-solid fa-inbox"></i>
                                <p>Chưa có đơn hàng nào.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>Mã ĐH</th>
                                        <th>Khách hàng</th>
                                        <th>Ngày đặt</th>
                                        <th>Tổng tiền</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${orderList}" var="o">
                                        <tr>
                                            <td><strong>#${o.id}</strong></td>
                                            <td><i class="fa-solid fa-user" style="color: #9b8578; margin-right: 5px;"></i>${o.customerName}</td>
                                            <td>
                                                <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td style="color: #c62828; font-weight: bold;">
                                                <fmt:formatNumber value="${o.totalMoney}" pattern="#,###"/>đ
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${o.status == 'Pending'}">
                                                        <span class="admin-badge pending">Chờ xử lý</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'Done'}">
                                                        <span class="admin-badge done">Đã giao</span>
                                                    </c:when>
                                                    <c:when test="${o.status == 'Cancel'}">
                                                        <span class="admin-badge cancel">Đã huỷ</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="admin-badge pending">${o.status}</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${o.status == 'Pending'}">
                                                    <div class="action-btns">
                                                        <a href="orderManagement?action=updateStatus&orderId=${o.id}&status=Done" 
                                                           class="btn-approve"
                                                           onclick="return confirm('Xác nhận ĐÃ GIAO đơn hàng #${o.id}?');">
                                                            <i class="fa-solid fa-check"></i> Duyệt
                                                        </a>
                                                        <a href="orderManagement?action=updateStatus&orderId=${o.id}&status=Cancel" 
                                                           class="btn-cancel-admin"
                                                           onclick="return confirm('Xác nhận HUỶ đơn hàng #${o.id}?');">
                                                            <i class="fa-solid fa-xmark"></i> Huỷ
                                                        </a>
                                                    </div>
                                                </c:if>
                                                <c:if test="${o.status != 'Pending'}">
                                                    <span style="color: #bbb; font-size: 13px;">—</span>
                                                </c:if>
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
