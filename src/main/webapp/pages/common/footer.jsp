<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- ================= Shared Footer + Scripts ================= -->
</main>

<footer class="ep-footer">
  <div class="container">
    <div class="row gy-4">
      <div class="col-md-5">
        <div class="d-flex align-items-center gap-2 mb-2">
          <span class="brand-mark d-inline-flex" style="background:linear-gradient(135deg,#14b8a6,#0d9488);width:30px;height:30px;border-radius:8px;align-items:center;justify-content:center;">
            <i class="fa-solid fa-id-badge text-white" style="font-size:.85rem;"></i>
          </span>
          <strong>Employee Portal</strong>
        </div>
        <p class="mb-0">A secure, internal portal for employee registration and account access, running on AWS with a MySQL-backed employee directory.</p>
      </div>
      <div class="col-6 col-md-3">
        <strong class="d-block mb-2">Navigate</strong>
        <div class="d-flex flex-column gap-1">
          <a href="<%= request.getContextPath() %>/home">Home</a>
          <a href="<%= request.getContextPath() %>/login">Login</a>
          <a href="<%= request.getContextPath() %>/register">Register</a>
        </div>
      </div>
      <div class="col-6 col-md-4">
        <strong class="d-block mb-2">Connect</strong>
        <div>
          <a class="social-icon" href="#" aria-label="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
          <a class="social-icon" href="#" aria-label="GitHub"><i class="fa-brands fa-github"></i></a>
          <a class="social-icon" href="#" aria-label="Email"><i class="fa-solid fa-envelope"></i></a>
        </div>
      </div>
    </div>
    <hr class="footer-divider">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-center gap-2">
      <span>&copy; <%= java.time.Year.now() %> Employee Portal. All rights reserved.</span>
      <span class="d-flex align-items-center gap-2"><i class="fa-solid fa-shield-halved"></i> Hosted on AWS &middot; Secured with RDS MySQL</span>
    </div>
  </div>
</footer>

<!-- Bootstrap 5 JS bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- App scripts -->
<script src="<%= request.getContextPath() %>/js/main.js"></script>
</body>
</html>
