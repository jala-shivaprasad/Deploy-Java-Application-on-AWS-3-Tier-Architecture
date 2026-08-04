<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setAttribute("pageTitle", "Employee Portal | Home"); %>
<jsp:include page="/pages/common/header.jsp" />

<!-- ================= Hero ================= -->
<section class="hero-section">
  <div class="container">
    <div class="row align-items-center g-5">
      <div class="col-lg-7 fade-up">
        <span class="hero-eyebrow"><i class="fa-solid fa-shield-halved"></i> Secure Employee Access</span>
        <h1 class="mb-3">Manage your employee account, all in one place.</h1>
        <p class="lead mb-4">Register once, and sign in anytime to access your employee dashboard &mdash; built on a resilient AWS 3-tier architecture with an Amazon RDS MySQL backend.</p>
        <div class="d-flex flex-wrap gap-3">
          <a href="<%= request.getContextPath() %>/register" class="btn btn-teal btn-lg"><i class="fa-solid fa-user-plus me-2"></i>Create Account</a>
          <a href="<%= request.getContextPath() %>/login" class="btn btn-lg" style="background:rgba(255,255,255,.1); color:#fff; border:1px solid rgba(255,255,255,.3);"><i class="fa-solid fa-right-to-bracket me-2"></i>Already registered? Login</a>
        </div>
      </div>
      <div class="col-lg-5 fade-up fade-up-delay-1">
        <div class="id-badge mx-auto" style="max-width:340px;">
          <div class="id-stripe"></div>
          <div class="d-flex align-items-center gap-3 mb-3">
            <div class="id-avatar">EP</div>
            <div class="flex-grow-1">
              <div class="id-line mb-2" style="width:70%;"></div>
              <div class="id-line" style="width:45%;"></div>
            </div>
          </div>
          <div class="id-line mb-2" style="width:100%;"></div>
          <div class="id-line mb-2" style="width:85%;"></div>
          <div class="id-line" style="width:60%;"></div>
          <div class="d-flex justify-content-between align-items-center mt-4 pt-3" style="border-top:1px solid rgba(255,255,255,.15);">
            <small style="color:rgba(255,255,255,.65);">Employee ID</small>
            <small class="text-teal fw-semibold">Verified <i class="fa-solid fa-circle-check"></i></small>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ================= Features ================= -->
<section class="section-pad">
  <div class="container">
    <div class="text-center mb-5">
      <span class="section-eyebrow">Why this portal</span>
      <h2 class="mt-2">Built for reliable employee access</h2>
    </div>
    <div class="row g-4">
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="fa-solid fa-database"></i></div>
          <h5>RDS-backed records</h5>
          <p class="text-muted-ep mb-0">Every account is stored securely in the Employee table on Amazon RDS MySQL, kept consistent across every request.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="fa-solid fa-server"></i></div>
          <h5>AWS 3-tier architecture</h5>
          <p class="text-muted-ep mb-0">Requests flow through an Application Load Balancer to EC2-hosted Tomcat, keeping the app available and scalable.</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="feature-card">
          <div class="feature-icon"><i class="fa-solid fa-lock"></i></div>
          <h5>Simple, secure sign-in</h5>
          <p class="text-muted-ep mb-0">A focused registration and login flow gets employees into their dashboard in seconds, on any device.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ================= CTA ================= -->
<section class="pb-5">
  <div class="container">
    <div class="surface-card p-5 text-center">
      <h3 class="mb-2">Already registered?</h3>
      <p class="text-muted-ep mb-4">Head to the login page to access your employee dashboard.</p>
      <a href="<%= request.getContextPath() %>/login" class="btn btn-teal btn-lg px-4"><i class="fa-solid fa-right-to-bracket me-2"></i>Login Here</a>
    </div>
  </div>
</section>

<jsp:include page="/pages/common/footer.jsp" />
