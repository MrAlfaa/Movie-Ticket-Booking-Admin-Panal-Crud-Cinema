<div class="sidenav">
    <div class="logo">
        <img src="../images/banner.png" alt="Cinema Logo" class="logo-img">
        <h2>Cinema Admin</h2>
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=dashboard" 
           class="nav-item ${param.page == 'dashboard' ? 'active' : ''}">
            <i class="fas fa-tachometer-alt"></i> Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=tickets" 
           class="nav-item ${param.page == 'tickets' ? 'active' : ''}">
            <i class="fas fa-ticket-alt"></i> Ticket Management
        </a>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=users" 
           class="nav-item ${param.page == 'users' ? 'active' : ''}">
            <i class="fas fa-users"></i> User Management
        </a>
        <a href="${pageContext.request.contextPath}/admin/navigation?page=bookings" 
           class="nav-item ${param.page == 'bookings' ? 'active' : ''}">
            <i class="fas fa-book"></i> Booking Management
        </a>
    </nav>
    <div class="logout">
    <form id="logoutForm" action="${pageContext.request.contextPath}/admin/logout" method="post" style="display: none;"></form>
    <a href="javascript:void(0)" onclick="handleLogout()" class="nav-item">
        <i class="fas fa-sign-out-alt"></i>
        <span>Logout</span>
    </a>
</div>

    
</div>

<!-- Logout Confirmation Modal -->
<div id="logoutModal" class="modal">
    <div class="modal-content">
        <h2><i class="fas fa-sign-out-alt"></i> Confirm Logout</h2>
        <p>Are you sure you want to logout?</p>
        <div class="modal-actions">
            <button onclick="executeLogout()" class="btn-logout">Logout</button>
            <button onclick="closeLogoutModal()" class="btn-cancel">Cancel</button>
        </div>
    </div>
</div>
