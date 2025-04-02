package com.qthanh.common;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

@ControllerAdvice
@EnableWebMvc
public class ExceptionController {

    private Log logger = LogFactory.getLog(ExceptionController.class);

    @ExceptionHandler(value = Exception.class)
    public String handleError(HttpServletRequest req, Exception exception, Model model) {
        // Log the full exception with stack trace
        logger.error("Request: " + req.getRequestURL() + " raised exception", exception);
        
        // Add error details to the model
        model.addAttribute("errorMessage", exception.getMessage());
        model.addAttribute("errorType", exception.getClass().getName());
        model.addAttribute("requestUrl", req.getRequestURL());
        
        return "error";
    }
}