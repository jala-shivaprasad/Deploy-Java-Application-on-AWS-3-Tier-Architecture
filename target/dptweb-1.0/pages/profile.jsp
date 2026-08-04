<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("pageTitle", "Employee Portal | My Profile"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="section-pad pt-5">
  <div class="container" style="max-width:760px;">

    <div class="mb-4">
      <span class="section-eyebrow">Account</span>
      <h3 class="mt-2 mb-0">My Profile</h3>
    </div>

    <c:if test="${not empty successMessage}">
      <div class="alert-ep alert-ep-success mb-4" role="alert" data-autohide="true">
        <i class="fa-solid fa-circle-check"></i>
        <div>${successMessage}</div>
      </div>
    </c:if>
    <c:if test="${not empty errorMessage}">
      <div class="alert-ep alert-ep-error mb-4" role="alert" data-autohide="true">
        <i class="fa-solid fa-circle-exclamation"></i>
        <div>${errorMessage}</div>
      </div>
    </c:if>

    <div class="surface-card p-4 p-md-5">
      <div class="row g-4">
        <div class="col-sm-6">
          <div class="text-muted-ep small mb-1">First Name</div>
          <div class="fw-semibold">${employee.firstName}</div>
        </div>
        <div class="col-sm-6">
          <div class="text-muted-ep small mb-1">Last Name</div>
          <div class="fw-semibold">${employee.lastName}</div>
        </div>
        <div class="col-sm-6">
          <div class="text-muted-ep small mb-1">Username</div>
          <div class="fw-semibold">${employee.username}</div>
        </div>
        <div class="col-sm-6">
          <div class="text-muted-ep small mb-1">Employee ID</div>
          <div class="fw-semibold">#${employee.id}</div>
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

      <hr class="my-4" style="border-color:var(--border);">

      <div class="d-flex flex-wrap gap-3">
        <a href="<%= request.getContextPath() %>/profile/edit" class="btn btn-teal"><i class="fa-solid fa-user-pen me-2"></i>Edit Profile</a>
        <a href="<%= request.getContextPath() %>/profile/change-password" class="btn btn-outline-navy"><i class="fa-solid fa-key me-2"></i>Change Password</a>
        <a href="<%= request.getContextPath() %>/dashboard" class="btn btn-outline-navy"><i class="fa-solid fa-gauge me-2"></i>Back to Dashboard</a>
      </div>
    </div>

  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
