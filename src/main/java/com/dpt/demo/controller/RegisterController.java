package com.dpt.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dpt.demo.service.RegistrationException;
import com.dpt.demo.service.EmployeeService;

/**
 * Handles new-employee registration.
 * Validation (required fields, email format, username format, password
 * length/confirmation, duplicate username/email) now lives in
 * EmployeeService so it's covered even if this controller isn't the only caller.
 */
@Controller
public class RegisterController {

    private final EmployeeService employeeService;

    public RegisterController(EmployeeService employeeService) {
        this.employeeService = employeeService;
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView registerForm() {
        return new ModelAndView("register");
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public ModelAndView register(@RequestParam String firstName,
                                  @RequestParam String lastName,
                                  @RequestParam String email,
                                  @RequestParam String userName,
                                  @RequestParam String password,
                                  @RequestParam(required = false) String confirmPassword) {
        try {
            employeeService.register(firstName, lastName, email, userName, password, confirmPassword);
            return new ModelAndView("redirect:/confirm");
        } catch (RegistrationException ex) {
            ModelAndView mv = new ModelAndView("register");
            mv.addObject("errorMessage", ex.getMessage());
            // Re-populate the non-sensitive fields so the user doesn't have to retype everything.
            mv.addObject("firstName", firstName);
            mv.addObject("lastName", lastName);
            mv.addObject("email", email);
            mv.addObject("userName", userName);
            return mv;
        }
    }
}
