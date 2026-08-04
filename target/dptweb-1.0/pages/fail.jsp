<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Employee Portal | Login Failed"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="status-shell">
  <div class="surface-card status-card fade-up">
    <div class="status-icon-circle is-error">
      <i class="fa-solid fa-circle-xmark"></i>
    </div>
    <h3 class="mb-2">Login failed</h3>
    <p class="text-muted-ep mb-4">We couldn't sign you in with those credentials. Please check your username and password and try again.</p>
    <a href="<%= request.getContextPath() %>/login" class="btn btn-teal px-4"><i class="fa-solid fa-rotate-left me-2"></i>Try Again</a>
  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
