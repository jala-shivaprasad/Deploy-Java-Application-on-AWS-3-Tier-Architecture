<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Employee Portal | Something went wrong"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="status-shell">
  <div class="surface-card status-card fade-up">
    <div class="status-icon-circle is-error">
      <i class="fa-solid fa-triangle-exclamation"></i>
    </div>
    <h3 class="mb-2">Something went wrong</h3>
    <p class="text-muted-ep mb-4">${empty errorMessage ? "An unexpected error occurred. Please try again." : errorMessage}</p>
    <a href="<%= request.getContextPath() %>/home" class="btn btn-teal px-4"><i class="fa-solid fa-house me-2"></i>Back to Home</a>
  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
