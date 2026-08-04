package com.dpt.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.dpt.demo.model.Employee;
import com.dpt.demo.web.SessionKeys;

/**
 * Employee dashboard. Guarded by AuthInterceptor (see config.WebMvcConfig),
 * so by the time we get here request.getSession() is guaranteed to hold an Employee.
 */
@Controller
public class DashboardController {

    @RequestMapping("/dashboard")
    public ModelAndView dashboard(HttpSession session) {
        Employee employee = (Employee) session.getAttribute(SessionKeys.EMPLOYEE);
        ModelAndView mv = new ModelAndView("user");
        mv.addObject("employee", employee);
        return mv;
    }

    @RequestMapping("/confirm")
    public ModelAndView confirm() {
        return new ModelAndView("confirm");
    }
}
