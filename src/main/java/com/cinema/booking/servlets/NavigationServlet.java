package com.cinema.booking.servlets;

import java.io.IOException;
import java.util.Arrays;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/navigation")
public class NavigationServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String page = request.getParameter("page");
        
        // Direct navigation for specific pages
        switch(page) {
            case "tickets":
                response.sendRedirect(request.getContextPath() + "/admin/tickets");
                return;
            case "dashboard":
                request.setAttribute("currentPage", "dashboard");
                request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
                return;
            default:
                if (!isValidPage(page)) {
                    response.sendRedirect(request.getContextPath() + "/admin/navigation?page=dashboard");
                    return;
                }
        }
        
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/admin/" + page + ".jsp").forward(request, response);
    }

    private boolean isValidPage(String page) {
        return Arrays.asList("dashboard", "tickets", "users", "bookings").contains(page);
    }
}
