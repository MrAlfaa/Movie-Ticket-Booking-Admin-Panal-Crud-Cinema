
<div class="sidenav">
    <div class="logo">
        <img src="../images/banner.png" alt="Cinema Logo" class="logo-img">
        <h2>Cinema Admin</h2>
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=dashboard" class="nav-item ${param.page == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=tickets" class="nav-item ${param.page == 'tickets' ? 'active' : ''}">
            <i class="fas fa-ticket-alt"></i> Ticket Management
        </a>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=users" class="nav-item ${param.page == 'users' ? 'active' : ''}">
            <i class="fas fa-users"></i> User Management
        </a>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=bookings" class="nav-item ${param.page == 'bookings' ? 'active' : ''}">
            <i class="fas fa-book"></i> Booking Management
        </a>
    </nav>
    <div class="logout">
        <a href="${pageContext.request.contextPath}/logout" class="nav-item">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>
