package com.dpt.demo.controller;

import java.util.Optional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dpt.demo.model.Employee;
import com.dpt.demo.service.EmployeeService;
import com.dpt.demo.web.SessionKeys;

/**
 * Handles login/logout.
 *
 * Replaces the previous "login" controller which:
 *  - kept the logged-in user id in an instance field on a singleton bean
 *    (a real bug: concurrent users could see each other's session state),
 *  - built its SQL query by string concatenation (SQL injection),
 *  - never actually established an HttpSession, so there was no real
 *    "logged in" state to protect other pages with.
 */
@Controller
public class AuthController {

    private static final String REMEMBER_ME_COOKIE = "epRememberUsername";
    private static final int REMEMBER_ME_MAX_AGE_SECONDS = 30 * 24 * 60 * 60; // 30 days

    private final EmployeeService employeeService;

    public AuthController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView loginForm(HttpServletRequest request,
                                   @CookieValue(value = REMEMBER_ME_COOKIE, required = false) String rememberedUsername) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute(SessionKeys.EMPLOYEE) != null) {
            return new ModelAndView("redirect:/dashboard");
        }
        ModelAndView mv = new ModelAndView("login");
        if (rememberedUsername != null) {
            mv.addObject("rememberedUsername", rememberedUsername);
        }
        return mv;
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public ModelAndView login(@RequestParam String userName,
                               @RequestParam String password,
                               @RequestParam(required = false) String rememberMe,
                               HttpServletRequest request,
                               HttpServletResponse response) {

        Optional<Employee> authenticated = employeeService.authenticate(userName, password);

        if (!authenticated.isPresent()) {
            ModelAndView mv = new ModelAndView("login");
            mv.addObject("errorMessage", "Invalid username or password. Please try again.");
            mv.addObject("rememberedUsername", userName);
            return mv;
        }

        // Fresh session on every login to avoid session fixation.
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }
        HttpSession session = request.getSession(true);
        session.setAttribute(SessionKeys.EMPLOYEE, authenticated.get());

        applyRememberMeCookie(response, request, rememberMe, userName);

        return new ModelAndView("redirect:/dashboard");
    }

    @RequestMapping(value = "/logout", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView logout(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        ModelAndView mv = new ModelAndView("redirect:/login");
        return mv;
    }

    private void applyRememberMeCookie(HttpServletResponse response, HttpServletRequest request,
                                        String rememberMe, String userName) {
        boolean remember = "on".equalsIgnoreCase(rememberMe) || "true".equalsIgnoreCase(rememberMe);
        Cookie cookie = new Cookie(REMEMBER_ME_COOKIE, userName);
        cookie.setHttpOnly(true);
        cookie.setPath(request.getContextPath().isEmpty() ? "/" : request.getContextPath());
        cookie.setMaxAge(remember ? REMEMBER_ME_MAX_AGE_SECONDS : 0);
        response.addCookie(cookie);
    }
}
