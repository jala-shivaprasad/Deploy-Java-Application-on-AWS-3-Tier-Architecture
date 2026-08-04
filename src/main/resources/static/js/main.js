/**
 * Employee Portal — shared front-end behaviour
 * - Password show/hide toggle
 * - Bootstrap-style client-side validation feedback
 * - Loading state on form submit buttons
 * No backend logic here: field names / endpoints are untouched.
 */
(function () {
  'use strict';

  document.addEventListener('DOMContentLoaded', function () {
    initPasswordToggles();
    initFormValidation();
    initAutoDismissAlerts();
    initPasswordStrength();
    initPasswordMatch();
  });

  /* ---- Show / hide password ---- */
  function initPasswordToggles() {
    document.querySelectorAll('.toggle-password').forEach(function (btn) {
      btn.addEventListener('click', function () {
        var targetId = btn.getAttribute('data-target');
        var input = document.getElementById(targetId);
        if (!input) return;
        var isHidden = input.type === 'password';
        input.type = isHidden ? 'text' : 'password';
        var icon = btn.querySelector('i');
        if (icon) {
          icon.classList.toggle('fa-eye', !isHidden);
          icon.classList.toggle('fa-eye-slash', isHidden);
        }
        btn.setAttribute('aria-label', isHidden ? 'Hide password' : 'Show password');
      });
    });
  }

  /* ---- Validation + loading button on submit ---- */
  function initFormValidation() {
    var forms = document.querySelectorAll('form[data-validate="true"]');
    forms.forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault();
          event.stopPropagation();
          form.classList.add('was-validated');
          var firstInvalid = form.querySelector(':invalid');
          if (firstInvalid) firstInvalid.focus();
          return;
        }
        form.classList.add('was-validated');
        var submitBtn = form.querySelector('button[type="submit"]');
        if (submitBtn && submitBtn.classList.contains('btn-loading')) {
          submitBtn.classList.add('is-loading');
          submitBtn.disabled = true;
        }
      });
    });
  }

  /* ---- Password strength meter (visual hint only - server enforces the real rule) ---- */
  function initPasswordStrength() {
    document.querySelectorAll('.password-strength[data-strength-for]').forEach(function (meter) {
      var input = document.getElementById(meter.getAttribute('data-strength-for'));
      if (!input) return;
      var bar = document.createElement('div');
      bar.className = 'password-strength-bar';
      var label = document.createElement('small');
      label.className = 'password-strength-label';
      meter.appendChild(bar);
      meter.appendChild(label);

      input.addEventListener('input', function () {
        var score = scorePassword(input.value);
        var levels = ['Too short', 'Weak', 'Fair', 'Good', 'Strong'];
        var colors = ['#dc2626', '#dc2626', '#f59e0b', '#0d9488', '#059669'];
        bar.style.width = (input.value.length === 0 ? 0 : (score + 1) * 20) + '%';
        bar.style.background = colors[score];
        label.textContent = input.value.length === 0 ? '' : levels[score];
      });
    });
  }

  function scorePassword(value) {
    var score = 0;
    if (value.length >= 6) score++;
    if (value.length >= 10) score++;
    if (/[A-Z]/.test(value) && /[a-z]/.test(value)) score++;
    if (/\d/.test(value)) score++;
    if (/[^A-Za-z0-9]/.test(value)) score++;
    return Math.min(score, 4);
  }

  /* ---- Confirm-password matching ---- */
  function initPasswordMatch() {
    document.querySelectorAll('[data-match]').forEach(function (confirmInput) {
      var original = document.getElementById(confirmInput.getAttribute('data-match'));
      if (!original) return;
      function check() {
        if (confirmInput.value && confirmInput.value !== original.value) {
          confirmInput.setCustomValidity('Passwords do not match.');
        } else {
          confirmInput.setCustomValidity('');
        }
      }
      confirmInput.addEventListener('input', check);
      original.addEventListener('input', check);
    });
  }

  /* ---- Auto-dismiss success/error alerts after a while ---- */
  function initAutoDismissAlerts() {
    document.querySelectorAll('.alert-ep[data-autohide="true"]').forEach(function (alertEl) {
      setTimeout(function () {
        alertEl.style.transition = 'opacity .4s ease';
        alertEl.style.opacity = '0';
        setTimeout(function () { alertEl.remove(); }, 400);
      }, 6000);
    });
  }
})();
