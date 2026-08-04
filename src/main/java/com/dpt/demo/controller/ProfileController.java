package com.dpt.demo.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dpt.demo.model.Employee;
import com.dpt.demo.service.EmployeeService;
import com.dpt.demo.service.InvalidPasswordException;
import com.dpt.demo.service.RegistrationException;
import com.dpt.demo.web.SessionKeys;

/**
 * View/edit profile and change password. Guarded by AuthInterceptor
 * (see config.WebMvcConfig) - every method here can assume a logged-in employee.
 */
@Controller
@RequestMapping("/profile")
public class ProfileController {

    private final EmployeeService employeeService;

    public ProfileController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @RequestMapping(method = RequestMethod.GET)
    public ModelAndView viewProfile(HttpSession session) {
        Employee employee = currentEmployee(session);
        ModelAndView mv = new ModelAndView("profile");
        mv.addObject("employee", employee);
        return mv;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public ModelAndView editForm(HttpSession session) {
        ModelAndView mv = new ModelAndView("editProfile");
        mv.addObject("employee", currentEmployee(session));
        return mv;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public ModelAndView editSubmit(HttpSession session,
                                    @RequestParam String firstName,
                                    @RequestParam String lastName,
                                    @RequestParam String email) {
        Employee employee = currentEmployee(session);
        try {
            Employee updated = employeeService.updateProfile(employee.getId(), firstName, lastName, email);
            session.setAttribute(SessionKeys.EMPLOYEE, updated);
            ModelAndView mv = new ModelAndView("profile");
            mv.addObject("employee", updated);
            mv.addObject("successMessage", "Your profile has been updated.");
            return mv;
        } catch (RegistrationException ex) {
            ModelAndView mv = new ModelAndView("editProfile");
            mv.addObject("employee", employee);
            mv.addObject("errorMessage", ex.getMessage());
            return mv;
        }
    }

    @RequestMapping(value = "/change-password", method = RequestMethod.GET)
    public ModelAndView changePasswordForm() {
        return new ModelAndView("changePassword");
    }

    @RequestMapping(value = "/change-password", method = RequestMethod.POST)
    public ModelAndView changePasswordSubmit(HttpSession session,
                                              @RequestParam String currentPassword,
                                              @RequestParam String newPassword,
                                              @RequestParam String confirmPassword) {
        Employee employee = currentEmployee(session);
        ModelAndView mv = new ModelAndView("changePassword");
        try {
            employeeService.changePassword(employee.getId(), currentPassword, newPassword, confirmPassword);
            mv.addObject("successMessage", "Your password has been changed successfully.");
        } catch (InvalidPasswordException | RegistrationException ex) {
            mv.addObject("errorMessage", ex.getMessage());
        }
        return mv;
    }

    private Employee currentEmployee(HttpSession session) {
        return (Employee) session.getAttribute(SessionKeys.EMPLOYEE);
    }
}
