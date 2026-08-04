<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Employee Portal | Login"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="auth-shell">
  <div class="auth-wrap fade-up">

    <!-- Decorative side -->
    <div class="auth-side">
      <div>
        <span class="badge-tag"><i class="fa-solid fa-shield-halved"></i> Employee Portal</span>
        <h2 class="text-white mb-2">Welcome back.</h2>
        <p class="quote">Sign in with the username and password you registered with to reach your employee dashboard.</p>
      </div>
      <div class="id-badge">
        <div class="id-stripe"></div>
        <div class="d-flex align-items-center gap-3 mb-3">
          <div class="id-avatar"><i class="fa-solid fa-user"></i></div>
          <div class="flex-grow-1">
            <div class="id-line mb-2" style="width:75%;"></div>
            <div class="id-line" style="width:50%;"></div>
          </div>
        </div>
        <div class="id-line mb-2" style="width:100%;"></div>
        <div class="id-line" style="width:65%;"></div>
      </div>
    </div>

    <!-- Form side -->
    <div class="auth-form-col">
      <span class="form-eyebrow">Sign in</span>
      <h3 class="mb-1">Login to your account</h3>
      <p class="text-muted-ep mb-4">Enter your credentials to continue.</p>

      <%
        Object errorMessageAttr = request.getAttribute("errorMessage");
        boolean hasError = errorMessageAttr != null && !String.valueOf(errorMessageAttr).isEmpty();
        Object rememberedAttr = request.getAttribute("rememberedUsername");
        String rememberedUsername = rememberedAttr != null ? String.valueOf(rememberedAttr) : "";
      %>
      <% if (hasError) { %>
      <div class="alert-ep alert-ep-error mb-4" role="alert" data-autohide="true">
        <i class="fa-solid fa-circle-exclamation"></i>
        <div>${errorMessage}</div>
      </div>
      <% } %>

      <form method="post" action="<%= request.getContextPath() %>/login" data-validate="true" novalidate>
        <div class="mb-3">
          <label for="userName" class="form-label">Username</label>
          <div class="input-icon-group">
            <i class="fa-solid fa-user field-icon"></i>
            <input type="text" class="form-control" id="userName" name="userName" placeholder="Enter your username" value="<%= rememberedUsername %>" required autofocus>
            <div class="invalid-feedback">Please enter your username.</div>
          </div>
        </div>

        <div class="mb-3">
          <label for="password" class="form-label">Password</label>
          <div class="input-icon-group">
            <i class="fa-solid fa-lock field-icon"></i>
            <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" value="" required>
            <button type="button" class="toggle-password" data-target="password" aria-label="Show password">
              <i class="fa-solid fa-eye"></i>
            </button>
            <div class="invalid-feedback">Please enter your password.</div>
          </div>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-4">
          <div class="form-check">
            <input class="form-check-input" type="checkbox" id="rememberMe" name="rememberMe" <%= !rememberedUsername.isEmpty() ? "checked" : "" %>>
            <label class="form-check-label text-muted-ep" for="rememberMe" style="font-size:.9rem;">Remember me</label>
          </div>
        </div>

        <button type="submit" class="btn btn-teal w-100 btn-loading">
          <span class="btn-text">
            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
            <span class="btn-label"><i class="fa-solid fa-right-to-bracket me-1"></i> Login</span>
          </span>
        </button>

        <p class="text-center text-muted-ep mt-4 mb-0">
          New here? <a href="<%= request.getContextPath() %>/register" class="fw-semibold">Register Here</a>
        </p>
      </form>
    </div>
  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
