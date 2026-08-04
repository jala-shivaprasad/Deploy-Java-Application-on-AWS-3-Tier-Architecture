<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Employee Portal | Registration Confirmed"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="status-shell">
  <div class="surface-card status-card fade-up">
    <div class="status-icon-circle is-success">
      <i class="fa-solid fa-circle-check"></i>
    </div>
    <h3 class="mb-2">Account created</h3>
    <p class="text-muted-ep mb-4">Your employee account has been added successfully. You can now log in with your new username and password.</p>
    <a href="<%= request.getContextPath() %>/login" class="btn btn-teal px-4"><i class="fa-solid fa-right-to-bracket me-2"></i>Go to Login</a>
  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
