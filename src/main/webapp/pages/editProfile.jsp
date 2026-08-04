<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("pageTitle", "Employee Portal | Edit Profile"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="section-pad pt-5">
  <div class="container" style="max-width:640px;">

    <div class="mb-4">
      <span class="section-eyebrow">Account</span>
      <h3 class="mt-2 mb-0">Edit Profile</h3>
    </div>

    <c:if test="${not empty errorMessage}">
      <div class="alert-ep alert-ep-error mb-4" role="alert" data-autohide="true">
        <i class="fa-solid fa-circle-exclamation"></i>
        <div>${errorMessage}</div>
      </div>
    </c:if>

    <div class="surface-card p-4 p-md-5">
      <form method="post" action="<%= request.getContextPath() %>/profile/edit" data-validate="true" novalidate>
        <div class="row g-3">
          <div class="col-sm-6">
            <label for="firstName" class="form-label">First Name</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-user field-icon"></i>
              <input type="text" class="form-control" id="firstName" name="firstName" value="${employee.firstName}" required autofocus>
              <div class="invalid-feedback">Please enter your first name.</div>
            </div>
          </div>
          <div class="col-sm-6">
            <label for="lastName" class="form-label">Last Name</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-user field-icon"></i>
              <input type="text" class="form-control" id="lastName" name="lastName" value="${employee.lastName}" required>
              <div class="invalid-feedback">Please enter your last name.</div>
            </div>
          </div>
          <div class="col-12">
            <label for="email" class="form-label">Email</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-envelope field-icon"></i>
              <input type="email" class="form-control" id="email" name="email" value="${employee.email}" required>
              <div class="invalid-feedback">Please enter a valid email address.</div>
            </div>
          </div>
          <div class="col-12">
            <label class="form-label">Username</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-at field-icon"></i>
              <input type="text" class="form-control" value="${employee.username}" disabled>
            </div>
            <small class="text-muted-ep">Username cannot be changed.</small>
          </div>
        </div>

        <div class="d-flex flex-wrap gap-3 mt-4">
          <button type="submit" class="btn btn-teal btn-loading">
            <span class="btn-text">
              <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
              <span class="btn-label"><i class="fa-solid fa-floppy-disk me-1"></i> Save Changes</span>
            </span>
          </button>
          <a href="<%= request.getContextPath() %>/profile" class="btn btn-outline-navy">Cancel</a>
        </div>
      </form>
    </div>

  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
