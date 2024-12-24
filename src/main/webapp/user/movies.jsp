<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Movies - ABC Cinema</title>
    <link href="../css/home.css" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        .profile-icon {
            display: flex;
            align-items: center;
            padding: 5px 15px;
            cursor: pointer;
            border-radius: 30px;
            transition: background-color 0.3s;
        }
        
        .profile-icon:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }
        
        .avatar-circle {
            width: 35px;
            height: 35px;
            background-color: #e50914;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 10px;
        }
        
        .movie-card {
            transition: transform 0.3s;
            height: 100%;
        }
        
        .movie-card:hover {
            transform: translateY(-5px);
        }
        
        .card-img-top {
            height: 400px;
            object-fit: cover;
        }
        
        .avatar-circle-large {
            width: 50px;
            height: 50px;
            background-color: #e50914;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .avatar-circle i, .avatar-circle-large i {
            color: white;
            font-size: 1.2em;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .username {
            color: white;
            font-weight: 500;
            font-size: 0.95em;
        }
        
        .dropdown-menu {
            background-color: #141414;
            border: 1px solid rgba(255,255,255,0.1);
            padding: 8px;
            min-width: 250px;
        }
        
        .dropdown-item {
            color: #fff;
            padding: 8px 16px;
            border-radius: 4px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .dropdown-item:hover {
            background-color: rgba(255,255,255,0.1);
            color: #fff;
        }
        
        .dropdown-item i {
            width: 20px;
            text-align: center;
        }
        
        .dropdown-header {
            padding: 12px 16px;
            color: #fff;
        }
        
        .animate {
            animation-duration: 0.3s;
            animation-fill-mode: both;
        }
        
        .slideIn {
            animation-name: slideIn;
        }
        
        @keyframes slideIn {
            0% {
                transform: translateY(1rem);
                opacity: 0;
            }
            100% {
                transform: translateY(0rem);
                opacity: 1;
            }
        }
    </style>
</head>
<body class="bg-black text-white">
    <div class="container-fluid">
        <div class="row">
            <div class="col-1"></div>
            <div class="col-10">
                <header>
                    <nav class="navbar navbar-expand-lg my-3">
                        <div class="container-fluid">
                            <div class="logo">
                                <p>ABC CINEMA</p>
                            </div>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                <ul class="navbar-nav d-flex ms-auto mb-lg-0">
                                    <li class="nav-item">
                                        <a class="nav-link text-white mx-2" href="${pageContext.request.contextPath}/user/home2.jsp">Home</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active text-white mx-2" href="${pageContext.request.contextPath}/user/movies">Movies</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-white mx-2" href="#">My Bookings</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link text-white mx-2" href="#">Feedback</a>
                                    </li>
                                </ul>
                                
                                <div class="dropdown">
                                    <div class="profile-icon" data-bs-toggle="dropdown" aria-expanded="false">
                                        <div class="avatar-circle">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <div class="user-info">
                                            <span class="username">
                                                ${fn:substring(sessionScope.user.username, 0, 1).toUpperCase()}${fn:substring(sessionScope.user.username, 1, -1).toLowerCase()}
                                            </span>
                                            <i class="fas fa-chevron-down"></i>
                                        </div>
                                    </div>
                                    <ul class="dropdown-menu dropdown-menu-end animate slideIn">
                                        <li class="dropdown-header">
                                            <div class="d-flex align-items-center">
                                                <div class="avatar-circle-large">
                                                    <i class="fas fa-user"></i>
                                                </div>
                                                <div class="ms-3">
                                                    <h6 class="mb-0">${sessionScope.user.username}</h6>
                                                    <small class="text-muted">${sessionScope.user.email}</small>
                                                </div>
                                            </div>
                                        </li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item" href="#"><i class="fas fa-user-circle"></i> My Profile</a></li>
                                        <li><a class="dropdown-item" href="#"><i class="fas fa-ticket-alt"></i> My Bookings</a></li>
                                        <li><a class="dropdown-item" href="#"><i class="fas fa-heart"></i> Favorites</a></li>
                                        <li><a class="dropdown-item" href="#"><i class="fas fa-cog"></i> Settings</a></li>
                                        <li><hr class="dropdown-divider"></li>
                                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/user/auth?action=logout">
                                            <i class="fas fa-sign-out-alt"></i> Logout
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </nav>
                </header>

                <div class="container mt-5">
                    <h1 class="gradient-text fw-bolder text-center mb-5">Latest Movies</h1>
                    
                    <div class="row row-cols-1 row-cols-md-3 g-4">
                        <c:forEach items="${movies}" var="movie">
                            <div class="col">
                                <div class="card text-bg-dark movie-card">
                                    <img src="${movie.posterUrl}" class="card-img-top" alt="${movie.title}">
                                    <div class="card-body">
                                        <h5 class="card-title">${movie.title}</h5>
                                        <p class="card-text">${fn:substring(movie.description, 0, 100)}...</p>
                                        <div class="d-flex justify-content-between align-items-center">
                                            <span class="badge bg-primary">${movie.status}</span>
                                            <a href="booking?movieId=${movie.movieId}" class="btn btn-primary">Book Now</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="col-1"></div>
        </div>
    </div>
</body>
</html>
