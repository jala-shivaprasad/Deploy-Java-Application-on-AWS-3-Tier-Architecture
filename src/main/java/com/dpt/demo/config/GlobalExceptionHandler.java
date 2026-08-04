package com.dpt.demo.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;

/**
 * Catches anything a controller doesn't handle itself (e.g. a database being
 * temporarily unreachable) so the user sees a friendly page instead of a raw
 * stack trace, and so nothing sensitive (SQL, connection strings) leaks to the browser.
 */
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    public ModelAndView handleAnyException(Exception ex) {
        log.error("Unhandled exception while processing request", ex);
        ModelAndView mv = new ModelAndView("error");
        mv.addObject("errorMessage", "Something went wrong on our end. Please try again in a moment.");
        return mv;
    }
}
