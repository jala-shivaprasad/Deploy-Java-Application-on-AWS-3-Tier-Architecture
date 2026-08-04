<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- ================= Shared Head + Navbar ================= -->
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><%= (request.getAttribute("pageTitle") != null) ? request.getAttribute("pageTitle") : "Employee Portal" %></title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Poppins:wght@600;700&display=swap" rel="stylesheet">
<!-- App styles -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg ep-navbar sticky-top">
  <div class="container">
    <a class="navbar-brand" href="<%= request.getContextPath() %>/home">
      <span class="brand-mark"><i class="fa-solid fa-id-badge"></i></span>
      Employee Portal
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#epNavContent" aria-controls="epNavContent" aria-expanded="false" aria-label="Toggle navigation">
      <i class="fa-solid fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="epNavContent">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-1">
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/home"><i class="fa-solid fa-house me-1"></i> Home</a></li>
        <c:choose>
          <c:when test="${not empty sessionScope.loggedInEmployee}">
            <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/dashboard"><i class="fa-solid fa-gauge me-1"></i> Dashboard</a></li>
            <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/profile"><i class="fa-solid fa-user me-1"></i> My Profile</a></li>
            <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
              <a class="nav-link btn-nav-cta d-inline-block px-3" href="<%= request.getContextPath() %>/logout"><i class="fa-solid fa-right-from-bracket me-1"></i> Logout</a>
            </li>
          </c:when>
          <c:otherwise>
            <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/login"><i class="fa-solid fa-right-to-bracket me-1"></i> Login</a></li>
            <li class="nav-item ms-lg-2 mt-2 mt-lg-0">
              <a class="nav-link btn-nav-cta d-inline-block px-3" href="<%= request.getContextPath() %>/register"><i class="fa-solid fa-user-plus me-1"></i> Register</a>
            </li>
          </c:otherwise>
        </c:choose>
      </ul>
    </div>
  </div>
</nav>

<main>
