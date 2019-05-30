package com.lecture.lecturemanagement.login.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/security")
public class LoginController {

    private static final Logger LOGGER = LogManager.getLogger(LoginController.class);

    @RequestMapping("/signUp")
    public String signUp() {
        LOGGER.info("CALLED /security/signUp");
        return "security/signUp";
    }

    @RequestMapping("/login")
    public String loginForm(HttpServletRequest req) {

        LOGGER.info("CALLED /security/login");

        String referer = req.getHeader("Referer");
        req.getSession().setAttribute("prevPage", referer);

        return "security/login";
    }


}
