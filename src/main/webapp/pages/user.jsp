<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("pageTitle", "Employee Portal | Dashboard"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="section-pad pt-4">
  <div class="container">

    <div class="dash-header fade-up mb-5">
      <%
        Object usernameAttr = ((com.dpt.demo.model.Employee) request.getAttribute("employee")) != null
            ? ((com.dpt.demo.model.Employee) request.getAttribute("employee")).getUsername() : "";
        String usernameStr = usernameAttr != null ? String.valueOf(usernameAttr) : "";
        String initial = usernameStr.length() > 0 ? usernameStr.substring(0, 1).toUpperCase() : "U";
      %>
      <div class="avatar-circle"><%= initial %></div>
      <div>
        <div class="text-teal fw-semibold mb-1" style="font-size:.8rem; letter-spacing:.06em; text-transform:uppercase;">Employee Dashboard</div>
        <h2 class="text-white mb-1">Welcome, ${employee.fullName}</h2>
        <p class="mb-0" style="color:rgba(255,255,255,.7);">You're securely signed in to the Employee Portal.</p>
      </div>
    </div>

    <!-- ================= Employee Details ================= -->
    <div class="row g-4 mb-5">
      <div class="col-lg-8">
        <div class="surface-card p-4 p-md-5 h-100">
          <h5 class="mb-4"><i class="fa-solid fa-id-card text-teal me-2"></i>Employee Details</h5>
          <div class="row g-4">
            <div class="col-sm-6">
              <div class="text-muted-ep small mb-1">Full Name</div>
              <div class="fw-semibold">${employee.fullName}</div>
            </div>
            <div class="col-sm-6">
              <div class="text-muted-ep small mb-1">Employee ID</div>
              <div class="fw-semibold">#${employee.id}</div>
            </div>
            <div class="col-sm-6">
              <div class="text-muted-ep small mb-1">Username</div>
              <div class="fw-semibold">${employee.username}</div>
            </div>
            <div class="col-sm-6">
              <div class="text-muted-ep small mb-1">Email</div>
              <div class="fw-semibold">${employee.email}</div>
            </div>
            <div class="col-sm-6">
              <div class="text-muted-ep small mb-1">Registration Date</div>
              <div class="fw-semibold">
                <c:choose>
                  <c:when test="${not empty employee.regDate}">
                    <fmt:formatDate value="${employee.regDate}" pattern="MMM dd, yyyy" />
                  </c:when>
                  <c:otherwise>&mdash;</c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-lg-4">
        <div class="surface-card p-4 p-md-5 h-100 text-center d-flex flex-column align-items-center justify-content-center">
          <div class="avatar-circle mb-3" style="width:84px;height:84px;font-size:2rem;"><%= initial %></div>
          <h6 class="mb-1">${employee.fullName}</h6>
          <p class="text-muted-ep small mb-0">@${employee.username}</p>
        </div>
      </div>
    </div>

    <!-- ================= Quick Actions ================= -->
    <div class="mb-4">
      <span class="section-eyebrow">Quick access</span>
      <h4 class="mt-2 mb-4">Where would you like to go?</h4>
    </div>

    <div class="row g-4">
      <div class="col-6 col-md-4 col-lg-3">
        <a class="dash-tile d-block text-decoration-none" href="<%= request.getContextPath() %>/dashboard">
          <div class="dash-tile-icon"><i class="fa-solid fa-gauge"></i></div>
          <div class="fw-semibold">Dashboard</div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-3">
        <a class="dash-tile d-block text-decoration-none" href="<%= request.getContextPath() %>/profile">
          <div class="dash-tile-icon"><i class="fa-solid fa-user"></i></div>
          <div class="fw-semibold">My Profile</div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-3">
        <a class="dash-tile d-block text-decoration-none" href="<%= request.getContextPath() %>/profile/edit">
          <div class="dash-tile-icon"><i class="fa-solid fa-user-pen"></i></div>
          <div class="fw-semibold">Edit Profile</div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-3">
        <a class="dash-tile d-block text-decoration-none" href="<%= request.getContextPath() %>/profile/change-password">
          <div class="dash-tile-icon"><i class="fa-solid fa-key"></i></div>
          <div class="fw-semibold">Change Password</div>
        </a>
      </div>
      <div class="col-6 col-md-4 col-lg-3">
        <a class="dash-tile d-block text-decoration-none" href="<%= request.getContextPath() %>/logout">
          <div class="dash-tile-icon"><i class="fa-solid fa-right-from-bracket"></i></div>
          <div class="fw-semibold">Logout</div>
        </a>
      </div>
    </div>

  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
