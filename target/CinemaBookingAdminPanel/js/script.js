// Add responsive handling for charts
window.addEventListener('resize', function() {
    const charts = document.querySelectorAll('canvas');
    charts.forEach(chart => {
        if (chart.chart) {
            chart.chart.resize();
        }
    });
});

// Handle mobile navigation
document.addEventListener('DOMContentLoaded', function() {
    const mobileWidth = 575;
    
    function handleMobileNav() {
        const nav = document.querySelector('.sidenav');
        if (window.innerWidth <= mobileWidth) {
            nav.classList.add('mobile-nav');
        } else {
            nav.classList.remove('mobile-nav');
        }
    }
    
    window.addEventListener('resize', handleMobileNav);
    handleMobileNav();
});
