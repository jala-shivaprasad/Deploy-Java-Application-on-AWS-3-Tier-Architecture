<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Employee Portal | Register"); %>
<jsp:include page="/pages/common/header.jsp" />

<section class="auth-shell">
  <div class="auth-wrap fade-up">

    <!-- Decorative side -->
    <div class="auth-side">
      <div>
        <span class="badge-tag"><i class="fa-solid fa-id-badge"></i> Employee Portal</span>
        <h2 class="text-white mb-2">Join the directory.</h2>
        <p class="quote">Create your employee account to get a personal dashboard backed by our Amazon RDS employee directory.</p>
      </div>
      <div class="id-badge">
        <div class="id-stripe"></div>
        <div class="d-flex align-items-center gap-3 mb-3">
          <div class="id-avatar"><i class="fa-solid fa-user-plus"></i></div>
          <div class="flex-grow-1">
            <div class="id-line mb-2" style="width:80%;"></div>
            <div class="id-line" style="width:55%;"></div>
          </div>
        </div>
        <div class="id-line mb-2" style="width:100%;"></div>
        <div class="id-line mb-2" style="width:90%;"></div>
        <div class="id-line" style="width:40%;"></div>
      </div>
    </div>

    <!-- Form side -->
    <div class="auth-form-col">
      <span class="form-eyebrow">Create account</span>
      <h3 class="mb-1">Register a new employee</h3>
      <p class="text-muted-ep mb-4">Fill in your details to set up access.</p>

      <%
        Object errorAttr = request.getAttribute("errorMessage");
        boolean hasError = errorAttr != null && !String.valueOf(errorAttr).isEmpty();
        String fFirstName = request.getAttribute("firstName") != null ? String.valueOf(request.getAttribute("firstName")) : "";
        String fLastName = request.getAttribute("lastName") != null ? String.valueOf(request.getAttribute("lastName")) : "";
        String fEmail = request.getAttribute("email") != null ? String.valueOf(request.getAttribute("email")) : "";
        String fUserName = request.getAttribute("userName") != null ? String.valueOf(request.getAttribute("userName")) : "";
      %>
      <% if (hasError) { %>
      <div class="alert-ep alert-ep-error mb-4" role="alert" data-autohide="true">
        <i class="fa-solid fa-circle-exclamation"></i>
        <div>${errorMessage}</div>
      </div>
      <% } %>

      <form method="post" action="<%= request.getContextPath() %>/register" data-validate="true" novalidate>
        <div class="row g-3">
          <div class="col-sm-6">
            <label for="firstName" class="form-label">First Name</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-user field-icon"></i>
              <input type="text" class="form-control" id="firstName" name="firstName" placeholder="First name" value="<%= fFirstName %>" required autofocus>
              <div class="invalid-feedback">Please enter your first name.</div>
            </div>
          </div>
          <div class="col-sm-6">
            <label for="lastName" class="form-label">Last Name</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-user field-icon"></i>
              <input type="text" class="form-control" id="lastName" name="lastName" placeholder="Last name" value="<%= fLastName %>" required>
              <div class="invalid-feedback">Please enter your last name.</div>
            </div>
          </div>
          <div class="col-12">
            <label for="email" class="form-label">Email</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-envelope field-icon"></i>
              <input type="email" class="form-control" id="email" name="email" placeholder="you@example.com" value="<%= fEmail %>" required>
              <div class="invalid-feedback">Please enter a valid email address.</div>
            </div>
          </div>
          <div class="col-12">
            <label for="userName" class="form-label">Username</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-at field-icon"></i>
              <input type="text" class="form-control" id="userName" name="userName" placeholder="Choose a username" value="<%= fUserName %>" required minlength="3" pattern="[a-zA-Z0-9_.]{3,50}">
              <div class="invalid-feedback">Username must be 3-50 characters (letters, numbers, '.' or '_').</div>
            </div>
          </div>
          <div class="col-sm-6">
            <label for="password" class="form-label">Password</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-lock field-icon"></i>
              <input type="password" class="form-control" id="password" name="password" placeholder="Choose a password" value="" required minlength="6">
              <button type="button" class="toggle-password" data-target="password" aria-label="Show password">
                <i class="fa-solid fa-eye"></i>
              </button>
              <div class="invalid-feedback">Password must be at least 6 characters.</div>
            </div>
            <div class="password-strength mt-2" data-strength-for="password"></div>
          </div>
          <div class="col-sm-6">
            <label for="confirmPassword" class="form-label">Confirm Password</label>
            <div class="input-icon-group">
              <i class="fa-solid fa-lock field-icon"></i>
              <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Re-enter password" value="" required minlength="6" data-match="password">
              <button type="button" class="toggle-password" data-target="confirmPassword" aria-label="Show password">
                <i class="fa-solid fa-eye"></i>
              </button>
              <div class="invalid-feedback">Passwords do not match.</div>
            </div>
          </div>
        </div>

        <button type="submit" class="btn btn-teal w-100 mt-4 btn-loading">
          <span class="btn-text">
            <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
            <span class="btn-label"><i class="fa-solid fa-user-plus me-1"></i> Create Account</span>
          </span>
        </button>

        <p class="text-center text-muted-ep mt-4 mb-0">
          Already registered? <a href="<%= request.getContextPath() %>/login" class="fw-semibold">Login Here</a>
        </p>
      </form>
    </div>
  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
