package com.cinema.booking.servlets;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.booking.dao.MovieDAO;
import com.cinema.booking.model.Movie;

@WebServlet("/admin/movies")
public class MovieServlet extends HttpServlet {
    private MovieDAO movieDAO;
    
    public void init() {
        movieDAO = new MovieDAO();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Movie> movies = movieDAO.getAllMovies();
        request.setAttribute("movies", movies);
        request.getRequestDispatcher("/admin/movies.jsp").forward(request, response);
    }
}
