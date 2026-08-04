<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% request.setAttribute("pageTitle", "Employee Portal | Change Password"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="section-pad pt-5">
  <div class="container" style="max-width:560px;">

    <div class="mb-4">
      <span class="section-eyebrow">Account</span>
      <h3 class="mt-2 mb-0">Change Password</h3>
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
      <form method="post" action="<%= request.getContextPath() %>/profile/change-password" data-validate="true" novalidate>
        <div class="mb-3">
          <label for="currentPassword" class="form-label">Current Password</label>
          <div class="input-icon-group">
            <i class="fa-solid fa-lock field-icon"></i>
            <input type="password" class="form-control" id="currentPassword" name="currentPassword" required autofocus>
            <button type="button" class="toggle-password" data-target="currentPassword" aria-label="Show password"><i class="fa-solid fa-eye"></i></button>
            <div class="invalid-feedback">Please enter your current password.</div>
          </div>
        </div>
        <div class="mb-3">
          <label for="newPassword" class="form-label">New Password</label>
          <div class="input-icon-group">
            <i class="fa-solid fa-key field-icon"></i>
            <input type="password" class="form-control" id="newPassword" name="newPassword" required minlength="6">
            <button type="button" class="toggle-password" data-target="newPassword" aria-label="Show password"><i class="fa-solid fa-eye"></i></button>
            <div class="invalid-feedback">Password must be at least 6 characters.</div>
          </div>
          <div class="password-strength mt-2" data-strength-for="newPassword"></div>
        </div>
        <div class="mb-3">
          <label for="confirmPassword" class="form-label">Confirm New Password</label>
          <div class="input-icon-group">
            <i class="fa-solid fa-key field-icon"></i>
            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required minlength="6" data-match="newPassword">
            <button type="button" class="toggle-password" data-target="confirmPassword" aria-label="Show password"><i class="fa-solid fa-eye"></i></button>
            <div class="invalid-feedback">Passwords do not match.</div>
          </div>
        </div>

        <div class="d-flex flex-wrap gap-3 mt-4">
          <button type="submit" class="btn btn-teal btn-loading">
            <span class="btn-text">
              <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
              <span class="btn-label"><i class="fa-solid fa-key me-1"></i> Update Password</span>
            </span>
          </button>
          <a href="<%= request.getContextPath() %>/profile" class="btn btn-outline-navy">Cancel</a>
        </div>
      </form>
    </div>

  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
