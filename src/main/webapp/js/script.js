// Handle responsive charts
window.addEventListener('resize', function() {
    const charts = document.querySelectorAll('canvas');
    charts.forEach(chart => {
        if (chart.chart) {
            chart.chart.resize();
        }
    });
});

// Mobile navigation handling
document.addEventListener('DOMContentLoaded', function() {
    const mobileWidth = 575;
    const contextPath = document.querySelector('meta[name="contextPath"]').getAttribute('content');
    
    function handleMobileNav() {
        const nav = document.querySelector('.sidenav');
        if (window.innerWidth <= mobileWidth) {
            nav.classList.add('mobile-nav');
        } else {
            nav.classList.remove('mobile-nav');
        }
    }

    function confirmLogout() {
        const logoutModal = document.getElementById('logoutModal');
        logoutModal.style.display = 'block';
    }
    function handleLogout() {
        if (confirm('Are you sure you want to logout?')) {
            document.getElementById('logoutForm').submit();
        }
    }
    

    function executeLogout() {
        window.location.href = contextPath + '/admin/logout';
    }

    function closeLogoutModal() {
        const logoutModal = document.getElementById('logoutModal');
        logoutModal.style.display = 'none';
    }
    
    window.addEventListener('resize', handleMobileNav);
    handleMobileNav();

    // Expose functions globally
    window.confirmLogout = confirmLogout;
    window.executeLogout = executeLogout;
    window.closeLogoutModal = closeLogoutModal;
});
